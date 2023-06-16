<%--
  Created by IntelliJ IDEA.
  User: quocphu
  Date: 14/06/2023
  Time: 16:22
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
<a href="/authors">Back</a>
<form id="from-create-author" action="/authors?action=create" method="post">
    <div>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="${author.name}" />
        <label style="color: red" id="error_name"></label>
    </div>
    <a href="#"  onclick="submitFromAuthor()">Create</a>
</form>
</body>
<script>
    function submitFromAuthor(){
        if (validateFromCreateAuthor()){
            document.getElementById("from-create-author").submit();
    }
    }
    function validateFromCreateAuthor(){
        const name = document.getElementById("name").value;

        let result = true;
        if (!name || name.trim().length <= 0 || name.trim().length >50){
            result = false;
            document.getElementById("error_name").innerHTML = "Tên không được để trống hoặc quá 50 ký tự"
        }
        return result;
    }

</script>
</html>
