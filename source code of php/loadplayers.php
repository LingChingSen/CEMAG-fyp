<?php
include_once("dbconnect.php");
$name = $_POST['name'];


$sqlloadproduct = "SELECT * FROM tbl_271738_user WHERE username LIKE '%$name%'";


$result = $conn->query($sqlloadproduct);
 
if($result ->num_rows >0){
    $response["players"]=array();
    while ($row = $result -> fetch_assoc()){
         $list = array();
        $list['email'] = $row['user_email'];
        $list['name'] = $row['username'];
        $list['level'] = $row['level'];
        $list['token'] = $row['token'];
        $list['jellybeans'] = $row['jellybeans'];
      
        array_push($response["players"],$list);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>