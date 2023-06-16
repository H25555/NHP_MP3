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
        .message-error{
            color: red;
        }

    </style>

</head>
<body>
<c:if test="${requestScope['message'] != null}">
    <span>${message}</span>
</c:if>
<a href="/songs">Back</a>
<form id="form-edit-song" action="/songs?action=edit&id=${song.id}" method="post">
    <div>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="${song.name}" />
        <label class="message-error" id="name-message"></label>
    </div>
    <div>
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
        <label class="message-error" id="author-message"></label>
    </div>
    <div>
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
            <label class="message-error" id="category-message"></label>
        </select>
    </div>
    <div>
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
        <label class="message-error" id="singer-message"></label>
    </div>
    <div>
        <label for="song">Song</label>
        <input type="text" name="song" id="song" value="${song.song}" />
        <label class="message-error" id="song-message"></label>
    </div>
    <div>
        <label for="image">Ảnh</label>
        <input type="text" name="image" id="image" value="${song.image}" />
        <label class="message-error" id="image-message"></label>
    </div>
    <a href="#"  onclick="submitForm()">Create</a>
</form>
    <a href="/songs">Back</a>
</div>
</div>
</body>
<script>

        function submitForm(){
        if (validateFormSongEdit() ){
        document.getElementById("form-edit-song").submit();
    }
    }
        function validateFormSongEdit(){
        const name = document.getElementById("name").value;
        const author = document.getElementById("author").value;
        const category = document.getElementById("category").value;
        const singer = document.getElementById("singer").value;
        const song = document.getElementById("song").value;
        const image = document.getElementById("image").value;

        let result = true;
        if (name.trim().length <= 0 || name.trim().length > 50 ){
        result = false;
        document.getElementById("name-message").innerHTML ="Tên không được để trống và nhỏ hơn 50 ký tự";
    }

        if (!author || author === "null"){
        result = false;
        document.getElementById("author-message").innerHTML ="Vui lòng chọn nhạc sĩ";
    }
        if (!category || category === "null"){
        result  = false;
        document.getElementById("category-message").innerHTML = "vui long chọn thể loại";
    }
        if (!singer || singer === "null"){
        result = false;
        document.getElementById("singer-message").innerHTML = "Vui lòng chọn ca sĩ ";
    }
        if (!song || song.trim().length <= 0){
        result = false;
        document.getElementById("song-message").innerHTML = "Link bài hát không được để trống";
    }
        if (!image || image.trim().length <= 0){
        result = false;
        document.getElementById("image-message").innerHTML = "Link ảnh không được để trống";
    }
        return result;
    }
</script>
</html>
