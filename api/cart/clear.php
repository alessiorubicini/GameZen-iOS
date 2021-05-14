<?php
	// clear.php
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
	header('Content-Type: text/plain');

	// Including database interface class
	require_once('../core/database.php');

	// Check if the client passed the user ID
	if(!isset($_GET["userID"])) {
		header("HTTP/1.1 400");
		echo "Missing user ID";
		exit;
	}

	// Setup database interface
	$db = new Database();

	// Get the user ID
	$userID = $db->makeSecure($_GET["userID"]);

	// Delete all products in cart
	$db->queryWithoutResult("DELETE FROM save WHERE user = '$userID'");

	// Close database connection
	$db->close();

	// Return HTTP response
	header("HTTP/1.1 200");
	echo "Cart cleared successfully";

?>