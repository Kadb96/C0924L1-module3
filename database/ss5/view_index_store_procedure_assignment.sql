SET SQL_SAFE_UPDATES = 0;

-- Bước 1: Tạo cơ sở dữ liệu demo

create database demo;

use demo;
-- Bước 2: Tạo bảng Products với các trường dữ liệu sau:

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_code VARCHAR(50),
    product_name VARCHAR(50),
    product_price DOUBLE,
    product_amount INT,
    product_description VARCHAR(100),
    product_status VARCHAR(50)
);

insert 
	into products
values 
	(1, "p1", "dien thoai", 8000000, 2, "iphone", "Đang sử dụng"),
	(2, "b1", "xe may to", 150000000, 1, "sh", "Đang sử dụng"),
	(3, "b2", "xe may nho", 50000000, 1, "wave", "Không sử dụng"),
	(4, "p2", "dien thoai phu", 50000000, 3, "samsung", "Đang sử dụng");
    
-- Bước 3:

create index i_product_code 
	on products (product_code);
	
create index i_code_and_price
	on products (product_code, product_price);
    
EXPLAIN SELECT * 
FROM products 
WHERE product_code = "b1";
-- câu lệnh chỉ duyệt qua 1 hàng thay vì 4 hàng

-- Bước 4:

CREATE VIEW w_products AS
    SELECT 
        product_code, product_name, product_price, product_status
    FROM
        products;
        
UPDATE w_products
SET product_price = 0
WHERE product_status = "Đang sử dụng";

SELECT *
FROM products;

DROP VIEW w_products;

-- Bước 5:

DELIMITER $$
	CREATE PROCEDURE get_all_products ()
		BEGIN
			SELECT * FROM products;
		END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE insert_products (
		product_id int, 
		product_code varchar(50), 
		product_name varchar(50), 
		product_price double, 
		product_amount int,
		product_description varchar(100),
		product_status varchar(50)
		)
		BEGIN
			INSERT
				INTO products
				VALUES
					(product_id, product_code, product_name, product_price, product_amount, product_description, product_status);
		END $$
DELIMITER ;	

DELIMITER $$
	CREATE PROCEDURE update_products (
		product_id_found int, 
		new_product_code varchar(50), 
		new_product_name varchar(50), 
		new_product_price double, 
		new_product_amount int,
		new_product_description varchar(100),
		new_product_status varchar(50)
		)
		BEGIN
			UPDATE products
            SET 
				product_code = new_product_code,
                product_name = new_product_name,
                product_price = new_product_price,
                product_amount = new_product_amount,
                product_description = new_product_description,
                product_status = new_product_status
			WHERE 
				product_id = product_id_found;
		END $$
DELIMITER ;	

DELIMITER $$
	CREATE PROCEDURE delete_products (product_id_found int)
		BEGIN
			DELETE
            FROM products
            WHERE product_id = product_id_found;
		END $$
DELIMITER ;	