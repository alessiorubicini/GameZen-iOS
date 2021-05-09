<?php
	// register.php
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

	if(!isset($_POST["name"]) || !isset($_POST["surname"]) || !isset($_POST["email"]) || !isset($_POST["password"]) || !isset($_POST["birthDate"])) {
		header("HTTP/1.1 400");
		echo "Missing some user info";
		exit;
	}

	$name = $_POST["name"];
	$surname = $_POST["surname"];
	$email = $_POST["email"];
	$password = $_POST["password"];
	$birthDate = $_POST["birthDate"];

	$db = new Database();

	// Check if user already exists
	$result = $db->query("SELECT * FROM users U WHERE U.email = '$email'");

	if(count($result) != 0) {
		header("HTTP/1.1 409");
		echo "User with this email already exists";
		exit;
	}

	// Create the new user
	$db->queryWithoutResult("INSERT INTO users(name, surname, email, password, birth) VALUES('$name', '$surname', '$email', '$password', '$birthDate')");

	header("HTTP/1.1 200");

?>