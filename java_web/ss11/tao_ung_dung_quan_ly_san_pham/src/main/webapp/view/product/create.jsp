<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 3/12/2025
  Time: 1:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Form nhập sản phẩm</title>
</head>
<body>
<button><a href="/products">Hiển thị danh sách sản phẩm</a></button>
<h1>Nhập thông tin sản phẩm</h1>
<form action="/products?action=createProduct" method="get">
    <input type = number placeholder="ID sản phẩm" name="id"><br>
    <input type = text placeholder="Tên sản phẩm" name="name"><br>
    <input type = number placeholder="Giá sản phẩm" name="price"><br>
    <input type = text placeholder="Mô tả của sản phẩm" name="description"><br>
    <input type = text placeholder="Nhà sản xuất" name="producer"><br>
    <button>Tạo</button>
</form>
</body>
</html>
