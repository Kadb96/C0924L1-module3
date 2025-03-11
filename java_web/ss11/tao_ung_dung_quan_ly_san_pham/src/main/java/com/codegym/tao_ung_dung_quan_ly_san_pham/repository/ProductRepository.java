package com.codegym.tao_ung_dung_quan_ly_san_pham.repository;

import com.codegym.tao_ung_dung_quan_ly_san_pham.model.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository {

    private static List<Product> productList = new ArrayList<>();

    static {
        productList.add(new Product(1, "Iphone X", 500, "Iphone 2020", "Apple"));
        productList.add(new Product(2, "Iphone XS", 600, "Iphone 2020", "Apple"));
        productList.add(new Product(3, "Iphone XS Max", 700, "Iphone 2020", "Apple"));
        productList.add(new Product(4, "Iphone 11", 600, "Iphone 2021", "Apple"));
        productList.add(new Product(5, "Iphone 11 Max", 700, "Iphone 2021", "Apple"));
        productList.add(new Product(6, "Iphone 12", 700, "Iphone 2022", "Apple"));
        productList.add(new Product(7, "Iphone 12 Max", 800, "Iphone 2022", "Apple"));
    }

    @Override
    public List<Product> findAll() {
        return productList;
    }

    @Override
    public boolean add(Product product) {
        return productList.add(product);
    }
}
