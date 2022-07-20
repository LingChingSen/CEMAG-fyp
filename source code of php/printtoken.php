<?php
include_once("dbconnect.php");
$user_email = $_POST['email'];

$sql = "SELECT * FROM tbl_271738_user WHERE user_email = '$user_email'";
$result = $conn->query($sql);
$token = 0;

if ($result->num_rows > 0) {
     while ($row = $result ->fetch_assoc()){
        $token = $token+ $row['token'];
        
        
     } 
} 
echo $token;

?>