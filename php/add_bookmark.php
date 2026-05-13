<?php
session_start();
require_once 'db.php';
require_once __DIR__ . '/../vendor/autoload.php';

use Embed\Embed;

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_SESSION['user_id'])) {
    $url = $_POST['url'];
    $user_id = $_SESSION['user_id'];

    try {
        $embed = new Embed();
        $info = $embed->get($url);
        $metas = $info->getMetas();

        $title = $metas->str('title') ?: $info->title ?: "No title found";
        $description = $metas->str('description') ?: "No description";
        $favicon = $info->favicon ?: "https://www.google.com/s2/favicons?sz=64&domain=" . parse_url($url, PHP_URL_HOST);
        $tags = "Tool"; // Default tag, or you can add a field for this later
        $date = date("m/d/Y");

        $stmt = $conn->prepare("INSERT INTO bookmarks (user_id, name, url, image, description, tags, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("issssss", $user_id, $title, $url, $favicon, $description, $tags, $date);

        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "id" => $conn->insert_id]);
        } else {
            echo json_encode(["status" => "error", "message" => "Database insert failed"]);
        }

        $stmt->close();
    } catch (Exception $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
}