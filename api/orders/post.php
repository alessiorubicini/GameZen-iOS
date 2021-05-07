<?php
	// post.php (orders)
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

	if(!isset($_POST["userID"])) {
		header("HTTP/1.1 400");
		echo "Missing user ID";
		exit;
	}

	if(!isset($_POST["date"]) || !isset($_POST["delivery"]) || !isset($_POST["address"]) || !isset($_POST["total"])) {
		header("HTTP/1.1 400");
		echo "Missing some order info";
		exit;
	}

	if(!isset($_POST["products"])) {
		header("HTTP/1.1 400");
		echo "Missing products";
		exit;
	}

	// Get the passed data
	$userID = $_POST["userID"];
	$date = $_POST["date"];
	$delivery = $_POST["delivery"];
	$addressID = $_POST["address"];
	$total = $_POST["total"];
	$products = $_POST["products"];

	// Database
	$db = new Database();

	header("HTTP/1.1 200");
	echo $products;


?>