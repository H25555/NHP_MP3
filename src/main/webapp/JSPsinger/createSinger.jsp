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
<c:if test="${requestScope['message'] != null}">
    <span>${message}</span>
</c:if>
<a  href="/singers">Back</a>
<form id="form-create-singer" action="/singers?action=create" method="post">
    <div>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="${singer.name}" />
        <label id="error-name"></label>
    </div>

    <a href="#" onclick="submitForm()">Create</a>
</form>
</body>
<script>

    function submitForm(){
        if (validateFormCreateSinger()){
            console.log(1231)
            document.getElementById("form-create-singer").submit();
        }
    }
    function validateFormCreateSinger(){
        const name = document.getElementById("name").value;

        let result = true;
        if (!name || name.trim().length <= 0 ){
            result = false;
            document.getElementById("error-name").innerHTML = "Tên không được để trống hoặc quá 50 ký tự"
        }
        return result;
    }
</script>
</html>
