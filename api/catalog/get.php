<?php
	// get.php (catalog)
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

	// Setup database interface
	$db = new Database();

	// Select all products from database
	$result = $db->query("SELECT P.code, P.name, P.description, P.year, P.language, P.price, P.available, P.image, C.name AS 'category', producers.name AS 'producer' FROM products P, categories C, producers WHERE C.ID = P.category AND producers.id = P.producer");

	// Transforming boolean value from tinyint to true|false
	foreach($result as &$product) {
		if($product["available"]) {
			
			$product["available"] = true;
			
		} else {

			$product["available"] = false;
			
		}
	}

	// Close database connection
	$db->close();

	if(count($result) == 0) {

		// Return HTTP response
		header("HTTP/1.1 404");

	} else {

		// Return data as JSON
		header("HTTP/1.1 200");
		echo json_encode($result, JSON_NUMERIC_CHECK);
	}

?>