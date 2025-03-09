package com.codegym.hien_thi_danh_sach_khach_hang;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            request.getRequestDispatcher("/view/homepage.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}