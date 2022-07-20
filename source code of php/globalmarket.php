<?php
include_once("dbconnect.php");


$sqlpost = "SELECT * FROM tbl_271738_sales  ";

$result = $conn->query($sqlpost);

if ($result->num_rows > 0) {
    $products['sales'] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist['email'] = $row['user_email'];
        $productlist['username'] = $row['name'];
        $productlist['quantity'] = $row['quantity'];
        $productlist['description'] = $row['description'];
        $productlist['total'] = $row['total'];
        $productlist['id'] = $row['id'];
        $productlist['level'] = $row['level'];
        $productlist['tokens'] = $row['tokens'];
        $productlist['jellybeans'] = $row['jellybeans'];
    
        array_push($products['sales'], $productlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>