<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlchat = "SELECT * FROM tbl_271738_chat WHERE email = '$email'";
$result = $conn->query($sqlchat);
$total = 0;
if ($result->num_rows > 0) {
     while ($row = $result ->fetch_assoc()){
        $total = $total+ $row['qty'];
     } 
} 
echo $total;

?>