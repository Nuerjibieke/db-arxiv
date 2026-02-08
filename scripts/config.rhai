// ==================== 原有关键词配置 ====================
let titles_type = ["Dataset", "Survey", "Review", "Overview"];
let titles_model = ["BERT", "GPT", "Transformer"];
let titles_method = ["Pre-train", "Pretrain", "Prompt", "Self-Supervised"];

// ==================== 新增：数据库研究关键词 ====================
// AI Native Database & Agent Database
let titles_ai_db = [
    "AI Native", "AI-Native", "Agent", "LLM", "ChatGPT",
    "Text-to-SQL", "Text2SQL", "NL2SQL", "Natural Language to SQL",
    "Learned Index", "Learned Optimizer", "Learned Query", "Cardinality Estimation",
    "Vector Database", "Vector Search", "Embedding", "RAG", "Retrieval-Augmented",
    "Foundation Model", "Large Language Model", "In-Context Learning"
];

// 数据库核心技术关键词
let titles_db_core = [
    "Query Optimization", "Query Processing", "Query Plan", "Cost Model",
    "Transaction", "ACID", "Concurrency Control", "MVCC", "Isolation",
    "Index", "B-Tree", "LSM-Tree", "Hash Index", "Bitmap Index",
    "Storage Engine", "Buffer Pool", "Buffer Management", "WAL",
    "Distributed Database", "Sharding", "Replication", "Consensus", "Raft", "Paxos"
];

// 新兴数据库技术
let titles_emerging = [
    "HTAP", "NewSQL", "NoSQL", "Time Series", "Graph Database", "Knowledge Graph",
    "Streaming", "Real-time", "In-Memory", "Serverless", "Cloud-Native",
    "Data Lake", "Lakehouse", "Data Warehouse", "OLAP", "OLTP",
    "Benchmark", "TPC"
];

let titles = titles_model + titles_method + titles_type + titles_ai_db + titles_db_core + titles_emerging;

// ==================== 原有学者 + 新增数据库领域学者 ====================
let authors_array = [
    // 原有：AI领域大佬
    "Yann LeCun", "Geoffrey Hinton", "Yoshua Bengio",
    
    // 新增：数据库领域图灵奖得主 & 奠基人
    "Michael Stonebraker", "Jim Gray", "David DeWitt", "Hector Garcia-Molina",
    "Michael J. Carey", "Jeffrey D. Ullman", "Raghu Ramakrishnan",
    
    // 新增：数据库系统 - 学术界大佬
    "Samuel Madden", "Tim Kraska", "Andy Pavlo", "Anastasia Ailamaki",
    "Jignesh Patel", "Arun Kumar", "Immanuel Trummer", "Stratos Idreos",
    "Thomas Neumann", "Viktor Leis", "Peter Boncz", "Guoliang Li",
    "Feifei Li", "Lei Chen", "Xiaofang Zhou", "Wenfei Fan",
    
    // 新增：Query Optimization & Learned Database
    "Guy Lohman", "Surajit Chaudhuri", "Vivek Narasayya", "Bolin Ding",
    "Ce Zhang", "Carsten Binnig", "Volker Markl", "Tilmann Rabl",
    
    // 新增：AI + Database 交叉领域
    "Ion Stoica", "Matei Zaharia", "Joseph Gonzalez", "Alvin Cheung",
    "Xin Luna Dong", "Jiawei Han", "Haixun Wang", "Wei Wang",
    
    // 新增：中国数据库领域知名学者
    "周傲英", "李国良", "李飞飞", "陈雷", "王珊", "杜小勇", "金培权"
];

// ==================== 原有会议 + 新增数据库顶会顶刊 ====================
let conferences = [
    // AI
    "AAAI", "AAMAS", "ACM MM", "AISTATS", "ALT", "CEC", "ECAI", "FUZZ IEEE", "GECCO", "ICANN", "ICAPS", "ICCBR", "ICONIP", "ICRA", "ICTAI", "IJCAI", "IJCNN", "IROS", "KR", "KSEM", "SIGGRAPH", "STOC", "UAI", "PPSN", "PRICAI", "TAAI",
    // CV
    "3DV", "ACCV", "BMVC", "CVPR", "ECCV", "ICCV", "ICDAR", "ICIP", "ICME", "ICPR", "IEEE VIS", "MICCAI", "WACV",
    // DM (已包含大部分数据库会议)
    "AKBC", "APWeb", "CIKM", "DASFAA", "ECML-PKDD", "ICDE", "ICDM", "ICDT", "KDD", "LREC", "MDM", "PAKDD", "PODS", "RecSys", "SDM", "SIGMOD", "VLDB", "WSDM", "WWW", "EDBT", "CIDR",
    // IR
    "ECIR", "ESWC", "ICMR", "ICTIR", "ISWC", "SIGIR",
    // ML
    "ACML", "ECML", "ICLR", "ICML", "ML4H", "NeurIPS", "NIPS",
    // NLP
    "AACL", "ACL", "CCL", "COLING", "COLT", "CoNLL", "EACL", "EMNLP", "ICASSP", "INTERSPEECH", "NAACL", "NLPCC", "RepL4NLP", "SIGDIAL", "SemEval", "WANLP", "WASSA", "WOAH",
    // Arch
    "ASPLOS", "ATC", "DATE", "EuroSys", "FAST", "HPCA", "ISCA", "MICRO", "PPoPP", "SC", "SoCC",
    // System
    "FSE/ESEC", "ICSE", "ISSTA", "OSDI", "SOSP",
    // Security
    "ACSA", "AsiaCCS", "CCS", "DSN", "ESORICS", "EuroS&P", "ICICS", "NDSS", "RAID", "SP", "USENIX Security",
    
    // 新增：数据库顶刊
    "TODS", "VLDB Journal", "TKDE", "SIGMOD Record"
];

let start = conferences.shift();
let conferences_rg = conferences.reduce(|sum, v| sum + "|" + v, start);
let conferences_rg = "(" + conferences_rg + ")([\\s'-]*\\d+)?";

let start = titles.shift();
let title_rg = titles.reduce(|sum, v| sum + "|" + v, start);

let start = authors_array.shift();
let authors_rg = authors_array.reduce(|sum, v| sum + "|" + v, start);

export title_rg;
export authors_rg;
export conferences_rg;