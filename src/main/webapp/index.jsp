<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<c:if test="${sessionScope.user == null}">
    <a href="/user?action=login">Login</a>

</c:if>
<c:if test="${sessionScope.user != null}">
    Logined
    <h1>${sessionScope.user.role.name}</h1>
    <a href="/user?action=logout">Logout</a>
</c:if>

</body>
</html>