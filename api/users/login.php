<?php
	// login.php
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

	if(!isset($_POST["email"])) {
		header("HTTP/1.1 400");
		echo "Missing email";
		exit;
	}

	if(!isset($_POST["password"])) {
		header("HTTP/1.1 400");
		echo "Missing password";
		exit;
	}

	$email = $_POST["email"];
	$password = $_POST["password"];

	
	$db = new Database();
	$result = $db->query("SELECT * FROM users WHERE email = '$email' AND password = '$password'");


	if(count($result) == 0) {
		header("HTTP/1.1 403");
	} else {

		$userID = $result[0]['id'];

		// Select user's addresses
		$addresses = $db->query("SELECT A.id, A.address, A.civic, A.city, A.CAP, A.province, A.phone FROM users U, delivery D, addresses A WHERE U.id = $userID AND U.ID = D.user AND D.address = A.ID GROUP BY A.ID");
		$result[0]["addresses"] = $addresses;

		// Select user's orders
		$orders = $db->query("SELECT O.ID, O.date, O.delivery, S.state, CONCAT(A.address, ',', A.civic, ',', A.city, ',', A.CAP) FROM orders O, addresses A, states S WHERE O.user = $userID AND O.address = A.ID AND O.state = S.ID GROUP BY O.ID");
		$result[0]["orders"] = $orders;

		// Returns result as JSON
		header("HTTP/1.1 200");
		echo json_encode($result[0], JSON_NUMERIC_CHECK);
	
	}


?>