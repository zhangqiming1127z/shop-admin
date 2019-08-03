package com.fh.shop.controller.product;


import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.fh.shop.commons.LogAnnotation;
import com.fh.shop.commons.ServerResponse;
import com.fh.shop.commons.VariableInfo;
import com.fh.shop.commons.datatables.DataTableResult;
import com.fh.shop.model.product.Product;
import com.fh.shop.parameter.ProductCondition;

import com.fh.shop.service.product.IProductService;
import com.fh.shop.vo.ProductVo;
import freemarker.template.TemplateException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.utils.FileUtil;
import org.utils.redis.RedisUtil;
import org.utils.uploadoss.OssUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

@RestController
public class ProductController {
    @Resource
    private IProductService iProductService;

    //分页查询
    @RequestMapping("/queryProduct")
    public DataTableResult queryProduct(ProductCondition productCondition, HttpServletRequest request) {
        DataTableResult dataTableResult = iProductService.queryProduct(productCondition, request);
        return dataTableResult;
    }

    //删除商品
    @RequestMapping("/deletePro")
    public ServerResponse deletePro(Integer id) {

        iProductService.deletePro(id);
        return ServerResponse.success();
    }

    //商品的回显
    @RequestMapping("/getById")
    public ServerResponse getById(Integer id) {
        ProductVo productVo = iProductService.getById(id);
        return ServerResponse.success(productVo);
    }

    //修改商品
    @RequestMapping(value = "/updatePro", method = RequestMethod.POST)
    public ServerResponse updatePro(Product product) {
        String url = product.getNewImgageUrl();
        if (StringUtils.isNotEmpty(url)) {
            OssUtil.deleteFile(product.getImgurl());
            product.setImgurl(url);
        }
        iProductService.updatePro(product);
        return ServerResponse.success();
    }

    //添加商品
    @LogAnnotation("添加方法")
    @RequestMapping("/addProduct")
    public ServerResponse addProduct(Product product) {
        iProductService.addProduct(product);
        return ServerResponse.success();
    }

    //批量删除
    @RequestMapping("/batchDelete")
    public ServerResponse batchDelete(@RequestParam(value = "array[]") String[] array) {
        iProductService.batchDelete(array);
        return ServerResponse.success();
    }


    @RequestMapping("/uploadInput")
    public ServerResponse uploadInput(@RequestParam("photo") MultipartFile photo, HttpServletRequest request) throws IOException {
        String filePath = OssUtil.filePath(photo.getInputStream(), photo.getOriginalFilename());
        return ServerResponse.success(filePath);
    }


    //导出Excel
    @RequestMapping("/exportExcel")
    public void exportExcel(ProductCondition productCondition, HttpServletResponse response) {
        //动态查询导出的数据
        List<Product> productList = iProductService.exportExcel(productCondition);
        //将数据转换Excel中
        XSSFWorkbook xssfWorkbook = iProductService.buildWorkbook(productList);
        //下载Excel
        FileUtil.excelDownload(xssfWorkbook, response);
    }


    //导入Excel
    @RequestMapping("/leadExcel")
    public ServerResponse leadExcel(String path) throws IOException {
        iProductService.leadExcel(path);
        return ServerResponse.success();
    }

    //查询导出条件
    @RequestMapping("/queryCondition")
    public ServerResponse queryCondition(ProductCondition productCondition, HttpServletRequest request) {
        iProductService.queryProduct2(productCondition, request);
        return ServerResponse.success();
    }


    @RequestMapping("/uploadFile")
    public ServerResponse uploadFile(@RequestParam MultipartFile excel) throws IOException {
        String s = FileUtil.copyFile(excel.getInputStream(), excel.getOriginalFilename(), VariableInfo.UPLOAD_PATH);
        return ServerResponse.success(VariableInfo.UPLOAD_PATH + s);
    }


    @RequestMapping("/importExcel")
    public ServerResponse importExcel(String filePath) throws IOException {
        Workbook workbook = new XSSFWorkbook(new FileInputStream(filePath));
        workbook.getSheetAt(0);
        return ServerResponse.success();
    }

    @RequestMapping("/exportPDF")
    public void exportPDF(ProductCondition productCondition, HttpServletResponse response) throws IOException, TemplateException {
        iProductService.findProduct(productCondition, response);
    }


    //导出word
    @RequestMapping("/word")
    public void exportWord(ProductCondition pct, HttpServletRequest request, HttpServletResponse response) throws IOException, TemplateException {
        //查出要导出的数据
        iProductService.findProduct(pct, response, request);
    }


    //子图上传
    @RequestMapping("/uploadInputZ")
    public ServerResponse uploadInputZ(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request) {
        String photoName = file.getOriginalFilename();
        if (!StringUtils.isNoneBlank(photoName)) {
            return ServerResponse.error();
        }
       /* String s = ImgUtil.imgUtil(file, request);*/
        return ServerResponse.success();
    }

    @RequestMapping("/upOrDown")
    public ServerResponse upOrDown(Integer id, Integer upId) {
        iProductService.upOrDown(id, upId);
        return ServerResponse.success();
    }

    @RequestMapping("/delCache")
    public ServerResponse delCache(String str) {
        RedisUtil.delRedisValue(str);
        return ServerResponse.success();
    }


}
