<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Upload Music</title>
</head>
<body>
<h1>Upload Music</h1>
<form action="NHPmp3/upload" method="post" enctype="multipart/form-data">
  <label for="musicName">Music Name:</label>
  <input type="text" id="musicName" name="musicName"><br><br>
  <label for="musicFile">Music File:</label>
  <input type="file" id="musicFile" name="musicFile"><br><br>
  <input type="submit" value="Upload">
</form>
</body>
</html>