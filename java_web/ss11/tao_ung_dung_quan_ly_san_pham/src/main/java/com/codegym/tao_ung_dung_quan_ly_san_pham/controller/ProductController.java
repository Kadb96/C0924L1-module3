package com.codegym.tao_ung_dung_quan_ly_san_pham.controller;

import com.codegym.tao_ung_dung_quan_ly_san_pham.model.Product;
import com.codegym.tao_ung_dung_quan_ly_san_pham.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductController", value = "/products")
public class ProductController extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //lay du lieu action
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "showFormCreate":
                showFormCreate(req, resp);
                break;
            case "createProduct":
                break;
            case "delete":
                break;
            case "update":
                break;
            default:
                showList(req, resp);
        }
    }


    private void showFormCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/product/create.jsp").forward(req, resp);
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> productList = productService.findAll();
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("/view/product/list.jsp").forward(req, resp);
    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int price = Integer.parseInt(req.getParameter("price"));
        String description = req.getParameter("description");
        String producer = req.getParameter("producer");
        productService.add(new Product(id, name, price, producer, description));
    }
}
