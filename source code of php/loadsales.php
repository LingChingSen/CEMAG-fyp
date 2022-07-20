<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlpost = "SELECT * FROM tbl_271738_sales WHERE user_email = '$email' ";

$result = $conn->query($sqlpost);

if ($result->num_rows > 0) {
    $products['post'] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist['email'] = $row['user_email'];
        $productlist['username'] = $row['name'];
        $productlist['quantity'] = $row['quantity'];
        $productlist['description'] = $row['description'];
        $productlist['total'] = $row['total'];
        $productlist['id'] = $row['id'];
    
        array_push($products['post'], $productlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>