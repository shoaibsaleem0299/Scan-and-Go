<?php

// Function to fetch product information by ID
function getProductById($productId) {
    // Connect to your database (replace these variables with your actual database credentials)
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "signup_test";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Prepare SQL statement
    $sql = "SELECT productId, name, description, price, category, imageUrl, status, location, quantity FROM product_data WHERE productId = ?";

    // Prepare and bind parameters
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $productId);

    // Execute query
    $stmt->execute();

    // Bind result variables
    $stmt->bind_result($productId, $name, $description, $price, $category, $imageUrl, $status, $location, $quantity);

    // Fetch result
    $stmt->fetch();

    // Close statement
    $stmt->close();

    // Close connection
    $conn->close();

    // Return product information as an associative array
    return array(
        "productId" => $productId,
        "name" => $name,
        "description" => $description,
        "price" => $price,
	"category" => $category,
	"imageUrl" => $imageUrl,
	"status" => $status,
	"location" => $location,
	"quantity" => $quantity,
    );
}

// Usage example:
// Assuming you pass the product ID through GET or POST parameter named 'id'
if(isset($_REQUEST['productId'])) {
    $productId = $_REQUEST['productId'];
    $product = getProductById($productId);
    if($product) {
        // Return JSON response with product information
        header('Content-Type: application/json');
        echo json_encode($product);
    } else {
        // Product not found
        header("HTTP/1.0 404 Not Found");
        echo json_encode(array("error" => "Product not found"));
    }
} else {
    // No product ID provided
    header("HTTP/1.0 400 Bad Request");
    echo json_encode(array("error" => "Product ID not provided"));
}
?>
