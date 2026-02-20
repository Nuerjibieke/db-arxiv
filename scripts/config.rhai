// ==================== Original Keywords ====================
let titles_type = ["Dataset", "Survey", "Review", "Overview"];
let titles_model = ["BERT", "GPT", "Transformer"];
let titles_method = ["Pre-train", "Pretrain", "Prompt", "Self-Supervised"];

// ==================== Database Research Keywords ====================
// AI Native Database & Agent Database
let titles_ai_db = [
    "AI Native", "AI-Native", "Agent", "Agents", "Agentic", "Autonomous Agent", "Multi-Agent",
    "LLM", "ChatGPT", "GPT-4", "Llama",
    "Text-to-SQL", "Text2SQL", "NL2SQL", "Natural Language to SQL",
    "Cardinality Estimation",
    "Vector Database", "Vector Search", "Embedding", "RAG", "Retrieval-Augmented",
    "Foundation Model", "Large Language Model", "In-Context Learning",
    "Task Planning", "ReAct", "Chain-of-Thought", "Agent Framework"
];

// Database Core Tech Keywords
let titles_db_core = [
    "Query Optimization", "Query Processing", "Query Plan", "Cost Model",
    "Transaction", "ACID", "Concurrency Control", "MVCC", "Isolation",
    "Index", "B-Tree", "LSM-Tree", "Hash Index", "Bitmap Index",
    "Storage Engine", "Buffer Pool", "Buffer Management", "WAL", "Log-Structured",
    "Distributed Database", "Sharding", "Replication", "Consensus", "Raft", "Paxos",
    "Storage Disaggregation", "Shared-Nothing", "Shared-Storage"
];

// Emerging Database Tech
let titles_emerging = [
    "HTAP", "NewSQL", "NoSQL", "Time Series", "Graph Database", "Knowledge Graph",
    "Streaming", "Real-time", "In-Memory", "Serverless", "Cloud-Native",
    "Data Lake", "Lakehouse", "Data Warehouse", "OLAP", "OLTP",
    "Durable Execution", "Workload Management", "Resource Management",
    "Benchmark", "TPC"
];

let titles = titles_model + titles_method + titles_type + titles_ai_db + titles_db_core + titles_emerging;

// ==================== Authors: Original + Database Experts ====================
let authors_array = [
    // Original: AI Leaders
    "Yann LeCun", "Geoffrey Hinton", "Yoshua Bengio",
    
    // Database Turing Award Winners & Pioneers
    "Michael Stonebraker", "Jim Gray", "David DeWitt", "Hector Garcia-Molina",
    "Michael J. Carey", "Jeffrey D. Ullman", "Raghu Ramakrishnan",
    
    // Database Systems - Academic Leaders
    "Samuel Madden", "Tim Kraska", "Andy Pavlo", "Anastasia Ailamaki",
    "Jignesh Patel", "Arun Kumar", "Immanuel Trummer", "Stratos Idreos",
    "Thomas Neumann", "Viktor Leis", "Peter Boncz", "Guoliang Li",
    "Feifei Li", "Lei Chen", "Xiaofang Zhou", "Wenfei Fan",
    
    // Query Optimization & Learned Database
    "Guy Lohman", "Surajit Chaudhuri", "Vivek Narasayya", "Bolin Ding",
    "Ce Zhang", "Carsten Binnig", "Volker Markl", "Tilmann Rabl",
    
    // AI + Database Cross-domain
    "Ion Stoica", "Matei Zaharia", "Joseph Gonzalez", "Alvin Cheung",
    "Xin Luna Dong", "Jiawei Han", "Haixun Wang", "Wei Wang",
    "Mo Sha", "Bingsheng He", "Wook-Shin Han", "Kyuseok Shim",
    
    // AI Agents & LLM Systems
    "Graham Neubig", "Jianfeng Gao", "Yoav Goldberg", "Denny Zhou",
    "Jerry Liu", "Harrison Chase", "Shunyu Yao", "Lennon Cheng"
];

// ==================== Conferences: Database Top Venues & AI Conferences ====================
let conferences = [
    // Top Database & Data Mining (Tier 1 & Recommended)
    "SIGMOD", "VLDB", "ICDE", "PODS", "KDD", "CIDR", "EDBT", "SOCC",
    
    // Core AI & ML (Tier 1 & Highly Relevant for DBxAI)
    "NeurIPS", "NIPS", "ICLR", "ICML", "AAAI", "IJCAI", "KDD", "AISTATS",
    
    // NLP (Crucial for Large Language Models, Text2SQL)
    "ACL", "EMNLP", "NAACL", "COLING", "EACL",
    
    // Information Retrieval (Relevant for Vector DBs, RAG)
    "SIGIR", "WWW", "WSDM", "CIKM", "ECIR",
    
    // Systems & Architecture (Core DB Implementation)
    "SOSP", "OSDI", "EuroSys", "FAST", "ATC", "ASPLOS", "ISCA", "MICRO", "HPCA",
    
    // Other related DM/DB
    "ICDM", "SDM", "PAKDD", "DASFAA",
    
    // Database Top Journals (Shorthand representation in titles/abstracts)
    "TODS", "VLDB Journal", "TKDE", "SIGMOD Record", "PVLDB"
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