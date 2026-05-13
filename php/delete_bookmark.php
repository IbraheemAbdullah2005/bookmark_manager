<?php
session_start();
require_once 'db.php';

if (isset($_SESSION['user_id']) && isset($_POST['id'])) {
    $user_id = $_SESSION['user_id'];
    $bookmark_id = $_POST['id'];

    $stmt = $conn->prepare("DELETE FROM bookmarks WHERE id = ? AND user_id = ?");
    $stmt->bind_param("ii", $bookmark_id, $user_id);

    if ($stmt->execute()) {
        echo "success";
    } else {
        echo "error";
    }

    $stmt->close();
} else {
    echo "unauthorized";
}
$conn->close();