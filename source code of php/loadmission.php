<?php
include_once("dbconnect.php");



$sqlloadproduct ="SELECT * FROM tbl_271738_mission ";


$result = $conn->query($sqlloadproduct);
 
if($result ->num_rows >0){
    $response["mission"]=array();
    while ($row = $result -> fetch_assoc()){
        $list = array();
        $list['id'] = $row['id'];
        $list['mission'] = $row['mission'];
        $list['token'] = $row['token'];
        $list['jellybean'] = $row['jellybean'];
        $list['exp'] = $row['exp'];
        $list['req'] = $row['req'];
       
        array_push($response["mission"],$list);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>