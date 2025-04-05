<?php
session_start();
if (!isset($_SESSION['username'])) {
    if (isset($_COOKIE['rememberUser'])) {
        $_SESSION['username'] = $_COOKIE['rememberUser'];
    } else {
        header("Location: login.html");
        exit();
    }
}
$username = $_SESSION['username'];
$sessionID = session_id();
$lastLogin = $_SESSION['lastLogin'] ?? $_COOKIE['lastLogin'] ?? "Not Available";
?>
<!DOCTYPE html>
<html>
<head>
  <title>Client Dashboard</title>
</head>
<body>
  <h2>Welcome, <?= htmlspecialchars($username) ?> (Client)</h2>
  <p>Session ID: <?= $sessionID ?></p>
  <p>Last Login: <?= $lastLogin ?></p>

  <hr>
  <a href="http://localhost:8080/ArtistMarket/browse.jsp">Browse Artworks</a> |
  <a href="http://localhost:8080/ArtistMarket/request.jsp">My Commission Requests</a> |
  <a href="http://localhost:8080/ArtistMarket/feedback.jsp">Leave Feedback</a>
</body>
</html>
