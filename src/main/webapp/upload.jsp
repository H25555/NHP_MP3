<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Upload Music</title>
</head>
<body>
<h1>Upload Music</h1>
<form action="upload" method="post" enctype="multipart/form-data">
  <label for="name">Music Name:</label>
  <input type="text" id="name" name="name"><br><br>
  <label for="musicFile">Music File:</label>
  <input type="file" id="musicFile" name="filePart"><br><br>
  <input type="submit" value="Upload">
</form>
</body>
</html>