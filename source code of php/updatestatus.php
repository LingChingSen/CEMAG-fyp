<?php

include_once("dbconnect.php");

$user_email = $_POST['email'];
$newtoken = $_POST['token'];



$sql = "SELECT * FROM tbl_271738_user WHERE user_email = '$user_email'";
$result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE tbl_271738_user SET token = '$newtoken'  WHERE user_email = '$user_email'";
        if ($conn->query($sqlupdate) === TRUE){
                
                echo 'success'.$row["username"].",".$row["age"].",".$row["level"].",".$row["token"].",".$row["jellybeans"].",".$row["status"];
        }else{
                echo 'failed';
        }
    }else{;
        echo "failed";
    }

?>