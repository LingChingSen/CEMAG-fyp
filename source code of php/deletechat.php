<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$id = $_POST['id'];

$sqldelete = "DELETE FROM tbl_271738_chat WHERE id='$id'";

              
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "success";
} else {
    echo "failed";
}
?>