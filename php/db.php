<?php
$host     = "localhost";
$user     = "root";     
$password = "";
$dbname   = "bookmark_manager";

$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    // Something went wrong
    die("❌ Connection failed: " . $conn->connect_error);
}

$conn->set_charset("utf8mb4");
?>