<?php
	// login.php
	// Copyright (C) 2021 Alessio Rubicini.
	// This program is free software: you can redistribute it and/or modify
	// it under the terms of the GNU General Public License as published by
	// the Free Software Foundation, either version 3 of the License, or
	// (at your option) any later version.
	// This program is distributed in the hope that it will be useful,
	// but WITHOUT ANY WARRANTY; without even the implied warranty of
	// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	// GNU General Public License for more details.
	// You should have received a copy of the GNU General Public License
	// along with this program. If not, see <http://www.gnu.org/licenses/>.

	// HTTP response headers
	header('Content-Type: application/json');

	// Including database interface class
	require_once('../core/database.php');

	// Check if all data has been passed
	if(!isset($_POST["email"])) {
		header("HTTP/1.1 400");
		echo "Missing email";
		exit;
	}

	if(!isset($_POST["password"])) {
		header("HTTP/1.1 400");
		echo "Missing password";
		exit;
	}

	// Setup database interface
	$db = new Database();

	// Get passed data with POST
	$email = $db->makeSecure($_POST["email"]);
	$password = $db->makeSecure($_POST["password"]);

	// Check user's credentials
	$result = $db->query("SELECT * FROM users WHERE email = '$email' AND password = '$password'");

	// If credentials are wrong, return HTTP 403 forbidden
	if(count($result) == 0) {

		// Close database connection
		$db->close();

		// Return HTTP response
		header("HTTP/1.1 403");

	} else {

		// Get the user ID from query result
		$userID = $result[0]['id'];

		// Select user's addresses
		$addresses = $db->query("SELECT A.id, A.address, A.civic, A.city, A.CAP, A.province, A.phone FROM users U, delivery D, addresses A WHERE U.id = $userID AND U.ID = D.user AND D.address = A.ID GROUP BY A.ID");
		$result[0]["addresses"] = $addresses;

		// Select user's orders
		$orders = $db->query("SELECT O.id, O.date, O.delivery, S.state, O.total, CONCAT(A.address, ',', A.civic, ',', A.city, ',', A.CAP) AS 'address' FROM orders O, addresses A, states S WHERE O.user = $userID AND O.address = A.ID AND O.state = S.ID GROUP BY O.ID");

		// For each order, select the products
		foreach($orders as &$order) {
			$orderID = $order["id"];
			$products = $db->query("SELECT P.code, P.name, P.description, P.year, P.language, P.price, P.available, P.image, C.name AS 'category', producers.name AS 'producer' FROM products P, detail D, orders O, categories C, producers WHERE O.id = $orderID AND P.code = D.product AND D.orderID = O.id AND P.category = C.id AND P.producer = producers.id AND O.user = 1");

			// Transforming boolean value from tinyint to true|false
			foreach($products as &$product) {
				if($product["available"]) {

					$product["available"] = true;
					
				} else {

					$product["available"] = false;

				}
			}

			$order["products"] = $products;
		}

		$result[0]["orders"] = $orders;

		// Close database connection
		$db->close();

		// Return final result as JSON
		header("HTTP/1.1 200");
		echo json_encode($result[0], JSON_NUMERIC_CHECK);
	
	}


?>