<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$date = $_POST['date'];

$sqlloadmission1 = "SELECT * FROM tbl_271738_aimarket WHERE email = '$email' AND date = '$date' ";;

$result = $conn->query($sqlloadmission1);

if ($result->num_rows > 0) {
    $products['ai'] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist['id'] = $row['id'];
        $productlist['email'] = $row['email'];
        $productlist['date'] = $row['date'];
 
        array_push($products['ai'], $productlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>