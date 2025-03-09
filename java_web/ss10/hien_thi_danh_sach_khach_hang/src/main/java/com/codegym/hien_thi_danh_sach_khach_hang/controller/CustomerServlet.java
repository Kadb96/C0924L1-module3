package com.codegym.hien_thi_danh_sach_khach_hang.controller;

import com.codegym.hien_thi_danh_sach_khach_hang.model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CustomerServlet", value = "/customers")
public class CustomerServlet extends HttpServlet {
    private static List<Customer> customerList = new ArrayList<>();

    static {
        customerList.add(new Customer("Mai Van Hoan", "1983-08-20", "Ha Noi",
                "java_web/ss10/hien_thi_danh_sach_khach_hang/src/main/resources/profile_picture.jpg"));
        customerList.add(new Customer("Nguyen Van Nam", "1983-08-21", "Bac Giang",
                "java_web/ss10/hien_thi_danh_sach_khach_hang/src/main/resources/profile_picture.jpg"));
        customerList.add(new Customer("Nguyen Thai Hoa", "1983-08-22", "Nam Dinh",
                "java_web/ss10/hien_thi_danh_sach_khach_hang/src/main/resources/profile_picture.jpg"));
        customerList.add(new Customer("Tran Dang Khoa", "1983-08-17", "Ha Tay",
                "java_web/ss10/hien_thi_danh_sach_khach_hang/src/main/resources/profile_picture.jpg"));
        customerList.add(new Customer("Nguyen Dinh Thi", "1983-08-19", "Ha Noi",
                "java_web/ss10/hien_thi_danh_sach_khach_hang/src/main/resources/profile_picture.jpg"));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/customer/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
