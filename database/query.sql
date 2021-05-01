
-- Seleziona tutti i prodotti nel database
SELECT P.ID, P.name, P.description, P.year, P.language, P.price, P.available, P.imageURL, C.name, Producer.name
FROM Products P, Categories C, Producers
WHERE C.ID = P.ID AND Producer.ID = P.producer

-- Seleziona gli ordini dell'utente
SELECT O.ID, O.orderDate, O.deliveryEstimate, S.status, CONCAT(A.street, ',', A.civicNumber, ',', A.city, ',', A.CAP)
FROM Orders O, Addresses A, Status S
WHERE O.user = 1 -- ID dell'utente
AND O.address = A.ID AND O.status = S.ID-
GROUP BY O.ID

-- Seleziona gli indirizzi dell'utente
SELECT A.street, A.civicNumber, A.city, A.CAP, A.province, A.phone
FROM Users U, Deliver D, Address A
WHERE U.ID = 1 -- ID dell'utente
AND U.ID = D.user AND D.address = A.ID
GROUP BY A.ID
