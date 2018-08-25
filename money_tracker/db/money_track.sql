DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS tags;

CREATE TABLE tags (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE merchants (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE accounts (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  owner_first_name VARCHAR(255),
  owner_last_name VARCHAR(255),
  balance DECIMAL(12,2)
);

CREATE TABLE transactions (
  id SERIAL8 PRIMARY KEY,
  description VARCHAR(255),
  amount DECIMAL(12,2),
  tag_ID INT8 REFERENCES tags(id) ON DELETE CASCADE,
  merchant_id INT8 REFERENCES merchants(id) ON DELETE CASCADE,
  account_id INT8 REFERENCES accounts(id) ON DELETE CASCADE
);
