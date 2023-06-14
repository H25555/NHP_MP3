<%--
  Created by IntelliJ IDEA.
  User: Windows 10
  Date: 14/06/2023
  Time: 1:52 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:if test="${requestScope['message'] != null}">
    <span>${message}</span>
</c:if>
<a href="/admin/users">Back</a><br>
<form action="/admin/users?action=edit&id=${user.id}" method="post">
    <input type="hidden" name="id" value="${user.id}">
    <label for="name">Name</label>
    <input type="text" name="username" id="name" value="${user.username}" />
    <label for="email">Email</label>
    <input type="text" name="password" id="email" value="${user.password}" />
    <select name="role" id="role">
        <option value="">--None--</option>
        <c:forEach items="${roles}" var="role">
            <c:if test="${user.role.id == role.id}">
                <option selected value="${role.id}">${role.name}</option>
            </c:if>
            <c:if test="${user.role.id != role.id}">
                <option value="${role.id}">${role.name}</option>
            </c:if>
        </c:forEach>
    </select>
    <button type="submit">Edit</button>
</form>
</body>
</html>