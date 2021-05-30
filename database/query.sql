
-- query.sql
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

-- This file contains some queries used in the system

-- Select all products from database
SELECT P.ID, P.name, P.description, P.year, P.language, P.price, P.available, P.imageURL, C.name, Producer.name
FROM products P, categories C, producers
WHERE C.ID = P.ID AND Producer.ID = P.producer

-- Select all orders of a user
SELECT O.ID, O.date, O.delivery, CONCAT(A.address, ' ', A.civic, ' - ', A.city, ', ', A.CAP) AS 'address', S.state, O.total
FROM orders O, addresses A, states S
WHERE O.user = 1
AND O.address = A.ID AND O.state = S.ID
GROUP BY O.ID

-- Seleziona gli indirizzi dell'utente
SELECT A.address, A.civic, A.city, A.province, A.phone
FROM users U, deliver D, addresses A
WHERE U.ID = 1 -- ID dell'utente
AND U.ID = D.user AND D.address = A.ID
GROUP BY A.ID

-- Seleziona le categorie con il numero di prodotti per ogni categoria
SELECT c.id, c.name, COUNT(P.code) AS 'numberOfProducts'
FROM products P, categories C
WHERE P.category = C.id
GROUP BY C.id

-- Seleziona i prodotti dal carrello dell'utente
SELECT P.code, P.name, P.description, P.year, P.language, P.price, P.available, P.image, C.name AS 'category', producers.name AS 'producer'
FROM products P, categories C, producers, save S, users U
WHERE C.ID = P.category AND producers.ID = P.producer AND U.id = S.user AND S.product = P.code
GROUP BY P.code

-- Seleziona i prodotti di un ordine
SELECT P.code, P.name, P.description, P.year, P.language, P.price, P.available, P.image, C.name AS 'category', producers.name AS 'producer'
FROM products P, detail D, orders O, categories C, producers
WHERE O.id = 1 AND P.code = D.product AND D.OrderId = O.id AND P.category = C.id AND P.producer = producers.id AND O.user = 1
