<?php
	// get.php (orders)
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
	// along with this program.  If not, see <http://www.gnu.org/licenses/>.

	header('Content-Type: application/json');
	require_once('../core/database.php');
	require_once('../core/config.php');

	// Check if all data has been passed
	if(!isset($_GET["userID"])) {
		header("HTTP/1.1 400");
		echo "Missing user ID";
		exit;
	}

	// Get passed data
	$userID = $_GET["userID"];

	// Select user's orders from database
	$db = new Database();
	$orders = $db->query("SELECT O.id, O.date, O.delivery, CONCAT(A.address, ' ', A.civic, ' - ', A.city, ', ', A.CAP) AS 'address', S.state, O.total FROM orders O, addresses A, states S WHERE O.user = $userID AND O.address = A.ID AND O.state = S.ID GROUP BY O.ID");

	// If the user has no orders return HTTP 404 not found
	if(count($orders) == 0) {
		header("HTTP/1.1 404");
	} else {

		foreach($orders as &$order) {

			// Select order's products
			$orderID = $order["id"];
			$result = $db->query("SELECT P.code, P.name, P.description, P.year, P.language, P.price, P.available, P.image, C.name AS 'category', producers.name AS 'producer' FROM products P, detail D, orders O, categories C, producers WHERE O.id = $orderID AND P.code = D.product AND D.OrderId = O.id AND P.category = C.id AND P.producer = producers.id");

			// Transforming boolean value from tinyint to true|false
			foreach($result as &$product) {
				if($product["available"]) {
					$product["available"] = true;
				} else {
					$product["available"] = false;
				}
			}

			$order["products"] = $result;
		}

		// Return final result as JSON
		header("HTTP/1.1 200");
		echo json_encode($orders, JSON_NUMERIC_CHECK);
	}
?>