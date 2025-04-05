<%@ page import="javax.servlet.http.Cookie" %>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Client Dashboard</title></head>
<body>

<%
    String username = (String) session.getAttribute("username");
    String lastLogin = (String) session.getAttribute("lastLogin");

    if (username == null || lastLogin == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("rememberUser".equals(c.getName())) {
                    username = c.getValue();
                    session.setAttribute("username", username);
                }
                if ("lastLogin".equals(c.getName())) {
                    lastLogin = c.getValue();
                    session.setAttribute("lastLogin", lastLogin);
                }
            }
        }
    }
%>

<h2>Welcome, <%= username != null ? username : "Guest" %> (Client)</h2>
Session ID: <%= session.getId() %><br>
Last Login: <%= lastLogin != null ? lastLogin : "Not available" %><br><br>


<ul>
    <li><a href="#">Browse Artworks</a></li>
    <li><a href="#">My Commission Requests</a></li>
    <li><a href="#">Leave Feedback</a></li>
</ul>

</body>
</html>
