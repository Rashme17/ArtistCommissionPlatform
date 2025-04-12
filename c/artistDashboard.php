<?php
session_start();
$username = $_SESSION['username'] ?? 'Guest';
$sessionID = session_id();
$lastLogin = $_SESSION['lastLogin'] ?? 'Not Available';
?>

<!DOCTYPE html>
<html>
<head>
    <title>Artist Dashboard</title>
    <style>
        .artwork {
            border: 1px solid #ccc;
            padding: 15px;
            margin: 15px 0;
            width: 350px;
        }
        .artwork img {
            width: 100%;
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
$xmlFile = "D:/xampp/tomcat/webapps/ArtistMarket/xml/artworks.xml"; // or move this to htdocs/xml/artworks.xml for better access
if (file_exists($xmlFile)) {
    $doc = new DOMDocument();
    $doc->load($xmlFile);
    $artworks = $doc->getElementsByTagName("artwork");

    foreach ($artworks as $art) {
        $name = getTag($art, "name");
        $desc = getTag($art, "desc");
        $category = getTag($art, "category");
        $price = getTag($art, "price");
        $image = getTag($art, "image");

        echo "<div class='artwork'>";
        echo "<h3>" . htmlspecialchars($name) . "</h3>";
        echo "<img src='/" . htmlspecialchars($image) . "' alt='Artwork Image'>";
        echo "<p><strong>Description:</strong> " . htmlspecialchars($desc) . "</p>";
        echo "<p><strong>Category:</strong> " . htmlspecialchars($category) . "</p>";
        echo "<p><strong>Price:</strong> ₹" . htmlspecialchars($price) . "</p>";
        echo "</div>";
    }
} else {
    echo "<p>No artworks found.</p>";
}

function getTag($parent, $tag) {
    $node = $parent->getElementsByTagName($tag);
    return ($node->length > 0) ? $node->item(0)->textContent : "N/A";
}
?>

</body>
</html>
