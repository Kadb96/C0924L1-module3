<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 3/9/2025
  Time: 11:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer List</title>
</head>
<body>
<h1>Danh sach khach hang</h1>
<table>
    <tr>
        <th>Ten</th>
        <th>Ngay sinh</th>
        <th>Dia chi</th>
        <th>Avatar</th>
    </tr>
    <c:forEach items="${customerList}" var="customer">
        <tr>
            <td>${customer.getName}</td>
            <td>${customer.getDateOfBirth}</td>
            <td>${customer.getAddress}</td>
            <td><img src="${customer.getProfilePictureLink}"></td>
        </tr>
    </c:forEach>
    <tr>

    </tr>
</table>
</body>
</html>
