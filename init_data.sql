-- 1. Tạo bảng raw_customers (Thông tin khách hàng)
CREATE TABLE IF NOT EXISTS raw_customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- 2. Tạo bảng raw_orders (Thông tin đơn hàng)
CREATE TABLE IF NOT EXISTS raw_orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    order_date DATE,
    status VARCHAR(50)
);

-- 3. Tạo bảng raw_payments (Thông tin thanh toán)
CREATE TABLE IF NOT EXISTS raw_payments (
    id SERIAL PRIMARY KEY,
    order_id INTEGER,
    payment_method VARCHAR(50),
    amount INTEGER -- Số tiền thường được lưu ở đơn vị cent (ví dụ: 1000 = 10.00$)
);

-- Làm sạch dữ liệu cũ nếu đã tồn tại trước khi insert
TRUNCATE TABLE raw_customers, raw_orders, raw_payments RESTART IDENTITY;

-- 4. Chèn dữ liệu mẫu vào raw_customers
INSERT INTO raw_customers (id, first_name, last_name) VALUES
(1, 'Michael', 'P.'),
(2, 'Shawn', 'M.'),
(3, 'Kathleen', 'P.'),
(4, 'Huey', 'L.'),
(5, 'Zack', 'S.');

-- 5. Chèn dữ liệu mẫu vào raw_orders
INSERT INTO raw_orders (id, user_id, order_date, status) VALUES
(1, 1, '2023-01-01', 'returned'),
(2, 3, '2023-01-02', 'completed'),
(3, 94, '2023-01-04', 'completed'), -- Cố tình tạo một user_id không tồn tại để thực hành test trên dbt
(4, 2, '2023-01-05', 'returned'),
(5, 5, '2023-01-05', 'completed');

-- 6. Chèn dữ liệu mẫu vào raw_payments
INSERT INTO raw_payments (id, order_id, payment_method, amount) VALUES
(1, 1, 'credit_card', 1000),
(2, 2, 'credit_card', 2000),
(3, 3, 'coupon', 100),
(4, 4, 'bank_transfer', 3000),
(5, 5, 'credit_card', 2500),
(6, 5, 'gift_card', 500);
