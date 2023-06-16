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
        .message-error{
            color: red;
        }
    </style>
</head>
<body style="background: #1f1f1f">
<c:if test="${not empty requestScope['message']}">
    <span>${message}</span>
</c:if>

<div class="container">
    <div class="overlay">

        <form id="form-create-song" action="/songs" method="post" enctype="multipart/form-data">
            <div>
                <label for="name">Name</label>
                <input type="text" name="name" id="name" value="${song.name}"/>
                <label class="message-error" id="name-message"></label>
            </div>
            <div>
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
                <label class="message-error" id="author-message"></label>
            </div>
            <div>
                <label  for="category">Category</label>
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
                <label class="message-error" id="category-message"></label>
            </div>
            <div>
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
                <label class="message-error" id="singer-message"></label>
            </div>
            <div>
                <label for="musicFile">Music File:</label>
                <input type="file" id="musicFile" name="filePart"><br><br>
                <label class="message-error" id="song-message"></label>
            </div>
            <div>
                <label for="image">Image</label>
                <input type="text" name="image" id="image" value="${song.image}"/>
                <label class="message-error" id="image-message"></label>
            </div>
            <a href="#" onclick="submitForm()">Create</a>
        </form>
        <a href="/songs">Back</a>
    </div>
</div>

<script>

    function submitForm(){
        if (validateFormSongCreate() ){
            document.getElementById("form-create-song").submit();
        }
    }
    function validateFormSongCreate(){
        const name = document.getElementById("name").value;
        const author = document.getElementById("author").value;
        const category = document.getElementById("category").value;
        const singer = document.getElementById("singer").value;
        const song = document.getElementById("song").value;
        const image = document.getElementById("image").value;
        console.log(name)



        let result = true;
        if (!name || name.trim().length <= 0 || name.trim().length >50){
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
            document.getElementById("song-message").innerHTML = "Bài hát không được để trống";
        }
        if (!image || image.trim().length <= 0){
            result = false;
            document.getElementById("image-message").innerHTML = "Ảnh không được để trống";
        }
        return result;
    }
</script>
</body>
</html>