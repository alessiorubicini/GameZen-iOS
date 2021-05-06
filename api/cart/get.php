<?php
	// get.php (products)
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

	if(!isset($_GET["userID"])) {
		header("HTTP/1.1 400");
		echo "Missing user ID";
		exit;
	}

	$db = new Database();
	$userID = $_GET["userID"];

	$products = $db->query("SELECT P.code, P.name, P.description, P.year, P.language, P.price, P.available, P.image, C.name AS 'category', producers.name AS 'producer' FROM products P, categories C, producers, save S, users U WHERE C.ID = P.category AND producers.ID = P.producer AND U.id = S.user AND S.product = P.code GROUP BY P.code");

	if(count($products) == 0) {
		header("HTTP/1.1 404");
	} else {

		foreach($products as &$product) {
			if($products["available"] == 1) {
				$product["available"] = false;
			} else {
				$product["available"] = true;
			}
		}

		echo json_encode($products, JSON_NUMERIC_CHECK);
	}

?>