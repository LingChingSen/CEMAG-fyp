<?php


include_once("dbconnect.php");

$email = $_POST['email'];
$qty = $_POST['qty'];
$total = $_POST['total'];
$date = $_POST['date'];

$sqlairestock = "INSERT INTO tbl_271738_aimarket(email,qty,total,date) VALUES('$email','$qty','$total','$date')";
if($conn->query($sqlairestock) === TRUE){
    echo "success";
}else{
    echo "failed";
}

?>