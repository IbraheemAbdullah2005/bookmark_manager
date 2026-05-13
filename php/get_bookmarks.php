<?php
session_start();
require_once 'db.php';

$user_id = $_SESSION['user_id'];

$stmt = $conn->prepare("SELECT id, name, url, image FROM bookmarks WHERE user_id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

$bookmarks = [];
while ($row = $result->fetch_assoc()) {
    $bookmarks[] = $row;
}

header('Content-Type: application/json');
echo json_encode($bookmarks);