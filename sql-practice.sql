-- SQL PRACTICE DATABASE — a tiny shop
-- HOW TO USE (DB Browser for SQLite):
--   1. Install "DB Browser for SQLite" from sqlitebrowser.org
--   2. New Database  → save as  shop.db  (skip the "edit table" popup: Cancel)
--   3. Tab: "Execute SQL"  → paste this whole file  → press the ▶ (F5) to run it once
--   4. Tab: "Browse Data"  → pick a table from the dropdown to SEE the rows as a grid
--   5. Back in "Execute SQL", write your own queries below the seed and run them
-- Re-running this file is safe: it drops and rebuilds every table.

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id      INTEGER PRIMARY KEY,
  name    TEXT,
  country TEXT
);

CREATE TABLE products (
  id    INTEGER PRIMARY KEY,
  name  TEXT,
  price REAL
);

CREATE TABLE orders (
  id      INTEGER PRIMARY KEY,
  user_id INTEGER,          -- points at users.id  (foreign key)
  status  TEXT,             -- paid / pending / refunded
  created TEXT
);

CREATE TABLE order_items (
  id         INTEGER PRIMARY KEY,
  order_id   INTEGER,       -- points at orders.id
  product_id INTEGER,       -- points at products.id
  qty        INTEGER
);

INSERT INTO users VALUES
 (1,'Alice','UK'),
 (2,'Bob','US'),
 (3,'Carol','UK'),   -- never orders
 (4,'Dan','US'),
 (5,'Eve','PL');     -- never orders

INSERT INTO products VALUES
 (10,'Apple Juice',1.99),
 (11,'Banana Juice',1.99),
 (12,'Carrot Juice',2.49),
 (13,'Dragonfruit Juice',9.99),  -- never sold
 (14,'Elderberry Juice',3.50);

INSERT INTO orders VALUES
 (101,1,'paid','2026-07-01'),
 (102,1,'paid','2026-07-03'),
 (103,2,'refunded','2026-07-05'),
 (104,4,'paid','2026-07-08'),
 (105,4,'pending','2026-07-09'),
 (106,4,'paid','2026-07-10');

INSERT INTO order_items VALUES
 (1,101,10,2),   -- order 101: 2x Apple
 (2,101,11,1),   -- order 101: 1x Banana
 (3,102,10,1),
 (4,103,12,3),
 (5,104,10,1),
 (6,104,14,2),
 (7,105,11,5),
 (8,106,12,1);
-- note: product 13 (Dragonfruit) appears in NO order_items → never sold

-- ============================================================
-- WRITE YOUR QUERIES BELOW. Some to try (predict, then run):
-- ============================================================

-- Warm-up: see each table
-- SELECT * FROM users;
-- SELECT * FROM orders;

-- INNER vs LEFT (watch the row COUNT change — joins multiply by matches):
-- SELECT u.name, o.id FROM users u INNER JOIN orders o ON o.user_id = u.id;
-- SELECT u.name, o.id FROM users u LEFT  JOIN orders o ON o.user_id = u.id;

-- The classic: users who never ordered  (expect Carol, Eve)
-- SELECT u.name FROM users u
-- LEFT JOIN orders o ON o.user_id = u.id
-- WHERE o.id IS NULL;

-- Products never sold  (expect Dragonfruit) — needs the products↔order_items join:
-- SELECT p.name FROM products p
-- LEFT JOIN order_items oi ON oi.product_id = p.id
-- WHERE oi.id IS NULL;

-- Harder (aggregates + join): total quantity sold per product, most-sold first
-- SELECT p.name, SUM(oi.qty) AS sold
-- FROM products p
-- LEFT JOIN order_items oi ON oi.product_id = p.id
-- GROUP BY p.id
-- ORDER BY sold DESC;

-- Three-table join: which customer bought which product?
-- SELECT u.name AS customer, p.name AS product, oi.qty
-- FROM users u
-- JOIN orders o       ON o.user_id = u.id
-- JOIN order_items oi ON oi.order_id = o.id
-- JOIN products p     ON p.id = oi.product_id;
