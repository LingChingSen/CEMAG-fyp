<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$sqlpost = "SELECT * FROM tbl_271738_globalmarket WHERE email = '$email' ";

$result = $conn->query($sqlpost);

if ($result->num_rows > 0) {
    $products['sold'] = array();
    while ($row = $result->fetch_assoc()) {
         $productlist['buyer'] = $row['buyer'];
         $productlist['email'] = $row['email'];
        $productlist['quantity'] = $row['qty'];
        $productlist['total'] = $row['total'];
        $productlist['id'] = $row['id'];
    
        array_push($products['sold'], $productlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>