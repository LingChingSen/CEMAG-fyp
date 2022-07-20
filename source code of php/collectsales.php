<?php
include_once("dbconnect.php");

$id = $_POST['id'];


$sqldelete = "DELETE FROM tbl_271738_globalmarket WHERE id='$id'";

              
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "success";
} else {
    echo "failed";
}
?>