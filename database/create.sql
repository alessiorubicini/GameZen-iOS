-- create.sql
-- Copyright (C) 2021 Alessio Rubicini.
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

-- This file contains all the necessary SQL queries for creating the database tables

CREATE TABLE users(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	surname VARCHAR(30) NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(30) UNIQUE NOT NULL,
	birth DATE
);

CREATE TABLE addresses(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	address VARCHAR(30) NOT NULL,
	civic INTEGER NOT NULL,
	city VARCHAR(30) NOT NULL,
	CAP VARCHAR(5) NOT NULL,
	province VARCHAR(2) NOT NULL,
	phone VARCHAR(30)
);

CREATE TABLE delivery(
	user INTEGER NOT NULL,
	address INTEGER NOT NULL,
	PRIMARY KEY (user, address),
	FOREIGN KEY (user) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY (address) REFERENCES addresses(id) ON DELETE CASCADE
);

CREATE TABLE categories(
	ID INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE producers(
	ID INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE products(
	code INTEGER PRIMARY KEY AUTO_INCREMENT,
	category INTEGER NOT NULL,
	producer INTEGER NOT NULL,
	name VARCHAR(40) NOT NULL,
	description VARCHAR(250),
	year YEAR NOT NULL,
	language VARCHAR(5),
	price FLOAT NOT NULL,
	available BOOLEAN NOT NULL,
	image VARCHAR(40),
	FOREIGN KEY (category) REFERENCES categories(ID),
	FOREIGN KEY (producer) REFERENCES producers(ID)
);

CREATE TABLE states(
	ID INTEGER PRIMARY KEY AUTO_INCREMENT,
	state VARCHAR(50) NOT NULL
);

CREATE TABLE save(
	user INTEGER NOT NULL,
	product INTEGER NOT NULL,
	PRIMARY KEY (user, product),
	FOREIGN KEY (user) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY (product) REFERENCES products(code) ON DELETE CASCADE
);

CREATE TABLE orders(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	date DATE NOT NULL,
	delivery DATE,
	user INTEGER NOT NULL,
	address INTEGER NOT NULL,
	state INTEGER NOT NULL,
	total FLOAT,
	FOREIGN KEY (user) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY (address) REFERENCES addresses(id) ON DELETE CASCADE,
	FOREIGN KEY (state) REFERENCES states(id) ON DELETE CASCADE
);

CREATE TABLE detail(
	orderID INTEGER NOT NULL,
	product INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	PRIMARY KEY (orderID, product),
	FOREIGN KEY (orderID) REFERENCES orders(id) ON DELETE CASCADE,
	FOREIGN KEY (product) REFERENCES products(code) ON DELETE CASCADE
);
