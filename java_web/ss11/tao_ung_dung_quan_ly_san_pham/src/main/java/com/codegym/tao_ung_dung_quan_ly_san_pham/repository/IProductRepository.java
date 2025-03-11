package com.codegym.tao_ung_dung_quan_ly_san_pham.repository;

import com.codegym.tao_ung_dung_quan_ly_san_pham.model.Product;

import java.util.List;

public interface IProductRepository {
    List<Product> findAll();

    boolean add(Product student);
}
