<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>


<c:if test="${sessionScope.user != null}">
    <a href="/home?action=logout">Logout</a>
    <a href="/admin/users">User Management</a>
</c:if>

<c:if test="${sessionScope.user == null}">
    <a href="/login">Login</a>
</c:if>
<%--<c:if test="${sessionScope.}"></c:if>--%>

</body>
</html>