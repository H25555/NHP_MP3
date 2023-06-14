<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .overlay {
            background-color: rgba(0, 0, 0, 0.5); /* Màu sắc nền của khung mờ */
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            color: white;
            width: 30%;
        }

        form {
            font-family: Arial, sans-serif;
        }

        label, input, select {
            font-size: 16px;
        }

        input[type="text"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        select {
            appearance: none;
            background-repeat: no-repeat;
            background-position: right center;
            padding-right: 25px;
        }

        input[type="text"]:hover,
        input[type="text"]:focus,
        select:hover,
        select:focus {
            border-color: #0099ff;
            outline: none;
        }

        button[type="submit"] {
            padding: 10px 20px;
            background-color: #0099ff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #0077cc;
        }

        a {
            color: #0099ff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body style="background: #1f1f1f">
<c:if test="${not empty requestScope['message']}">
    <span>${message}</span>
</c:if>

<div class="container">
    <div class="overlay">

        <form action="/songs" method="post" enctype="multipart/form-data">
            <label for="name">Name</label>
            <input type="text" name="name" id="name" value="${song.name}"/>
            <label for="author">Author</label>
            <select name="author" id="author">
                <option value="">--None--</option>
                <c:forEach items="${authors}" var="author">
                    <c:if test="${author.id == song.author.id}">
                        <option value="${author.id}" selected>${author.name}</option>
                    </c:if>
                    <c:if test="${author.id != song.author.id}">
                        <option value="${author.id}">${author.name}</option>
                    </c:if>
                </c:forEach>
            </select>
            <label for="category">Category</label>
            <select name="category" id="category">
                <option value="">--None--</option>
                <c:forEach items="${categorys}" var="category">
                    <c:if test="${category.id == song.category.id}">
                        <option value="${category.id}" selected>${category.name}</option>
                    </c:if>
                    <c:if test="${category.id != song.category.id}">
                        <option value="${category.id}">${category.name}</option>
                    </c:if>
                </c:forEach>
            </select>
            <label for="singer">Singer</label>
            <select name="singer" id="singer">
                <option value="">--None--</option>
                <c:forEach items="${singers}" var="singer">
                    <c:if test="${singer.id == song.singer.id}">
                        <option value="${singer.id}" selected>${singer.name}</option>
                    </c:if>
                    <c:if test="${singer.id != song.singer.id}">
                        <option value="${singer.id}">${singer.name}</option>
                    </c:if>
                </c:forEach>
            </select>
            <label for="musicFile">Music File:</label>
            <input type="file" id="musicFile" name="filePart"><br><br>
            <label for="image">Image</label>
            <input type="text" name="image" id="image" value="${song.image}"/>
            <button type="submit">Create</button>
        </form>
        <a href="/songs">Back</a>
    </div>
</div>

</body>
</html>