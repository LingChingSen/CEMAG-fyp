<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlloadcart = "SELECT * FROM tbl_271738_jellybeans INNER JOIN tbl_271738_id ON tbl_271738_carts.prid = tbl_271738_id.prid WHERE tbl_271738_jellybeans.email = '$email'";;

$result = $conn->query($sqlloadcart);

if ($result->num_rows > 0) {
    $products['ai'] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist['productId'] = $row['prid'];
        $productlist['price'] = $row['prprice'];
        $productlist['jellyqty'] = $row['qty'];
 
        array_push($products['ai'], $productlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>