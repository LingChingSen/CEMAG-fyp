<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$date = $_POST['date'];

$sqlloadmission3 = "SELECT * FROM tbl_271738_sales WHERE user_email = '$email' AND date = '$date' ";;

$result = $conn->query($sqlloadmission3);

if ($result->num_rows > 0) {
    $products['sales'] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist['id'] = $row['id'];
        $productlist['email'] = $row['email'];
        $productlist['date'] = $row['date'];
 
        array_push($products['sales'], $productlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>