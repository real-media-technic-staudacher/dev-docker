CREATE USER 'testing'@'%';
CREATE DATABASE IF NOT EXISTS testing;
GRANT ALL ON testing.* TO 'testing'@'%' IDENTIFIED BY 'testing';