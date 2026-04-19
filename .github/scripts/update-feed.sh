#!/usr/bin/env bash
set -Eeuo pipefail

LOG_DIR="${GITHUB_WORKSPACE:-$PWD}/logs/update-feed"
REPO="${REPO:-NotCraft/ArxivFeed}"
VERSION="${VERSION:-latest}"
MATCH="${MATCH:-arxivfeed-.+-x86_64-unknown-linux-musl.tar.gz$}"
RENAME="${RENAME:-arxivfeed.tgz}"
ARXIV_FALLBACK_IP="${ARXIV_FALLBACK_IP:-151.101.131.42}"
ARXIV_PROBE_URL="${ARXIV_PROBE_URL:-http://export.arxiv.org/api/query?search_query=cat:cs.DB&start=0&max_results=1&sortBy=lastUpdatedDate&sortOrder=descending}"

mkdir -p "${LOG_DIR}"

log() {
  printf '[%s] %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$*"
}

download_arxivfeed() {
  local attempt asset_url binary_path

  rm -f asset.url "${RENAME}" arxivfeed

  for attempt in 1 2 3; do
    log "Downloading ArxivFeed (attempt ${attempt}/3)"
    asset_url="$(
      curl -fsSL --retry 5 --retry-delay 2 --retry-all-errors \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: Bearer ${GITHUB_PAT}" \
        "https://api.github.com/repos/${REPO}/releases/${VERSION}" \
        | jq -r ".assets[] | select(.name | test(\"${MATCH}\")) | .url" \
        | head -n 1
    )" || asset_url=""

    if [ -n "${asset_url}" ] && [ "${asset_url}" != "null" ]; then
      printf '%s\n' "${asset_url}" > asset.url
      if curl -fsSL --retry 5 --retry-delay 2 --retry-all-errors \
        -H "Accept: application/octet-stream" \
        -H "Authorization: Bearer ${GITHUB_PAT}" \
        -o "${RENAME}" \
        "${asset_url}"; then
        break
      fi
    fi

    if [ "${attempt}" -eq 3 ]; then
      log "Failed to download ArxivFeed release asset"
      return 1
    fi

    sleep $((attempt * 5))
  done

  binary_path="$(tar -tf "${RENAME}" | awk '/\/arxivfeed$/ { print; exit }')"
  if [ -z "${binary_path}" ]; then
    log "Could not locate arxivfeed inside ${RENAME}"
    return 1
  fi

  tar -xzf "${RENAME}" --strip-components 1 "${binary_path}"
  chmod +x arxivfeed
}

install_stunnel() {
  local attempt

  if command -v stunnel4 >/dev/null 2>&1; then
    return 0
  fi

  for attempt in 1 2 3; do
    log "Installing stunnel4 (attempt ${attempt}/3)"
    if sudo apt-get update && sudo apt-get install -y --no-install-recommends stunnel4; then
      return 0
    fi

    if [ "${attempt}" -eq 3 ]; then
      log "Failed to install stunnel4"
      return 1
    fi

    sleep $((attempt * 5))
  done
}

resolve_arxiv_ip() {
  local ip

  ip="$(getent ahostsv4 export.arxiv.org | awk '{ print $1 }' | tail -n 1 || true)"
  if [ -z "${ip}" ]; then
    ip="${ARXIV_FALLBACK_IP}"
  fi

  printf '%s\n' "${ip}" > "${LOG_DIR}/arxiv.ip"
  printf '%s\n' "${ip}"
}

write_stunnel_config() {
  local ip="$1"

  cat > "${LOG_DIR}/stunnel.conf" <<EOF
client = yes
foreground = no
[arxiv]
accept = 127.0.0.1:80
connect = ${ip}:443
sni = export.arxiv.org
EOF

  sudo cp "${LOG_DIR}/stunnel.conf" /etc/stunnel/stunnel.conf
}

restart_tunnel() {
  local ip="$1"

  write_stunnel_config "${ip}"
  sudo pkill -x stunnel || true
  sudo pkill -x stunnel4 || true
  sudo stunnel4 /etc/stunnel/stunnel.conf
  sleep 2
}

ensure_hosts_override() {
  if ! grep -qE '^127\.0\.0\.1[[:space:]]+export\.arxiv\.org([[:space:]]|$)' /etc/hosts; then
    echo "127.0.0.1 export.arxiv.org" | sudo tee -a /etc/hosts >/dev/null
  fi
}

probe_arxiv() {
  curl -fsS --retry 2 --retry-delay 1 --max-time 20 "${ARXIV_PROBE_URL}" -o /dev/null
}

prepare_tunnel() {
  local ip attempt

  install_stunnel
  ip="$(resolve_arxiv_ip)"

  restart_tunnel "${ip}"
  ensure_hosts_override

  for attempt in 1 2 3; do
    log "Probing arXiv tunnel (attempt ${attempt}/3)"
    if probe_arxiv; then
      return 0
    fi

    if [ "${attempt}" -eq 3 ]; then
      log "Failed to establish a working arXiv tunnel"
      return 1
    fi

    sleep $((attempt * 5))
    restart_tunnel "${ip}"
  done
}

build_feed() {
  local attempt ip

  ip="$(cat "${LOG_DIR}/arxiv.ip")"

  for attempt in 1 2 3; do
    log "Running arxivfeed (attempt ${attempt}/3)"
    if ./arxivfeed 2>&1 | tee "${LOG_DIR}/build-attempt-${attempt}.log"; then
      cp "${LOG_DIR}/build-attempt-${attempt}.log" "${LOG_DIR}/build.log"
      return 0
    fi

    if [ "${attempt}" -eq 3 ]; then
      log "arxivfeed failed after ${attempt} attempts"
      return 1
    fi

    log "Refreshing arXiv tunnel before retry"
    restart_tunnel "${ip}"
    if ! probe_arxiv; then
      log "Probe still failing after tunnel refresh"
    fi
    sleep $((attempt * 10))
  done
}

main() {
  : "${GITHUB_PAT:?GITHUB_PAT is required}"

  log "Starting feed update"
  download_arxivfeed
  prepare_tunnel
  build_feed
  log "Feed update finished successfully"
}

main "$@"
