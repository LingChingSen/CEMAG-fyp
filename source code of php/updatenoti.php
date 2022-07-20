<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlupdate = "SELECT * FROM tbl_271738_globalmarket WHERE email = '$email'";
$result = $conn->query($sqlupdate);
$total = 0;
if ($result->num_rows > 0) {
     while ($row = $result ->fetch_assoc()){
        $total = $total+ $row['number'];
     } 
} 
echo $total;

?>