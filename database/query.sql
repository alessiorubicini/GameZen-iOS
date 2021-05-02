
-- Seleziona tutti i prodotti nel database
SELECT P.ID, P.name, P.description, P.year, P.language, P.price, P.available, P.imageURL, C.name, Producer.name
FROM products P, categories C, producers
WHERE C.ID = P.ID AND Producer.ID = P.producer

-- Seleziona gli ordini dell'utente
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


