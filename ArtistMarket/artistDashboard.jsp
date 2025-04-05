<%@ page import="javax.servlet.http.Cookie" %>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Artist Dashboard</title></head>
<body>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("rememberUser".equals(c.getName())) {
                    username = c.getValue();
                    session.setAttribute("username", username);
                    break;
                }
            }
        }
    }

    String lastLogin = (String) session.getAttribute("lastLogin");
%>

<h2>Welcome, <%= username != null ? username : "Guest" %> (Artist)</h2>
Session ID: <%= session.getId() %><br>
Last Login: <%= lastLogin != null ? lastLogin : "Not available" %><br><br>

<a href="addportfolio.jsp">Add Artwork</a> |
<a href="updateportfolio.jsp">Update Artwork</a> |
<a href="deleteportfolio.jsp">Delete Artwork</a>



<h3>Your Portfolio</h3>
<%
    String xmlFile = application.getRealPath("/") + "xml/artworks.xml";
    File fXml = new File(xmlFile);
    if (fXml.exists()) {
        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(fXml);
            NodeList artworks = doc.getElementsByTagName("artwork");

            for (int i = 0; i < artworks.getLength(); i++) {
                Element art = (Element) artworks.item(i);
                String name = getText(art, "name");
                String desc = getText(art, "desc");
                String category = getText(art, "category");
                String price = getText(art, "price");
                String image = getText(art, "image");
%>
                <div style="border:1px solid #ccc; padding:10px; margin:10px;">
                    <h3><%= name %></h3>
                    <img src="<%= image %>" alt="Artwork Image" style="width:150px;height:auto;" />
                    <p><%= desc %></p>
                    <p>Category: <%= category %></p>
                    <p>Price: ₹<%= price %></p>
                </div>
<%
            }
        } catch (Exception e) {
            out.println("<p>Error reading artworks: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>No artworks found.</p>");
    }

    // Helper method to avoid null errors
    String getText(Element parent, String tag) {
        NodeList nodeList = parent.getElementsByTagName(tag);
        if (nodeList != null && nodeList.getLength() > 0 && nodeList.item(0) != null)
            return nodeList.item(0).getTextContent();
        return "";
    }
%>

</body>
</html>
