DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS users;
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

CREATE TABLE users (
  id SERIAL8 PRIMARY KEY,
  owner_first_name VARCHAR(255),
  owner_last_name VARCHAR(255),
  weekly_budget DECIMAL(12,2),
  current_budget DECIMAL(12,2),
  current_budget_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE transactions (
  id SERIAL8 PRIMARY KEY,
  amount DECIMAL(12,2),
  gbp_amount DECIMAL(12,2),
  description VARCHAR(255),
  merchant_id INT8 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_ID INT8 REFERENCES tags(id) ON DELETE CASCADE,
  user_id INT8 REFERENCES users(id) ON DELETE CASCADE,
  time_stamp TIMESTAMP DEFAULT now(),
  currency VARCHAR(255)
);
