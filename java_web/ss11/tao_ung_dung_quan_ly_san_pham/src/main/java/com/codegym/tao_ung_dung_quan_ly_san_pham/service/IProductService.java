package com.codegym.tao_ung_dung_quan_ly_san_pham.service;

import com.codegym.tao_ung_dung_quan_ly_san_pham.model.Product;

import java.util.List;

public interface IProductService {
    List<Product> findAll();

    boolean add(Product product);

    boolean delete(int id);

    boolean update(int id, Product product);

    List<Product> search(String name);
}
