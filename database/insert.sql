
INSERT INTO users (name, surname, email, password, birth) VALUES ('Alessio', 'Rubicini', 'alessiorubicini16@icloud.com', '098f6bcd4621d373cade4e832627b4f6', '2002-07-16');

INSERT INTO addresses(address, civic, city, CAP, province, phone) VALUES('Via Mauro Macchi', 52, 'Porto San Giorgio', 63822, 'FM', 3896970199);

INSERT INTO delivery (user, address) VALUES (1, 1);

INSERT INTO states(id, state) VALUES (1, 'In attesa di pagamento');
INSERT INTO states(id, state) VALUES (2, 'Pagamento ricevuto');
INSERT INTO states(id, state) VALUES (3, 'In eleborazione');
INSERT INTO states(id, state) VALUES (4, 'Spedito');
INSERT INTO states(id, state) VALUES (5, 'In consegna');
INSERT INTO states(id, state) VALUES (6, 'Consegnato');

INSERT INTO producers (id, name) VALUES(1, 'Hasbro');
INSERT INTO producers (id, name) VALUES(2, 'Editrice Giochi');

INSERT INTO categories (id, name) VALUES(1, 'Astratti');
INSERT INTO categories (id, name) VALUES(2, 'Per famiglie');
INSERT INTO categories (id, name) VALUES(3, 'Per bambini');
INSERT INTO categories (id, name) VALUES(4, 'Party games');
INSERT INTO categories (id, name) VALUES(5, 'Strategici');
INSERT INTO categories (id, name) VALUES(6, 'WarGames');
INSERT INTO categories (id, name) VALUES(7, 'Collezionabili');

INSERT INTO products(category, producer, name, description, year, language, price, available, image) VALUES(5, 1, 'Monopoly', 'Il gioco di contrattazione più famoso del mondo. Compra, vendi, sogna e programma la tua strada verso la ricchezza. I giocatori comprano, vendono e contrattano per vincere; compra e vendi proprietà.',
2018, 'ITA', 21.99, 1, 'monopoly.jpg');
INSERT INTO products(category, producer, name, description, year, language, price, available, image) VALUES(6, 2, 'Risiko', 'RisiKo! è la variante italiana di Risk. Lo scopo è il raggiungimento di un obiettivo segreto e diverso per ognuno, che può consistere nella conquista di un numero di territori, nella conquista di continenti o annientamento di un avversario.',
1977, 'ITA', 28.00, 1, 'risiko.jpg');

INSERT INTO save (user, product) VALUES(1, 1);

INSERT INTO orders (date, delivery, user, address, state, total) VALUES('2021-05-03', '2021-05-10', 1, 1, 1, 21.99);

