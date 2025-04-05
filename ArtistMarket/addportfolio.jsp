<%@ page import="java.io.*, javax.xml.parsers.*, org.w3c.dom.*, javax.xml.transform.*, javax.xml.transform.dom.*, javax.xml.transform.stream.*" %>
<%
    String name = request.getParameter("name");
    String desc = request.getParameter("desc");
    String category = request.getParameter("category");
    String price = request.getParameter("price");
    String image = request.getParameter("image"); // e.g., "images/art1.png"

    if (name != null && image != null) {
        String xmlPath = application.getRealPath("/") + "xml/artworks.xml";
        File xmlFile = new File(xmlPath);

        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc;

        if (xmlFile.exists()) {
            doc = db.parse(xmlFile);
        } else {
            doc = db.newDocument();
            Element root = doc.createElement("artworks");
            doc.appendChild(root);
        }

        Element root = doc.getDocumentElement();
        Element artwork = doc.createElement("artwork");

        Element e1 = doc.createElement("name"); e1.setTextContent(name); artwork.appendChild(e1);
        Element e2 = doc.createElement("desc"); e2.setTextContent(desc); artwork.appendChild(e2);
        Element e3 = doc.createElement("category"); e3.setTextContent(category); artwork.appendChild(e3);
        Element e4 = doc.createElement("price"); e4.setTextContent(price); artwork.appendChild(e4);
        Element e5 = doc.createElement("image"); e5.setTextContent(image); artwork.appendChild(e5);

        root.appendChild(artwork);

        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer transformer = tf.newTransformer();
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        DOMSource source = new DOMSource(doc);
        StreamResult result = new StreamResult(xmlFile);
        transformer.transform(source, result);

        response.sendRedirect("artistDashboard.jsp");
    }
%>

<form method="post">
    <h2>Add Artwork</h2>
    Name: <input type="text" name="name"><br>
    Description: <input type="text" name="desc"><br>
    Category: <input type="text" name="category"><br>
    Price: <input type="text" name="price"><br>
    Image Path (e.g., images/art1.png): <input type="text" name="image"><br>
    <input type="submit" value="Add Artwork">
</form>
