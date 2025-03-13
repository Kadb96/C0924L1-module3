<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Form nhập sản phẩm</title>
    <c:import url="/view/layout/library.jsp"/>
</head>
<body>
<c:import url="/view/layout/header.jsp"></c:import>
<h1>Nhập thông tin sản phẩm</h1>
<form action="/products" method="get">
    <input type="hidden" name="action" value="createProduct">
    <input type=number placeholder="ID sản phẩm" name="id"><br>
    <input type=text placeholder="Tên sản phẩm" name="name"><br>
    <input type=number placeholder="Giá sản phẩm" name="price"><br>
    <input type=text placeholder="Mô tả của sản phẩm" name="description"><br>
    <input type=text placeholder="Nhà sản xuất" name="producer"><br>
    <button>Tạo</button>
</form>
</body>
</html>
