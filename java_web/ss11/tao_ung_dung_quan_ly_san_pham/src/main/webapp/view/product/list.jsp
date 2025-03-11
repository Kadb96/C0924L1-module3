<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 3/12/2025
  Time: 12:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sach san pham</title>
</head>
<body>
<button>
    <a href="/home">Home</a>
</button>
<table>
    <tr>
        <th>STT</th>
        <th>ID</th>
        <th>Ten san pham</th>
        <th>Gia san pham</th>
        <th>Mo ta cua san pham</th>
        <th>Nha san xuat</th>
    </tr>
    <c:forEach items="${productList}" var="product" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${product.getId()}</td>
            <td>${product.getName()}</td>
            <td>${product.getPrice()}</td>
            <td>${product.getDescription()}</td>
            <td>${product.getProducer()}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
