<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ứng dụng Product Discount Calculator</title>
</head>
<body>
<form action="/calculate-discount" method="post">
    <label for="description">Product Description:</label>
    <br>
    <input id="description" name="description">
    <br>
    <label for="price">List Price:</label>
    <br>
    <input id="price" name="price" type="number">
    <br>
    <label for="discount">Discount Percent:</label>
    <br>
    <input id="discount" name="discount">
    <br>
    <button>Calculate Discount</button>
    <br>

</form>
</body>
</html>