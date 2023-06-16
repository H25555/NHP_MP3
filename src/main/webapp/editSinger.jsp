<%--
  Created by IntelliJ IDEA.
  User: quocphu
  Date: 14/06/2023
  Time: 21:28
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
<a href="/singers">Back</a>
<form id="form-edit-singer" action="/singers?action=edit&id=${singers.id}" method="post">
    <div>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="${singers.name}" />
        <label style="color: red" id="error-name"></label>
    </div>
    <a href="#" onclick="submitForm()">Create</a>
</form>
</body>
<script>
    function submitForm(){
        if (validateFormEditSinger()){
            document.getElementById("form-edit-singer").submit();
        }
    }
    function validateFormEditSinger(){
        const name = document.getElementById("name").value

        let ruselt = true;
        if (!name || name.trim().length <= 0 || name.trim().length >50){
            ruselt = false;
            document.getElementById("error-name").innerHTML = "Tên không được để trống hoặc trên 50 ký tự"
        }
        return ruselt;
    }
</script>
</html>
