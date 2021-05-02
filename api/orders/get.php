<?php
	// get.php (orders)
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

	$db = new Database();

	$userID = $_POST["userID"];
	$orders = $db->query("SELECT O.ID, O.date, O.delivery, CONCAT(A.address, ' ', A.civic, ' - ', A.city, ', ', A.CAP) AS 'address', S.state, O.total FROM orders O, addresses A, states S WHERE O.user = $userID AND O.address = A.ID AND O.state = S.ID GROUP BY O.ID");

	if(count($orders) == 0) {
		header("HTTP/1.1 404");
	} else {
		header("HTTP/1.1 200");
		echo json_encode($result[0], JSON_NUMERIC_CHECK);
	}
?>