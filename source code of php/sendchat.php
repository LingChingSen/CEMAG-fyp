<?php

include_once("dbconnect.php");
$email = $_POST['email'];
$chat = $_POST['chat'];
$sender = $_POST['sender'];
						
$sqlinsert = "INSERT INTO tbl_271738_chat(email,chat,sender_email) VALUES('$email','$chat','$sender')";
if ($conn->query($sqlinsert) === TRUE){

    echo "success";
}else{
    echo "failed";
}