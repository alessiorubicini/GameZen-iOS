<?php
	// get.php (cart)
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
	if(!isset($_GET["userID"])) {
		header("HTTP/1.1 400");
		echo "Missing user ID";
		exit;
	}

	// Setup database interface
	$db = new Database();

	// Get userID passed with GET
	$userID = $db->makeSecure($_GET["userID"]);

	// Select all the products in user cart
	$products = $db->query("SELECT P.code, P.name, P.description, P.year, P.language, P.price, P.available, P.image, C.name AS 'category', producers.name AS 'producer' FROM products P, categories C, producers, save S, users U WHERE U.id = $userID AND C.ID = P.category AND producers.ID = P.producer AND U.id = S.user AND S.product = P.code GROUP BY P.code");

	// Close database connection
	$db->close();

	// Check if cart is empty
	if(count($products) == 0) {

		// Return HTTP response
		header("HTTP/1.1 404");

	} else {

		// Transforming boolean value from tinyint to true|false
		foreach($products as &$product) {
			if($products["available"] == 1) {

				$product["available"] = false;

			} else {

				$product["available"] = true;
				
			}
		}

		// Return data as JSON
		echo json_encode($products, JSON_NUMERIC_CHECK);
	}

?>