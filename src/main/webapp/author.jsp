<%--
  Created by IntelliJ IDEA.
  User: quocphu
  Date: 14/06/2023
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>${action}</h1>
<a href="authors?action=create">Create Book</a>
<c:if test="${requestScope['authors'].size() != 0}">
    <table border="1">
        <tr>
            <td>Id</td>
            <td>Name</td>
        </tr>
        <c:forEach items="${authors}" var="author">
            <tr>
                <td>${author.id}</td>
                <td>${author.name}</td>
                <td><a href="authors?action=edit&id=${author.id}">Edit</a> </td>
                <td><a href="authors?action=delete&id=${author.id}" onclick="return confirm('Do you want to remove ${author.name}?')">Delete</a> </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
</body>
</html>
