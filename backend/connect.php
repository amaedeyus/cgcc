<?php 
$host="localhost";
$user="root";
$pass="";
$db="form_builder";
$conn=new mysqli($host, $user, $pass, $db);

if($conn->connect_error){
    echo "Failed to connect to the database".$conn->connect_error;
}

?>