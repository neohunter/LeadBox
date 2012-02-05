SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `leadbox` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `leadbox` ;

-- -----------------------------------------------------
-- Table `leadbox`.`contacts`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`contacts` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `first_name` VARCHAR(45) NULL ,
  `last_name` VARCHAR(45) NULL ,
  `type` ENUM('lead', 'customer') NOT NULL DEFAULT 'lead' ,
  `campaign_id` INT NULL ,
  `source_id` INT NULL ,
  `step_id` INT NULL ,
  `description` VARCHAR(255) NULL ,
  `created` DATETIME NULL ,
  `modified` DATETIME NULL ,
  `last_contacted` DATETIME NULL ,
  `country_id` INT NULL ,
  `status` ENUM('new', 'attention','waiting-reply', 'postponed', 'discarded') NULL ,
  `last_ip` VARCHAR(45) NULL ,
  `email` VARCHAR(45) NULL ,
  `phone` VARCHAR(45) NULL ,
  `rating` INT NOT NULL DEFAULT 0 ,
  `probability` INT(2) NULL ,
  `user_id` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `leadbox`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NULL ,
  `name` VARCHAR(45) NULL ,
  `created` VARCHAR(45) NULL ,
  `active` TINYINT(1)  NOT NULL ,
  `herbalife_id` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `username` (`username` ASC) ,
  UNIQUE INDEX `email` (`email` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`campaigns`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`campaigns` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `status` ENUM('planing', 'active', 'inactive', 'completed', 'aborted') NULL ,
  `type` ENUM('web', 'email', 'print', 'newspaper' ,'other') NULL ,
  `total_budget` VARCHAR(45) NULL ,
  `monthly_budget` VARCHAR(45) NULL ,
  `actual_cost` DECIMAL(10,2) NULL ,
  `objective` TEXT NULL ,
  `objective_leads` INT NULL ,
  `objective_conversions` INT NULL ,
  `objective_revenue` INT NULL ,
  `objective_budget` INT NULL ,
  `profit` DECIMAL(12,2) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`history`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`history` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(255) NULL ,
  `body` TEXT NULL ,
  `created` DATETIME NULL ,
  `contact_id` INT NULL ,
  `type` VARCHAR(45) NULL ,
  `contacts_id` INT NOT NULL ,
  `user_id` INT NULL ,
  `timer` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_history_contacts` (`contacts_id` ASC) ,
  CONSTRAINT `fk_history_contacts`
    FOREIGN KEY (`contacts_id` )
    REFERENCES `leadbox`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`sources`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`sources` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `campaign_id` VARCHAR(45) NULL ,
  `origin_name` VARCHAR(45) NULL ,
  `origin_variation` VARCHAR(45) NULL ,
  `provider_name` VARCHAR(45) NULL ,
  `provider_resource` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`tags`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tag` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `tag_UNIQUE` (`tag` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`tasks`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`tasks` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `contact_id` INT NULL ,
  `created` DATETIME NULL ,
  `due` DATETIME NULL ,
  `assigned` TINYINT(1)  NOT NULL DEFAULT false ,
  `user_id` INT NULL ,
  `title` VARCHAR(45) NULL ,
  `description` VARCHAR(255) NULL ,
  `finished` TINYINT(1)  NOT NULL DEFAULT false ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`contact_details`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`contact_details` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `contact_id` INT NOT NULL ,
  `key` VARCHAR(255) NULL ,
  `value` VARCHAR(255) NULL ,
  `note` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_contact_details_contacts1` (`contact_id` ASC) ,
  CONSTRAINT `fk_contact_details_contacts1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `leadbox`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`countries`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`countries` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `starred` TINYINT(1)  NOT NULL DEFAULT false ,
  `name` VARCHAR(45) NOT NULL ,
  `code` VARCHAR(2) NOT NULL ,
  `currency_code` VARCHAR(3) NULL ,
  `currency_name` VARCHAR(12) NULL ,
  `currency_value` DECIMAL(10,2) NULL ,
  `currency_symbol` VARCHAR(4) NULL ,
  `contact_count` INT NULL ,
  `lead_count` INT NULL ,
  `customer_count` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`warehouses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`warehouses` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `country_id` VARCHAR(45) NULL ,
  `city` VARCHAR(45) NULL ,
  `address` VARCHAR(255) NULL ,
  `phone` VARCHAR(45) NULL ,
  `price_list_date` DATETIME NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`products`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `sku` VARCHAR(45) NULL ,
  `name` VARCHAR(45) NULL ,
  `points` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`products_warehouses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`products_warehouses` (
  `products_id` INT NOT NULL ,
  `warehouses_id` INT NOT NULL ,
  `price_net` VARCHAR(45) NULL ,
  `public_price` VARCHAR(45) NULL ,
  PRIMARY KEY (`products_id`, `warehouses_id`) ,
  INDEX `fk_products_warehouses_warehouses1` (`warehouses_id` ASC) ,
  INDEX `fk_products_warehouses_products1` (`products_id` ASC) ,
  CONSTRAINT `fk_products_warehouses_products1`
    FOREIGN KEY (`products_id` )
    REFERENCES `leadbox`.`products` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_warehouses_warehouses1`
    FOREIGN KEY (`warehouses_id` )
    REFERENCES `leadbox`.`warehouses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`programs`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`programs` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `value` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`programs_products`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`programs_products` (
  `programs_id` INT NOT NULL ,
  `products_id` INT NOT NULL ,
  PRIMARY KEY (`programs_id`, `products_id`) ,
  INDEX `fk_programs_products_products1` (`products_id` ASC) ,
  INDEX `fk_programs_products_programs1` (`programs_id` ASC) ,
  CONSTRAINT `fk_programs_products_programs1`
    FOREIGN KEY (`programs_id` )
    REFERENCES `leadbox`.`programs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_programs_products_products1`
    FOREIGN KEY (`products_id` )
    REFERENCES `leadbox`.`products` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`textslices`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`textslices` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `content` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`contacts_tags`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`contacts_tags` (
  `contacts_id` INT NOT NULL ,
  `tags_id` INT NOT NULL ,
  PRIMARY KEY (`contacts_id`, `tags_id`) ,
  INDEX `fk_contacts_tags_tags1` (`tags_id` ASC) ,
  INDEX `fk_contacts_tags_contacts1` (`contacts_id` ASC) ,
  CONSTRAINT `fk_contacts_tags_contacts1`
    FOREIGN KEY (`contacts_id` )
    REFERENCES `leadbox`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contacts_tags_tags1`
    FOREIGN KEY (`tags_id` )
    REFERENCES `leadbox`.`tags` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`steps`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`steps` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `order` INT NULL ,
  `subject` VARCHAR(45) NULL ,
  `content` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`tags_textslices`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`tags_textslices` (
  `tags_id` INT NOT NULL ,
  `textslices_id` INT NOT NULL ,
  PRIMARY KEY (`tags_id`, `textslices_id`) ,
  INDEX `fk_tags_textslices_textslices1` (`textslices_id` ASC) ,
  INDEX `fk_tags_textslices_tags1` (`tags_id` ASC) ,
  CONSTRAINT `fk_tags_textslices_tags1`
    FOREIGN KEY (`tags_id` )
    REFERENCES `leadbox`.`tags` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_textslices_textslices1`
    FOREIGN KEY (`textslices_id` )
    REFERENCES `leadbox`.`textslices` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`models`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`models` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `subject` VARCHAR(255) NULL ,
  `body` TEXT NULL ,
  `user_id` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`tags_models`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`tags_models` (
  `tags_id` INT NOT NULL ,
  `models_id` INT NOT NULL ,
  PRIMARY KEY (`tags_id`, `models_id`) ,
  INDEX `fk_tags_models_models1` (`models_id` ASC) ,
  INDEX `fk_tags_models_tags1` (`tags_id` ASC) ,
  CONSTRAINT `fk_tags_models_tags1`
    FOREIGN KEY (`tags_id` )
    REFERENCES `leadbox`.`tags` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_models_models1`
    FOREIGN KEY (`models_id` )
    REFERENCES `leadbox`.`models` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`user_logs`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`user_logs` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NULL ,
  `created` VARCHAR(45) NULL ,
  `model` VARCHAR(45) NULL ,
  `action` VARCHAR(45) NULL ,
  `key` VARCHAR(45) NULL ,
  `url` VARCHAR(255) NULL ,
  `time` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`contact_methods`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`contact_methods` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `contact_id` INT NOT NULL ,
  `main` TINYINT(1)  NULL ,
  `type` VARCHAR(10) NULL ,
  `value` VARCHAR(60) NULL ,
  `created` DATETIME NULL ,
  `modified` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_contact_methods_contacts1` (`contact_id` ASC) ,
  CONSTRAINT `fk_contact_methods_contacts1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `leadbox`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`customers_products`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`customers_products` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `customer_id` INT NOT NULL ,
  `product_id` INT NOT NULL ,
  `created` DATETIME NULL ,
  `last_bought_date` DATETIME NULL ,
  `next_buy_date` DATETIME NULL ,
  `ammount` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_contacts_products_contacts1` (`customer_id` ASC) ,
  CONSTRAINT `fk_contacts_products_contacts1`
    FOREIGN KEY (`customer_id` )
    REFERENCES `leadbox`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `leadbox`.`orders`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`orders` (
  `id` INT NOT NULL ,
  `customer_id` INT NOT NULL ,
  `warehouse_id` VARCHAR(45) NULL ,
  `created` VARCHAR(45) NULL ,
  `amount` DECIMAL(10,2) NULL ,
  `profit` DECIMAL(10,2) NULL ,
  `herbalife_id` VARCHAR(45) NULL ,
  `discount` INT(2) NULL ,
  `estimated_repurchase` DATE NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_orders_contacts1` (`customer_id` ASC) ,
  CONSTRAINT `fk_orders_contacts1`
    FOREIGN KEY (`customer_id` )
    REFERENCES `leadbox`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`orders_products`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`orders_products` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` INT NOT NULL ,
  `product_id` VARCHAR(45) NULL ,
  `amount` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_orders_products_orders1` (`order_id` ASC) ,
  CONSTRAINT `fk_orders_products_orders1`
    FOREIGN KEY (`order_id` )
    REFERENCES `leadbox`.`orders` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`models_steps`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`models_steps` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `step_id` INT NOT NULL ,
  `model_id` INT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`expenses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`expenses` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `created` DATETIME NULL ,
  `amount` DECIMAL(10,2) NULL ,
  `title` VARCHAR(255) NULL ,
  `provider` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`customers_progress`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`customers_progress` (
  `id` INT NOT NULL ,
  `created` DATE NULL ,
  `key` VARCHAR(45) NULL ,
  `value` VARCHAR(45) NULL ,
  `customer_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_customers_progress_contacts1` (`customer_id` ASC) ,
  CONSTRAINT `fk_customers_progress_contacts1`
    FOREIGN KEY (`customer_id` )
    REFERENCES `leadbox`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`delivery_points`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`delivery_points` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`payment_methods`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`payment_methods` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`contact_data`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`contact_data` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `contact_id` INT NOT NULL ,
  `birthday` DATETIME NULL ,
  `goals` TEXT NULL ,
  `ideal_weight` VARCHAR(45) NULL ,
  `gender` ENUM('M', 'F') NULL ,
  `imperial_system` TINYINT(1)  NULL ,
  `better_call_time` TIME NULL ,
  `health_log` VARCHAR(45) NULL ,
  `address_1` VARCHAR(255) NULL ,
  `address_2` VARCHAR(45) NULL ,
  `city` VARCHAR(45) NULL ,
  `state` VARCHAR(45) NULL ,
  `country_id` INT NULL ,
  `zip` VARCHAR(10) NULL ,
  `body_constitution` ENUM('S','M','B') NULL ,
  `refered_by` INT NULL ,
  PRIMARY KEY (`id`, `contact_id`) ,
  INDEX `fk_contact_data_contacts1` (`contact_id` ASC) ,
  CONSTRAINT `fk_contact_data_contacts1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `leadbox`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leadbox`.`important_dates`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `leadbox`.`important_dates` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `contact_id` INT NOT NULL ,
  `description` VARCHAR(255) NULL ,
  `date` DATE NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_important_dates_contacts1` (`contact_id` ASC) ,
  CONSTRAINT `fk_important_dates_contacts1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `leadbox`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
