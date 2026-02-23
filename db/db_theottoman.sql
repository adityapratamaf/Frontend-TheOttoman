CREATE TABLE `categories` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `image_path` varchar(255),
  `slug` varchar(255) UNIQUE,
  `created_by` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `products` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `category_id` bigint NOT NULL,
  `sku` varchar(255) UNIQUE,
  `name` varchar(255),
  `slug` varchar(255) UNIQUE,
  `description` text,
  `detail` text,
  `stock` int DEFAULT 0,
  `unit_price` decimal(12,2),
  `is_active` boolean DEFAULT true,
  `created_by` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `product_images` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `image_path` varchar(255),
  `is_primary` boolean DEFAULT false
);

CREATE TABLE `product_motifs` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `name` varchar(255),
  `additional_price` decimal(12,2) DEFAULT 0
);

CREATE TABLE `product_motif_images` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `product_motif_id` bigint NOT NULL,
  `image_path` varchar(255),
  `is_primary` boolean DEFAULT false
);

CREATE TABLE `product_sizes` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `name` varchar(255),
  `additional_price` decimal(12,2) DEFAULT 0,
  `stock` int DEFAULT 0
);

CREATE TABLE `users` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `email` varchar(255) UNIQUE,
  `password` varchar(255),
  `phone` varchar(255),
  `role` ENUM ('super_admin', 'administrator', 'staff', 'user') NOT NULL DEFAULT 'user',
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `addresses` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint UNIQUE NOT NULL,
  `recipient_name` varchar(255),
  `province` varchar(255),
  `address_detail` text,
  `city` varchar(255),
  `district` varchar(255),
  `sub_district` varchar(255),
  `postal_code` varchar(255),
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `carts` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint UNIQUE NOT NULL,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `cart_items` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `cart_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `motif_id` bigint,
  `size_id` bigint,
  `quantity` int NOT NULL DEFAULT 1,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
);

CREATE TABLE `payment_methods` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `type` ENUM ('bank_transfer', 'ewallet', 'qris'),
  `account_number` varchar(255),
  `account_name` varchar(255),
  `is_active` boolean DEFAULT true,
  `created_by` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `orders` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `payment_method_id` bigint,
  `cart_id` bigint,
  `order_number` varchar(255) UNIQUE,
  `recipient_name` varchar(255),
  `recipient_phone` varchar(255),
  `recipient_address` text,
  `recipient_city` varchar(255),
  `recipient_province` varchar(255),
  `recipient_district` varchar(255),
  `recipient_sub_district` varchar(255),
  `recipient_postal_code` varchar(255),
  `shipping_note` text,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0,
  `status` ENUM ('pending', 'paid', 'shipped', 'completed', 'cancelled') DEFAULT 'pending',
  `created_by` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `order_items` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `motif_id` bigint,
  `size_id` bigint,
  `quantity` int,
  `weight_in_gram` int,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
);

CREATE TABLE `invoices` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `order_id` bigint UNIQUE NOT NULL,
  `invoice_number` varchar(255) UNIQUE,
  `invoice_date` datetime,
  `price_total` decimal(12,2) NOT NULL,
  `status` ENUM ('unpaid', 'paid', 'expired') DEFAULT 'unpaid',
  `created_at` datetime
);

CREATE TABLE `galleries` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `image_path` varchar(255),
  `created_by` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `blogs` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `slug` varchar(255) UNIQUE,
  `image_path` varchar(255),
  `content` text,
  `is_published` boolean DEFAULT true,
  `created_by` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `about` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `image_path` varchar(255),
  `content` text,
  `created_by` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `social_media` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `link` varchar(255),
  `image_path` varchar(255),
  `created_by` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE INDEX `products_index_0` ON `products` (`category_id`);

CREATE INDEX `product_images_index_1` ON `product_images` (`product_id`);

CREATE UNIQUE INDEX `product_motifs_index_2` ON `product_motifs` (`id`, `product_id`);

CREATE INDEX `product_motifs_index_3` ON `product_motifs` (`product_id`);

CREATE INDEX `product_motif_images_index_4` ON `product_motif_images` (`product_motif_id`);

CREATE UNIQUE INDEX `product_sizes_index_5` ON `product_sizes` (`id`, `product_id`);

CREATE INDEX `product_sizes_index_6` ON `product_sizes` (`product_id`);

CREATE INDEX `cart_items_index_7` ON `cart_items` (`cart_id`);

CREATE INDEX `cart_items_index_8` ON `cart_items` (`product_id`);

CREATE UNIQUE INDEX `cart_items_index_9` ON `cart_items` (`cart_id`, `product_id`, `motif_id`, `size_id`);

CREATE INDEX `orders_index_10` ON `orders` (`user_id`);

CREATE INDEX `orders_index_11` ON `orders` (`payment_method_id`);

CREATE INDEX `order_items_index_12` ON `order_items` (`order_id`);

CREATE INDEX `order_items_index_13` ON `order_items` (`product_id`);

ALTER TABLE `products` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

ALTER TABLE `product_images` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `product_motifs` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `product_motif_images` ADD FOREIGN KEY (`product_motif_id`) REFERENCES `product_motifs` (`id`);

ALTER TABLE `product_sizes` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `addresses` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `carts` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `cart_items` ADD FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`);

ALTER TABLE `cart_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `cart_items` ADD FOREIGN KEY (`motif_id`, `product_id`) REFERENCES `product_motifs` (`id`, `product_id`);

ALTER TABLE `cart_items` ADD FOREIGN KEY (`size_id`, `product_id`) REFERENCES `product_sizes` (`id`, `product_id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`motif_id`, `product_id`) REFERENCES `product_motifs` (`id`, `product_id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`size_id`, `product_id`) REFERENCES `product_sizes` (`id`, `product_id`);

ALTER TABLE `invoices` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
