<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlpost = "SELECT * FROM tbl_271738_chat WHERE email = '$email' ";

$result = $conn->query($sqlpost);

if ($result->num_rows > 0) {
    $chats['chat'] = array();
    while ($row = $result->fetch_assoc()) {
        $chatlist['email'] = $row['email'];
        $chatlist['sender'] = $row['sender_email'];
        $chatlist['chat'] = $row['chat'];
        $chatlist['id'] = $row['id'];
    
        array_push($chats['chat'], $chatlist);
    }
    echo json_encode($chats);
} else {
    echo "nodata";
}

?>