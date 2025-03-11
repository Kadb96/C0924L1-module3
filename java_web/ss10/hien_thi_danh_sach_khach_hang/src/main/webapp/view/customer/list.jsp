<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Customer List</title>
</head>
<body>
<h1>Danh sach khach hang</h1>
<table>
    <tr>
        <th>STT</th>
        <th>Ten</th>
        <th>Ngay sinh</th>
        <th>Dia chi</th>
        <th>Avatar</th>
    </tr>
    <c:forEach items="${customerList}" var="customer" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${customer.getName()}</td>
            <td>${customer.getDateOfBirth()}</td>
            <td>${customer.getAddress()}</td>
            <td><img src="/profile_picture.jpg"></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
