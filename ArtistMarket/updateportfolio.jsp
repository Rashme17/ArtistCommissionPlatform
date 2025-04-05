<%@ page import="java.io.*, javax.xml.parsers.*, org.w3c.dom.*, javax.xml.transform.*, javax.xml.transform.dom.*, javax.xml.transform.stream.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Update Artwork</title></head>
<body>
<h2>Update Artwork</h2>
<form method="post">
    Artwork Name to Update: <input type="text" name="name" required><br>
    New Description: <input type="text" name="desc"><br>
    New Category: <input type="text" name="category"><br>
    New Price: <input type="text" name="price"><br>
    New Image Path: <input type="text" name="image"><br>
    <input type="submit" value="Update">
</form>

<%
    String name = request.getParameter("name");
    if (name != null) {
        String xmlFile = application.getRealPath("/") + "xml/artworks.xml";
        File fXml = new File(xmlFile);
        if (fXml.exists()) {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(fXml);
            NodeList artworks = doc.getElementsByTagName("artwork");

            for (int i = 0; i < artworks.getLength(); i++) {
                Element art = (Element) artworks.item(i);
                if (art.getElementsByTagName("name").item(0).getTextContent().equals(name)) {
                    if (request.getParameter("desc") != null) art.getElementsByTagName("desc").item(0).setTextContent(request.getParameter("desc"));
                    if (request.getParameter("category") != null) art.getElementsByTagName("category").item(0).setTextContent(request.getParameter("category"));
                    if (request.getParameter("price") != null) art.getElementsByTagName("price").item(0).setTextContent(request.getParameter("price"));
                    if (request.getParameter("image") != null) art.getElementsByTagName("image").item(0).setTextContent(request.getParameter("image"));
                    break;
                }
            }

            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(fXml);
            transformer.transform(source, result);
            out.println("<p>Artwork updated successfully!</p>");
        }
    }
%>
<a href="artistDashboard.jsp">Back to Dashboard</a>
</body>
</html>
