<%--
  Created by IntelliJ IDEA.
  User: quocphu
  Date: 13/06/2023
  Time: 14:34
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
<a href="/admin/songs">Back</a>
<form action="/admin/songs?action=edit&id=${song.id}" method="post">
    <label for="name">Name</label>
    <input type="text" name="name" id="name" value="${song.name}" />
    <label for="author">Author</label>
    <select name="author" id="author">
        <option value="">--None--</option>

        <c:forEach items="${authors}" var="author">
            <c:if test="${song.author.id == author.id}">
                <option selected value="${author.id}">${author.name}</option>
            </c:if>
            <c:if test="${song.author.id != author.id}">
                <option value="${author.id}">${author.name}</option>
            </c:if>
        </c:forEach>
    </select>
    <label for="category">Category</label>
    <select name="category" id="category" >
        <option value="">--None--</option>
        <c:forEach items="${categorys}" var="category">
            <c:if test="${song.category.id == category.id}">
                <option selected value="${category.id}">${category.name}</option>
            </c:if>
            <c:if test="${song.category.id != category.id}">
                <option value="${category.id}">${category.name}</option>
            </c:if>
        </c:forEach>
<%--        <c:forEach items="${categorys}" var="category">--%>
<%--            <option value="${category.id}">${category.name}</option>--%>
<%--        </c:forEach>--%>
    </select>
    <label for="singer">Category</label>
    <select name="singer" id="singer">
        <option value="">--None--</option>
        <c:forEach items="${singers}" var="singer">
            <c:if test="${song.singer.id == singer.id}">
                <option selected value="${singer.id}">${singer.name}</option>
            </c:if>
            <c:if test="${song.singer.id != singer.id}">
                <option value="${singer.id}">${singer.name}</option>
            </c:if>
        </c:forEach>
<%--        <c:forEach items="${singers}" var="singer">--%>
<%--            <option value="${singer.id}">${singer.name}</option>--%>
<%--        </c:forEach>--%>
    </select>
    <label for="song">Song</label>
    <input type="text" name="song" id="song" value="${song.song}" />
    <label for="image">Ảnh</label>
    <input type="text" name="image" id="image" value="${song.image}" />
    <button type="submit">Edit</button>
</form>
</body>
</html>
