<?php

include_once("dbconnect.php");
$email = $_POST['email'];
$name = $_POST['name'];
$qty = $_POST['quantity'];
$description = $_POST['description'];
$total=  $_POST['total'];
$date=  $_POST['date'];
$level=  $_POST['level'];
$tokens=  $_POST['tokens'];
$jellybeans=  $_POST['jellybeans'];
						
$sqlinsert = "INSERT INTO tbl_271738_sales(user_email,name,quantity,description,total,date,level,tokens,jellybeans) VALUES('$email','$name','$qty','$description','$total','$date','$level','$tokens','$jellybeans')";
if ($conn->query($sqlinsert) === TRUE){

    echo "success";
}else{
    echo "failed";
}