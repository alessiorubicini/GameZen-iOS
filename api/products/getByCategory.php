<?php
	// getByCategory.php (products)
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

	if(!isset($_GET["category"])) {
		header("HTTP/1.1 400");
		echo "Missing product category";
		exit;
	}

	$db = new Database();
	$category = $_GET["category"];

	$result = $db->queryToJSON("SELECT * FROM prodotti p INNER JOIN categorie c ON p.categoria = c.id WHERE c.nome = '$category'");
	
	if(count($result) == 0) {
		header("HTTP/1.1 404");
	} else {
		echo json_encode($result, JSON_NUMERIC_CHECK);
	}

?>