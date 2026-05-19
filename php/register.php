<?php
session_start(); 
require_once 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];
    $pass  = $_POST['password'];

    $hashed_pass = password_hash($pass, PASSWORD_DEFAULT);

    $stmt = $conn->prepare("INSERT INTO users (email, password) VALUES (?, ?)");
    $stmt->bind_param("ss", $email, $hashed_pass);

    try {
        if ($stmt->execute()) {
            $_SESSION['user_id'] = $conn->insert_id; 
            // Success
            echo "success";
        }
    } catch (mysqli_sql_exception $e) {
        if ($e->getCode() == 1062) {
            // Email Error
            echo "emailRegistered";
        } else {
            // Something went wrong
            echo "error";
        }
    }

    $stmt->close();
    $conn->close();
}
?>
