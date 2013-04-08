-- MySQL database create for ChicagoBoss_MySQL_App

-- Connect with 'mysql -u root'
-- This database is not locked down in anyway

-- CREATE the new database/schema
CREATE DATABASE meal CHARACTER SET utf8;


CREATE TABLE meal.admins (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  descs text,
  passwd VARCHAR(20),
  type VARCHAR(20),
  email VARCHAR(100),
  phone VARCHAR(100),
  createtime VARCHAR(100),
  disable VARCHAR(10),
  timesec decimal
  );
CREATE TABLE meal.categorys (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  descs text,
  relateid VARCHAR(100),
  name VARCHAR(255),
  creator VARCHAR(100),
  createtime VARCHAR(100),
  isused VARCHAR(10),
  timesec decimal
  );
CREATE TABLE meal.collects (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  relateid VARCHAR(100),
  userid VARCHAR(100),
  url VARCHAR(255),
  createtime VARCHAR(100),
  timesec decimal
  );
CREATE TABLE meal.comments (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  relateid VARCHAR(100),
  content text,
  userid VARCHAR(100),
  linkurl VARCHAR(255),
  createtime VARCHAR(100),
  timesec decimal
  );
CREATE TABLE meal.consumers (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  age INTEGER,
  sex INTEGER,
  passwd VARCHAR(20),
  type VARCHAR(20),
  avator VARCHAR(255),
  note VARCHAR(255),
  email VARCHAR(100),
  phone VARCHAR(100),
  salary decimal,
  integration decimal,
  isused VARCHAR(20),
  creator VARCHAR(100),
  createtime VARCHAR(100),
  timesec decimal
  );
CREATE TABLE meal.foods (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  known VARCHAR(100),
  unit VARCHAR(20),
  descs VARCHAR(255),
  image VARCHAR(255),
  sellername VARCHAR(100),
  sellerid VARCHAR(100),
  price decimal,
  isused VARCHAR(20),
  createtime VARCHAR(100),
  timesec decimal
  );
CREATE TABLE meal.food_items (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  foodname VARCHAR(100),
  relatename VARCHAR(100),
  sellername VARCHAR(100),
  foodid VARCHAR(100),
  price decimal,
  relateid VARCHAR(100),
  sellerid VARCHAR(100),
  createtime VARCHAR(100),
  timesec decimal,
  sums decimal
  
  );
CREATE TABLE meal.groups (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  descs VARCHAR(255),
  name VARCHAR(100),
  percentage VARCHAR(20),
  creator VARCHAR(100),
  sellerid VARCHAR(100),
  createtime VARCHAR(100),
  isused VARCHAR(20),
  timesec decimal,
  sums decimal,
  tatalmoney decimal,
  groupmoney decimal
  );
CREATE TABLE meal.images (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  relateid VARCHAR(100),
  descs VARCHAR(100),
  type VARCHAR(20),  
  wide decimal,
  height decimal,
  url VARCHAR(255)
  );

CREATE TABLE meal.likes (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  relateid VARCHAR(100),
  userid VARCHAR(100),
  createtime VARCHAR(100),
  timesec decimal
  );

CREATE TABLE meal.like_counts (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  relateid VARCHAR(100),
  like_count decimal,
  createtime VARCHAR(100),
  timesec decimal
  );

CREATE TABLE meal.notices (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  content mediumtext,
  createtime VARCHAR(100),
  timesec decimal,
  creator VARCHAR(255),
  title VARCHAR(255)
  );

CREATE TABLE meal.order_items (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  foodid VARCHAR(100),
  sellerid VARCHAR(100),
  quantity decimal,
  money decimal,
  createtime VARCHAR(100),
  timesec decimal
  );

CREATE TABLE meal.orders (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  userid VARCHAR(100),
  paytype VARCHAR(20),
  tel VARCHAR(100),
  phone VARCHAR(100),
  address VARCHAR(100),
  money decimal,
  createtime VARCHAR(100),
  timesec decimal
  );

CREATE TABLE meal.preferentials (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  price decimal,
  price_ decimal,  
  foodid VARCHAR(100),
  createtime VARCHAR(100),
  timesec decimal,
  category VARCHAR(255),
  Percentage VARCHAR(255)
  );

CREATE TABLE meal.privileges (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  creatar VARCHAR(100),
  createtime VARCHAR(100),
  timesec decimal,
  descs VARCHAR(255),
  name VARCHAR(255)
  );
CREATE TABLE meal.sellers (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  logo VARCHAR(255),
  descs VARCHAR(255),
  passwd VARCHAR(20),
  type VARCHAR(20),
  email VARCHAR(100),
  phone VARCHAR(100),
  tel VARCHAR(100),
  state VARCHAR(20),
  paytype VARCHAR(20),
  lan decimal,
  lat decimal,
  address VARCHAR(100),
  isused VARCHAR(20),
  creator VARCHAR(100),
  createtime VARCHAR(100),
  timesec decimal
  );
CREATE TABLE meal.user4privileges (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  userId VARCHAR(100),
  privilegeId VARCHAR(100),
  createtime VARCHAR(100),
  timesec decimal,
  privilegeDesc VARCHAR(255),
  userName VARCHAR(255)
  );










