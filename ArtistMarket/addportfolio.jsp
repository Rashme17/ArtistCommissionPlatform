<%@ page import="java.io.*, javax.xml.parsers.*, org.w3c.dom.*, javax.xml.transform.*, javax.xml.transform.dom.*, javax.xml.transform.stream.*, javax.servlet.http.Part" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String name = request.getParameter("name");
            String desc = request.getParameter("desc");
            String category = request.getParameter("category");
            String price = request.getParameter("price");

            Part imagePart = request.getPart("image");
            String fileName = new File(imagePart.getSubmittedFileName()).getName();
            String savePath = "D:/xampp/htdocs/uploads/" + fileName;
            imagePart.write(savePath); // Save the uploaded image to the server

            // Construct relative path for XML storage
            String imagePath = "uploads/" + fileName;
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
            Element e5 = doc.createElement("image"); e5.setTextContent(imagePath); artwork.appendChild(e5);

            root.appendChild(artwork);

            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(xmlFile);
            transformer.transform(source, result);

            // ✅ Proper server-side redirect (NO HTML OUTPUT BEFORE THIS)
            response.sendRedirect("http://localhost/c/artistDashboard.php");
            return;

        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error occurred: " + e.getMessage() + "</h3>");
            e.printStackTrace(new PrintWriter(out));
        }
    }
%>

<html>
<head><title>Add Artwork</title></head>
<body>
    <h2>Add Artwork</h2>
    <form method="post" enctype="multipart/form-data">
        Name: <input type="text" name="name" required><br>
        Description: <input type="text" name="desc" required><br>
        Category: <input type="text" name="category" required><br>
        Price: <input type="text" name="price" required><br>
        Upload Image: <input type="file" name="image" accept="image/*" required><br><br>
        <input type="submit" value="Upload Artwork">
    </form>
</body>
</html>
