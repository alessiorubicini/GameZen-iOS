<?php
	// post.php (addresses)
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

	// Check if all data has been passed
	if(!isset($_POST["userID"])) {
		header("HTTP/1.1 400");
		echo "Missing userID";
		exit;
	}

	if(!isset($_POST["address"]) || !isset($_POST["civic"]) || !isset($_POST["city"]) || !isset($_POST["CAP"]) || !isset($_POST["province"]) || !isset($_POST["phone"])) {
		header("HTTP/1.1 400");
		echo "Missing some address data";
		exit;
	}

	// Get passed data
	$userID = $_POST["userID"];
	$address = $_POST["address"];
	$civic = $_POST["civic"];
	$city  = $_POST["city"];
	$CAP = $_POST["CAP"];
	$province = $_POST["province"];
	$phone = $_POST["phone"];

	// Begin transaction
	$db = new Database();
	$db->conn->begin_transaction();
	
	// Add the address to the database
	$addResult = $db->queryWithoutResult("INSERT INTO addresses(address, civic, city, CAP, province, phone) VALUES('$address', '$civic', '$city', '$CAP', '$province', '$phone')");
	
	// Select the address' ID
	$addressID = $db->query("SELECT A.id FROM addresses A WHERE A.address = '$address' AND A.civic = '$civic' AND A.city = '$city' AND A.province = '$province' AND A.phone = '$phone'")[0]["id"];
	
	// Add user-address relationship
	$relResult = $db->queryWithoutResult("INSERT INTO delivery (user, address) VALUES ('$userID', '$addressID[0]')");

	// Commit transaction and return HTTP response
	$db->conn->commit();
	header("HTTP/1.1 200");

?>