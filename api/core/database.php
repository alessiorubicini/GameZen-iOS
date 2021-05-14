<?php
	// database.php
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

	class Database {

		private $conn;
		private $host = "localhost";
		private $username = "root";
		private $password = "root";
		private $database = "gamezen";

		function __construct() {
			// Create connection
			$this->conn = new mysqli($this->host, $this->username, $this->password, $this->database);

			// Check connection
			if ($this->conn->connect_error) {
				header("HTTP/1.1 500");
				echo "Connection failed: " . $this->conn->connect_error;
			} 
		}

		// Make a query parameter secure by preventing security vulnerabilities
		public function makeSecure($parameter) {
			
			// Prevent XSS
			$result = strip_tags($parameter);
			$result = htmlspecialchars($result);

			// Prevent SQL injection
			$result = $this->conn->real_escape_string($result);
			
			return $result;
		}

		// Run a SQL query and returns the mysqli result as a dictionary
		public function query($query) {
			// Prevent SQL injection
			$query = strip_tags($query);
			
			// Run query
			$result = $this->conn->query($query);

			if(!$result) {
				header("HTTP/1.1 500");
				echo "DATABASE QUERY ERROR: " .$this->conn->error;
				return false;
			}


			$array = array();
			while($row = $result->fetch_assoc()) {
				$array[] = $row;
			}
			
			return $array;
		}

		// Run a SQL query without returning data
		public function queryWithoutResult($query) {
			$query = strip_tags($query);
			
			$result = mysqli_query($this->conn, $query);

			if(!$result) {
				header("HTTP/1.1 500");
				echo "DATABASE QUERY ERROR: " .$this->conn->error;
				return false;
			}
			
			return $result;
		}

		// Begin an SQL transaction
		public function beginTransaction() {
			$this->conn->begin_transaction();
		}

		public function commitTransaction() {
			$this->conn->commit();
		}

		// Close connection to database
		public function close() {
			$this->conn->close();
		}
		
	}

?>