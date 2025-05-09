CREATE TABLE categories (
  id VARCHAR(36) NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE courses (
  id VARCHAR(36) NOT NULL PRIMARY KEY,
  category_id VARCHAR(36) NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);
