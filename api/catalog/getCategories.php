<?php
	// getCategories.php (catalog)
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

	// Select catalog's categories from database
	$categories = $db->query("SELECT C.id, C.name, COUNT(P.code) AS 'numberOfProducts' FROM products P, categories C WHERE P.category = C.id GROUP BY C.id");

	// Close database connection
	$db->close();

	// Return result as JSON
	header("HTTP/1.1 200");
	echo json_encode($categories, JSON_NUMERIC_CHECK);

?>