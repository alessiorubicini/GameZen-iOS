<?php
	// delete.php (orders)
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
	if(!isset($_GET["orderID"])) {
		header("HTTP/1.1 400");
		echo "Missing order ID";
		exit;
	}

	// Get passed data
	$orderID = $_GET["orderID"];

	// Remove order from database
	$db = new Database();	
	$db->queryWithoutResult("DELETE FROM orders WHERE id = '$orderID'");

	header("HTTP/1.1 200");
	
?>