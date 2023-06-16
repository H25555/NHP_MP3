<%--
  Created by IntelliJ IDEA.
  User: quocphu
  Date: 14/06/2023
  Time: 20:14
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
<a href="categorys?action=create">Create Book</a>
<c:if test="${requestScope['categorys'].size() != 0}">
    <table border="1">
        <tr>
            <td>Id</td>
            <td>Name</td>
        </tr>
        <c:forEach items="${categorys}" var="category">
            <tr>
                <td>${category.id}</td>
                <td>${category.name}</td>
                <td><a href="categorys?action=edit&id=${category.id}">Edit</a> </td>
                <td><a href="categorys?action=delete&id=${category.id}" onclick="return confirm('Do you want to remove ${category.name}?')">Delete</a> </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
</body>
</html>
