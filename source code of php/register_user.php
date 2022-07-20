<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home/crimsonw/public_html/s271738/cemag/php/PHPMailer/src/Exception.php';
require '/home/crimsonw/public_html/s271738/cemag/php/PHPMailer/src/PHPMailer.php';
require '/home/crimsonw/public_html/s271738/cemag/php/PHPMailer/src/SMTP.php';

include_once("dbconnect.php");

$username = $_POST['username'];
$user_email = $_POST['email'];
$age = $_POST['age'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(1000,9999);
$level = "1";
$token = "5000";
$jellybeans = "1000";
$exp = "800";



$sqlregister = "INSERT INTO tbl_271738_user(username,user_email,age,password,otp,level,token,jellybeans,exp) VALUES('$username','$user_email','$age','$passha1','$otp','$level','$token','$jellybeans','$exp')";
if($conn->query($sqlregister) === TRUE){
    sendEmail($otp,$user_email);
    echo "success";
}else{
    echo "failed";
}
function sendEmail($otp,$user_email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                                       //Disable verbose debug output
    $mail->isSMTP();                                            //Send using SMTP
    $mail->Host       = 'mail.crimsonwebs.com';                 //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
    $mail->Username   = 'noreply@crimsonwebs.com';            //SMTP username
    $mail->Password   = 'xS)1DEbCZCwO';                         //SMTP password
    $mail->SMTPSecure = 'none';         
    $mail->Port       = 25;
    
    $from = "noreply@crimsonwebs.com";
    $to = $user_email;
    $subject = "From CEMAG. Please Verify Your Account";
    $message = "<p>Click the following link to verify your account<br><br>
    <a href='https://crimsonwebs.com/s271738/cemag/php/verify_account.php?email=".$user_email."&key=".$otp."'>Click Here to verify your account</a>";
    
    $mail->setFrom($from,"CEMAG");
    $mail->addAddress($to);  
    
    $mail->isHTML(true);                    //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
    
}
?>
