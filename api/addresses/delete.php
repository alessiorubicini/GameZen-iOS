<?php
	// delete.php (addresses)
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

	// Check if all data has been passed
	if(!isset($_POST["addressID"])) {
		header("HTTP/1.1 400");
		echo "Missing address ID";
		exit;
	}

	// Get passed data
	$addressID = $_POST["addressID"];

	// Remove address from database
	$db = new Database();
	$db->queryWithoutResult("DELETE FROM delivery WHERE address = '$addressID'");
	$db->queryWithoutResult("DELETE FROM addresses WHERE id = '$addressID'");+

	// Close database connection
	$db->close();

	// Return HTTP response
	header("HTTP/1.1 200");
	
?>