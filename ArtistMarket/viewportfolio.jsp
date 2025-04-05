<%@ page import="org.w3c.dom.*, javax.xml.parsers.*, java.io.*" %>
<%
    String xmlPath = application.getRealPath("xml/artworks.xml");
    File xmlFile = new File(xmlPath);
    if (!xmlFile.exists()) return;

    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document doc = builder.parse(xmlFile);

    NodeList list = doc.getElementsByTagName("artwork");

    for (int i = 0; i < list.getLength(); i++) {
        Element art = (Element) list.item(i);
        String name = art.getElementsByTagName("name").item(0).getTextContent();
        String desc = art.getElementsByTagName("description").item(0).getTextContent();
        String img = art.getElementsByTagName("image").item(0).getTextContent();
%>
    <div style="border:1px solid #ccc; margin:10px; padding:10px;">
        <h3><%= name %></h3>
        <img src="<%= img %>" alt="Artwork Image" style="width:150px;height:auto;"><br>
        <p><%= desc %></p>
    </div>
<%
    }
%>
