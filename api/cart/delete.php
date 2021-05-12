<?php
	// remove.php (cart)
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

	header('Content-Type: application/json');
	require_once('../core/database.php');

	if(!isset($_POST["userID"])) {
		header("HTTP/1.1 400");
		echo "Missing user ID";
		exit;
	}

	if(!isset($_POST["productID"])) {
		header("HTTP/1.1 400");
		echo "Missing product ID";
		exit;
	}

	$userID = $_POST["userID"];
	$productID = $_POST["productID"];

	$db = new Database();
	$db->queryWithoutResult("DELETE FROM save WHERE user = '$userID' AND product = '$productID'");

	// Close database connection
	$db->close();

	// Return HTTP response
	header("HTTP/1.1 200");
?>