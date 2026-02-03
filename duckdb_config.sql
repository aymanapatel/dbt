-- Create blog table with standard schema
CREATE TABLE IF NOT EXISTS blog (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    slug VARCHAR UNIQUE NOT NULL,
    content TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    published_at TIMESTAMP,
    is_published BOOLEAN DEFAULT FALSE,
    view_count INTEGER DEFAULT 0,
    tags VARCHAR[]
);

-- Create authors table
CREATE TABLE IF NOT EXISTS authors (
    id INTEGER PRIMARY KEY,
    name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on frequently queried columns
CREATE INDEX IF NOT EXISTS idx_blog_published ON blog(is_published, published_at);
CREATE INDEX IF NOT EXISTS idx_blog_slug ON blog(slug);
CREATE INDEX IF NOT EXISTS idx_blog_author ON blog(author_id);
