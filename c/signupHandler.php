<?php
session_start();
$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];
$role = $_POST['role'];

// Store in file or database — for now, use file-based simple storage
$user = "$username|$email|$password|$role\n";
file_put_contents("users.txt", $user, FILE_APPEND);

echo "<script>alert('Registered Successfully! Please log in.'); window.location.href='login.html';</script>";
?>
