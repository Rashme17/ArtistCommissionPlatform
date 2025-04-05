<?php
session_start();

$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';
$remember = isset($_POST['remember']);

$found = false;
$role = '';
$lastLoginTime = date("Y-m-d H:i:s");

$file = fopen("users.txt", "r");
while (($line = fgets($file)) !== false) {
    list($savedUser, $email, $savedPass, $savedRole) = explode("|", trim($line));
    if ($username === $savedUser && $password === $savedPass) {
        $found = true;
        $role = $savedRole;

        // Set session variables
        $_SESSION['username'] = $username;
        $_SESSION['role'] = $role;
        $_SESSION['sessionID'] = session_id();
        $_SESSION['lastLogin'] = $lastLoginTime;

        // Set cookies if 'remember me' is checked
        if ($remember) {
            setcookie("rememberUser", $username, time() + 86400 * 30); // 30 days
            setcookie("lastLogin", $lastLoginTime, time() + 86400 * 30); // 30 days
        }

        // Redirect to correct dashboard
        if ($role === "artist") {
            header("Location: artistDashboard.php");
        } else {
            header("Location: clientDashboard.php");
        }
        exit();
    }
}
fclose($file);

// If login failed
echo "<script>alert('Invalid username or password'); window.location.href='login.html';</script>";
exit();
?>
