<%--
  Created by IntelliJ IDEA.
  User: quocphu
  Date: 14/06/2023
  Time: 20:15
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
<a href="/categorys">Back</a>
<form id="form-edit-category" action="/categorys?action=edit&id=${category.id}" method="post">
    <div>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="${category.name}" />
        <label style="color: red" id="error_name"></label>
    </div>
    <a href="#" onclick="submitForm()">Edit</a>
</form>
</body>
<script>
    function submitForm(){
        if (validateFromEditCategory()) {
            document.getElementById("form-edit-category").submit()
        }
    }
    function validateFromEditCategory() {
        const name = document.getElementById("name").value;
        let result = true;
        if (!name || name.trim().length <= 0 || name.trim().length >50 ) {
            result = false;
            document.getElementById("error_name").innerHTML = "Tên không được để trống ";
        }
        return result;
    }
</script>
</html>
