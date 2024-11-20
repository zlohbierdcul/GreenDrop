-- Create tables and relationships

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    birthdate DATE NOT NULL,
    green_drops INT NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    password VARCHAR NOT NULL
);

CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    street VARCHAR NOT NULL,
    street_number VARCHAR NOT NULL,
    zip_code VARCHAR NOT NULL,
    city VARCHAR NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE vendors (
    vendor_id SERIAL PRIMARY KEY,
    iban VARCHAR NOT NULL
);

CREATE TABLE shops (
    shop_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    street VARCHAR NOT NULL,
    street_number VARCHAR NOT NULL,
    zip_code VARCHAR NOT NULL,
    city VARCHAR NOT NULL,
    minimum_order DOUBLE PRECISION NOT NULL,
    delivery_costs DOUBLE PRECISION NOT NULL,
    max_delivery_radius INT NOT NULL,
    vendor_id INT NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id) ON DELETE CASCADE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    price DOUBLE PRECISION NOT NULL,
    origin VARCHAR NOT NULL,
    type VARCHAR NOT NULL,
    shop_id INT NOT NULL,
    FOREIGN KEY (shop_id) REFERENCES shop(shop_id)
);

CREATE TABLE drugs (
    drug_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    effect VARCHAR NOT NULL,
    latin_name VARCHAR,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    shop_id INT NOT NULL,
    user_id INT NOT NULL,
    address_id INT NOT NULL,
    payment_method VARCHAR NOT NULL,
    status VARCHAR NOT NULL,
    FOREIGN KEY (shop_id) REFERENCES shop(shop_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE order_contains (
    order_content_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    rating INT NOT NULL CHECK(rating BETWEEN 1 AND 5),
    comment VARCHAR
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (shop_id) REFERENCES shop(shop_id),
)