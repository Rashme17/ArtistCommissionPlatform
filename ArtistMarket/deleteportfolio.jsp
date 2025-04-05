<%@ page import="java.io.*, javax.xml.parsers.*, org.w3c.dom.*, javax.xml.transform.*, javax.xml.transform.dom.*, javax.xml.transform.stream.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Delete Artwork</title></head>
<body>
<h2>Delete Artwork</h2>
<form method="post">
    Artwork Name to Delete: <input type="text" name="name" required><br>
    <input type="submit" value="Delete">
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
                    art.getParentNode().removeChild(art);
                    break;
                }
            }

            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(fXml);
            transformer.transform(source, result);
            out.println("<p>Artwork deleted successfully!</p>");
        }
    }
%>
<a href="artistDashboard.jsp">Back to Dashboard</a>
</body>
</html>
