<?php
session_start();
if (!isset($_SESSION['username'])) {
    header("Location: login.html");
    exit();
}

$username = $_SESSION['username'];
$sessionID = session_id();
$lastLogin = $_SESSION['lastLogin'] ?? date("Y-m-d H:i:s");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Artist Dashboard</title>
    <style>
        .artwork-box {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 10px 0;
        }
        .artwork-box img {
            width: 150px;
            height: auto;
        }
    </style>
</head>
<body>

<h2>Welcome, <?= htmlspecialchars($username) ?> (Artist)</h2>
<p>Session ID: <?= $sessionID ?></p>
<p>Last Login: <?= $lastLogin ?></p>

<hr>

<a href="http://localhost:8080/ArtistMarket/addportfolio.jsp">Add Artwork</a> |
<a href="http://localhost:8080/ArtistMarket/updateportfolio.jsp">Update Artwork</a> |
<a href="http://localhost:8080/ArtistMarket/deleteportfolio.jsp">Delete Artwork</a>

<h3>Your Portfolio</h3>

<?php
$xmlFile = "D:/xampp/tomcat/webapps/ArtistMarket/xml/artworks.xml";
if (file_exists($xmlFile)) {
    $doc = new DOMDocument();
    $doc->load($xmlFile);
    $artworks = $doc->getElementsByTagName("artwork");

    foreach ($artworks as $art) {
        $name = getTagText($art, "name");
        $desc = getTagText($art, "desc");
        $category = getTagText($art, "category");
        $price = getTagText($art, "price");
        $image = getTagText($art, "image");

        echo "<div class='artwork-box'>";
        echo "<h3>" . htmlspecialchars($name) . "</h3>";
        echo "<img src='images/" . htmlspecialchars($image) . "' alt='Artwork Image' />";
        echo "<p>" . htmlspecialchars($desc) . "</p>";
        echo "<p>Category: " . htmlspecialchars($category) . "</p>";
        echo "<p>Price: ₹" . htmlspecialchars($price) . "</p>";
        echo "</div>";
    }
} else {
    echo "<p>No artworks found.</p>";
}

// Helper function to safely get tag text
function getTagText($parent, $tag) {
    $nodeList = $parent->getElementsByTagName($tag);
    return ($nodeList->length > 0) ? $nodeList->item(0)->textContent : "N/A";
}
?>

</body>
</html>
