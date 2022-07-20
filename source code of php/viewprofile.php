<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlpost = "SELECT * FROM tbl_271738_user ";

$result = $conn->query($sqlpost);

if ($result->num_rows > 0) {
    $products['profile'] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist['email'] = $row['user_email'];
        $productlist['username'] = $row['username'];
        $productlist['level'] = $row['level'];
        $productlist['token'] = $row['token'];
        $productlist['jellybeans'] = $row['jellybeans'];
        
    
        array_push($products['profile'], $productlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>