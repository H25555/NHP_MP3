<%--
  Created by IntelliJ IDEA.
  User: Windows 10
  Date: 13/06/2023
  Time: 2:44 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:if test="${requestScope['message'] != null}">
    <span>${message}</span>
</c:if>
<form action="/admin/users?action=create" method="post">
    <label for="username">Username</label>
    <input type="text" name="username" id="username">
    <label for="password">Password</label>
    <input type="password" name="password" id="password">
    <select name="role_id" id="role"  >
        <option value="">--None--</option>
        <c:forEach items="${roles}" var="role">
            <option value="${role.id}">${role.name}</option>
        </c:forEach>
    </select>
    <button>Submit</button>
</form>
</body>
</html>
