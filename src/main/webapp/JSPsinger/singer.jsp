<%--
  Created by IntelliJ IDEA.
  User: quocphu
  Date: 14/06/2023
  Time: 21:27
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
<a href="singers?action=create">Create Book</a>
<c:if test="${requestScope['singers'].size() != 0}">
  <table border="1">
    <tr>
      <td>Id</td>
      <td>Name</td>
    </tr>
    <c:forEach items="${singers}" var="singer">
      <tr>
        <td>${singer.id}</td>
        <td>${singer.name}</td>
        <td><a href="singers?action=edit&id=${singer.id}">Edit</a> </td>
        <td><a href="singers?action=delete&id=${singer.id}" onclick="return confirm('Do you want to remove ${singer.name}?')">Delete</a> </td>
      </tr>
    </c:forEach>
  </table>
</c:if>
</body>
</html>
