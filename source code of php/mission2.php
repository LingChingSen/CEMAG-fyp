<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$date = $_POST['date'];

$sqlloadmission2 = "SELECT * FROM tbl_271738_globalmarket WHERE buyer = '$email' AND date = '$date' ";;

$result = $conn->query($sqlloadmission2);

if ($result->num_rows > 0) {
    $products['global'] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist['id'] = $row['id'];
        $productlist['email'] = $row['email'];
        $productlist['date'] = $row['date'];
 
        array_push($products['global'], $productlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>