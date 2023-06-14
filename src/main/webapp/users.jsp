<%--
  Created by IntelliJ IDEA.
  User: Windows 10
  Date: 13/06/2023
  Time: 2:44 CH
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
<form action="/admin/users" method="get">
    <input type="search" name="search" id="search" value="${pageable.search}" onsearch="onClearSearch()" />
    <button id="searchButton">Search</button>
</form>
</br>
<c:if test="${requestScope['users'].size() != 0}">
    <table border="1">
        <tr>
            <td>
                <c:if test="${pageable.sortBy== 'desc'}">
                    <a href="/admin/users?page=${pageable.page}&search=${pageable.search}&sortby=asc&nameField=user.id">
                        Id
                    </a>
                </c:if>
                <c:if test="${pageable.sortBy== 'asc'}">
                    <a href="/admin/users?page=${pageable.page}&search=${pageable.search}&sortby=desc&nameField=user.id">
                        Id
                    </a>
                </c:if>
            </td>
            <td>Name</td>
            <td>Email</td>
            <td>Role</td>
            <td>Action</td>
        </tr>
        <c:forEach items="${users}" var="user">
            <tr>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.password}</td>
                <td>${user.role.name}</td>
                <td><a href="/admin/users?action=edit&id=${user.id}">Edit</a> </td>
                <td><a href="/admin/users?action=delete&id=${user.id}" onclick="return confirm('Do you want to remove ${user.username}?')">Delete</a> </td>
            </tr>
        </c:forEach>
    </table>
    <ul>
        <c:forEach begin="1" end="${pageable.totalPage}" var="page">
            <li><a href="/admin/users?page=${page}&search=${pageable.search}&sortby=${pageable.sortBy}&nameField=${pageable.nameField}">${page}</a> </li>
        </c:forEach>

    </ul>
</c:if>
<script>
    function onClearSearch(){
        searchButton.click();
    }
</script>
</body>
</html>