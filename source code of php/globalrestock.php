<?php
include_once("dbconnect.php");

$id = $_POST['id'];
$buyer = $_POST['buyer'];
$date = $_POST['date'];




 $sqladd ="INSERT INTO tbl_271738_globalmarket(id,email,qty,total) SELECT id,user_email, quantity,total FROM tbl_271738_sales
              WHERE id='$id'";
              
 $sqlupdate = "UPDATE tbl_271738_globalmarket SET buyer = '$buyer' WHERE id = '$id'";
  $sqlupdate2 = "UPDATE tbl_271738_globalmarket SET date = '$date' WHERE id = '$id'";
 
  
              
$sqldelete = "DELETE FROM tbl_271738_sales WHERE id='$id'";

     
$stmtadd = $conn->prepare($sqladd);
   $stmtadd->execute();
   
  $stmtupdate = $conn->prepare($sqlupdate);
   $stmtupdate->execute();
   $stmtupdate2 = $conn->prepare($sqlupdate2);
   $stmtupdate2->execute();

   
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "success";
} else {
    echo "failed";
}
?>