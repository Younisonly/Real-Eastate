<?php

// MySQL connection configuration
$servername = "localhost";
$database = "real_estate_assignment";
$username = "root";
$password = "";

// Establish database connection
try {
    $pdo = new PDO("mysql:host=$servername;dbname=$database", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// API response array
$response = array();

// Fetch data from the database
try {
    $stmt = $pdo->query("SELECT * FROM images");
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $response['success'] = true;
    $response['data'] = $data;
} catch (PDOException $e) {
    $response['success'] = false;
    $response['message'] = 'Failed to fetch data from the database: ' . $e->getMessage();
}

// Return JSON response
header('Content-Type: application/json');
echo json_encode($response);