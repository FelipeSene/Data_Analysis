DROP DATABASE IF EXISTS db_market;
CREATE DATABASE db_market;
USE db_market;

CREATE TABLE tb_customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    join_date DATE
);

CREATE TABLE tb_products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    brand VARCHAR(30),
    unit_price DECIMAL(10, 2)
);

CREATE TABLE tb_memoryRAM (
    ram_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    gb INT NOT NULL,
    gen VARCHAR(10) NOT NULL,
    velocity INT NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES tb_products(product_id)
);

CREATE TABLE tb_sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATETIME,
    customer_id INT,
    product_id INT,
    quantity_sold INT,
    final_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES tb_customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES tb_products(product_id)
);

INSERT INTO tb_products (product_name, category, brand, unit_price)
VALUES ('Kingston Fury Beast 8GB', 'RAM', 'Kingston', 45.00),
       ('Kingston Renegade 16GB', 'RAM', 'Kingston', 85.00),
       ('Corsair Vengeance 8GB', 'RAM', 'Corsair', 55.00),
       ('Corsair Dominator 32GB', 'RAM', 'Corsair', 190.00);

INSERT INTO tb_memoryRAM (product_id, gb, gen, velocity, stock_quantity)
VALUES (1, 8, 'DDR5', 4800, 10),
       (2, 16, 'DDR4', 3200, 15),
       (3, 8, 'DDR5', 6000, 2),
       (4, 32, 'DDR4', 3200, 20);

INSERT INTO tb_customers (first_name, last_name, email, city, join_date)
VALUES ('John', 'Doe', 'john@email.com', 'New York', '2023-01-15'),
       ('Alice', 'Smith', 'alice@email.com', 'Los Angeles', '2023-05-20'),
       ('Bob', 'Johnson', 'bob@email.com', 'Chicago', '2023-11-02');

INSERT INTO tb_sales (customer_id, product_id, quantity_sold, final_price, sale_date)
VALUES (1, 1, 2, 45.00, '2026-02-23 17:00:00'),
       (2, 4, 1, 190.00, '2026-02-26 17:00:00'),
       (3, 2, 1, 85.00, '2026-01-17 17:00:00');

SELECT * FROM tb_products;
SELECT * FROM tb_sales;

SELECT 
    s.sale_date,
    c.first_name,
    p.product_name,
    r.gen AS ram_generation,
    s.quantity_sold,
    (s.quantity_sold * s.final_price) AS total_revenue
FROM tb_sales s
JOIN tb_customers c ON s.customer_id = c.customer_id
JOIN tb_products p ON s.product_id = p.product_id
JOIN tb_memoryRAM r ON p.product_id = r.product_id;

SELECT
	tbproduto.product_name,
	tbmemoria.velocity,
	tbmemoria.stock_quantity
FROM
	tb_products tbproduto JOIN tb_memoryRAM tbmemoria ON tbproduto.product_id = tbmemoria.product_id
WHERE
	tbmemoria.gen='DDR5' AND tbmemoria.velocity<5000;
    
SELECT
	tbcompradores.email,
	tbvendas.sale_date
FROM
	tb_customers tbcompradores 
JOIN
	tb_sales tbvendas ON tbcompradores.customer_id = tbvendas.customer_id
WHERE
	tbvendas.sale_date >= (CURRENT_DATE - INTERVAL 1 MONTH);

