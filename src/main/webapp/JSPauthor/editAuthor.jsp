<%--
  Created by IntelliJ IDEA.
  User: quocphu
  Date: 14/06/2023
  Time: 16:56
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
<form id="from-edit-author" action="/authors?action=edit&id=${authors.id}" method="post">
    <div>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="${authors.name}" />
        <label style="color: red" id="error_name"></label>
    </div>
  <a href="#" onclick="submitFrom()">Create</a>
</form>
<script>
    function submitFrom(){
        if (validateFromEditAuthor()){
            document.getElementById("from-edit-author").submit()
        }
    }
    function validateFromEditAuthor(){
        const name = document.getElementById("name").value;

        let result = true;
        if (!name || name.trim().length === 0 ){
            result = false;
            document.getElementById("error_name").innerHTML = "Tên không được để trống hoặc quá 50 ký tự"
        }
        return result;
    }
</script>
</body>
</html>
