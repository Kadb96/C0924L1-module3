package com.codegym.ss9;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CalculateDiscount", value = "/calculate-discount")
public class CalculateDiscount extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Nhận dữ liệu từ index
        String description = req.getParameter("description");
        float price = Float.parseFloat(req.getParameter("price"));
        float discount = Float.parseFloat(req.getParameter("discount"));

        //thực hiện tính toán
        float discountAmount =(float) (price * discount * 0.01);
        float discountPrice = price - discountAmount;

        //chuyển request sang jsp khác
        req.setAttribute("discountAmount", discountAmount);
        req.setAttribute("discountPrice", discountPrice);
        req.getRequestDispatcher("/display-discount.jsp").forward(req, resp);
    }
}
