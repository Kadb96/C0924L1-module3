package com.codegym.tao_ung_dung_quan_ly_san_pham.service;

import com.codegym.tao_ung_dung_quan_ly_san_pham.model.Product;
import com.codegym.tao_ung_dung_quan_ly_san_pham.repository.ProductRepository;

import java.util.List;

public class ProductService implements IProductService {
    private static ProductRepository productRepository = new ProductRepository();

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public boolean add(Product product) {
        return productRepository.add(product);
    }
}
