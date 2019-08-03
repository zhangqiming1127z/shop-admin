package com.fh.shop.service.product;

import com.fh.shop.commons.datatables.DataTableResult;
import com.fh.shop.model.product.Product;
import com.fh.shop.parameter.ProductCondition;
import com.fh.shop.vo.Pro;
import com.fh.shop.vo.ProductVo;
import freemarker.template.TemplateException;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface IProductService {
    DataTableResult queryProduct(ProductCondition productCondition, HttpServletRequest request);

    void deletePro(Integer id);

    ProductVo  getById(Integer id);

    void updatePro(Product product);

    void addProduct(Product product);

    void batchDelete(String[] arr);

    void queryProduct2(ProductCondition productCondition, HttpServletRequest request);

   void findProduct(ProductCondition productCondition, HttpServletResponse response, HttpServletRequest request) throws IOException, TemplateException;

    void findProduct(ProductCondition productCondition, HttpServletResponse response) throws IOException, TemplateException;

    List<Product> exportExcel(ProductCondition productCondition);

    XSSFWorkbook buildWorkbook(List<Product> productList);

    void leadExcel(String path) throws IOException;


    void upOrDown(Integer id, Integer upId);
}
