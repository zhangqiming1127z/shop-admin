package com.fh.shop.service.product;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.commons.datatables.DataTableResult;
import com.fh.shop.dao.IDao;
import com.fh.shop.model.brand.Brand;
import com.fh.shop.model.product.Product;
import com.fh.shop.parameter.ProductCondition;
import com.fh.shop.vo.Pro;
import com.fh.shop.vo.ProductVo;
import freemarker.template.TemplateException;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.utils.DateUtil;
import org.utils.FileUtil;
import org.utils.WordUtil;
import org.utils.redis.RedisUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

@Service
public class ProductServiceImpl implements IProductService {
    @Autowired
    private IDao iDao;

    public DataTableResult queryProduct(ProductCondition productCondition, HttpServletRequest request) {
        //查询分页总条数
            long count = iDao.queryCount(productCondition);
            //查询所有数据
            List<Product>proList = iDao.queryProductData(productCondition);
            String pro = JSONObject.toJSONString(proList);
            RedisUtil.setRedisValue("productList",pro);
            //装配数据
            List list = createData(proList, productCondition);
            //重构数据
            DataTableResult dataTableResult = new DataTableResult(productCondition.getDraw(),count,list);
        return dataTableResult;
    }

    //删除
    public void deletePro(Integer id) {
        iDao.deletePro(id);
    }
    //回显
    public ProductVo getById(Integer id) {
        Product product = iDao.getById(id);
        ProductVo productVo = buildProductVo(product);
        return productVo;
    }

    private ProductVo buildProductVo(Product product) {
        ProductVo productVo = new ProductVo();
        productVo.setId(product.getId());
        productVo.setProName(product.getProName());
        productVo.setPrice(product.getPrice());
        productVo.setCreateDate(DateUtil.date2String(product.getCreateDate(), DateUtil.Y_M_D));
        productVo.setB(product.getBrand().getId());
        productVo.setTypeName(product.getTypeName());
        productVo.setGc1(product.getGc1());
        productVo.setGc2(product.getGc2());
        productVo.setGc3(product.getGc3());
        productVo.setImgurl(product.getImgurl());
        productVo.setSonimg(product.getSonimg());
        productVo.setIshot(product.getIshot());
        return productVo;
    }

    @Override
    public void updatePro(Product product) {
        iDao.updatePro(product);
    }

    @Override
    public void addProduct(Product product) {

        String[] split = product.getSonimg().split(",");
        String imgs="";
        if (split!=null && !split.equals("")){
            for (int i = 0; i < split.length; i++) {
                String s = split[i];
                imgs+=s+",";
            }
        }
        product.setSonimg(imgs);
        iDao.addProduct(product);
    }


    public void batchDelete(String[] array) {
        iDao.batchDelete(array);
    }

    private List<Pro> buildData(List<Product> proList) {
        List<Pro> newList = new ArrayList();
        for (Product prt : proList) {
            Pro pro = new Pro();
            pro.setProName(prt.getProName());
            pro.setPrice(prt.getPrice());
            pro.setBrandName(prt.getBrand().getBrandName());
            pro.setCreateDate(prt.getCreateDate());
            newList.add(pro);
        }
        return newList;
    }

    @Override
    public void queryProduct2(ProductCondition productCondition, HttpServletRequest request) {
        long count = iDao.queryCount1(productCondition);
        //查询所有数据
        List<Product> proList = iDao.queryProductData(productCondition);
        request.getSession().setAttribute("List", proList);
        request.getSession().setAttribute("count", count);
    }

    @Override
    public void findProduct(ProductCondition productCondition,HttpServletResponse response,HttpServletRequest request) throws IOException, TemplateException {
        List list = iDao.queryProductData1(productCondition);
        Map map = new HashMap();
        map.put("products",list);
        WordUtil.downLoadWord("/template","word.html",map,request,response);
    }


    public void findProduct(ProductCondition productCondition,HttpServletResponse response) throws IOException, TemplateException {
        List list = iDao.queryProductData1(productCondition);
        Map map = new HashMap();
        map.put("companyName","郑州飞狐教育");
        map.put("products",list);
        map.put("createDate", DateUtil.date2String(new Date(),DateUtil.Y_M_D));
    /*    String pdf = PdfUtil.Pdf(map,"utf-8","/template","info.html");*/
    /*    FileUtil.pdfDownloadFile(response,pdf);*/

    }

    @Override
    public List<Product> exportExcel(ProductCondition productCondition) {
        List<Product> productList = iDao.exportExcel(productCondition);
        return productList;
    }
    public XSSFWorkbook buildWorkbook(List<Product> productList) {
        //创建Excel
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook();
        //创建sheet
        XSSFSheet sheet = xssfWorkbook.createSheet("商品列表【"+productList.size()+"】");
        //创建大标题
        buildTitle(sheet , xssfWorkbook);
        //创建表头
        buildHead(sheet);
        //创建表里面的内容
        buildData(productList, sheet , xssfWorkbook);
        return xssfWorkbook;
    }

    @Override
    public void leadExcel(String path) throws IOException {
        //文件路径
        String realPath =path;
        //通过流创建excel文件 , 判断版本【.xls】还是【.xlsx】,endsWith以XXX结尾
        Workbook wb =  buildWorkbook(path, realPath);
        //查询品牌表中的数据
        List<Brand> brandList = iDao.queryBrandList();
        //分段数据提交
        builDataSubmit(wb, brandList);
        //找到文件
        File file = new File(realPath);
       //导入excel文件内容后,删除文件节省资源
        if(file.exists()){
            file.delete();
        }
    }


    public void upOrDown(Integer id, Integer upId) {
        iDao.upOrDown(id,upId);
    }


    private Workbook buildWorkbook(String path, String realPath) throws IOException {
        Workbook wb = null;
        if (path.endsWith("xlsx")){
            //如果以xlsx结尾 , 通过接口编程 , 走XSSF
            wb = new XSSFWorkbook(new FileInputStream(realPath));
        }else{
            //如果以xls结尾 , 走HSSF
            wb = new HSSFWorkbook(new FileInputStream(realPath));
        }
        return wb;
    }
    public int buildBrandId(String brandName,List<Brand> brandList){
        //判断品牌名是否相同 , 如果相同返回品牌id
        for (Brand brand : brandList) {
            if (brand.getBrandName().equals(brandName)){
                return brand.getId();
            }
        }
        //不相同说明该品牌名不存在
        Brand brand = new Brand();
        brand.setBrandName(brandName);
        //通过执行sql语句,selectkey返回自增后的id
        iDao.addBrand(brand);
        //创建完成后将品牌添加到list集合中,下次对比不会创建重复
        brandList.add(brand);
        return brand.getId();
    }
    private Product buildChange(Sheet sheet, int i , List<Brand> brandList) {
        //获取数据起始行
        Row row = sheet.getRow(i);
        //获取列里的数据
        String name = row.getCell(0).getStringCellValue();
        String brandName = row.getCell(1).getStringCellValue();
        double price = row.getCell(2).getNumericCellValue();
        int i1 = buildBrandId(brandName, brandList);
        //创建商品对象
        Product product = new Product();
        product.setProName(name);
        product.setPrice((float) price);
        product.getBrand().setId(i1);

        return product;
    }
    private void builDataSubmit(Workbook wb , List<Brand> brandList) {
        //根据下标获取sheet
        Sheet sheet = wb.getSheetAt(0);
        //获取起始行
        int firstRowNum = sheet.getFirstRowNum();
        //获取结束行
        int lastRowNum = sheet.getLastRowNum();
        //创建商品表集合
        List<Product> productList = new ArrayList();
        //遍历内容行 , 表头是标题所以+1
        for (int i = firstRowNum + 1; i <= lastRowNum; i++) {
            Product product = buildChange(sheet, i, brandList);
            //每循环一次往集合中添加一次
            productList.add(product);
            //判读长度是否为5 , 5条进行一次提交
            if (productList.size() == 5){
                iDao.addProduct2(productList);
                productList = new ArrayList();
            }
        }
        //处理剩余数据
        if (productList.size() > 0){
            iDao.addProduct2(productList);
        }
    }
    private void buildTitle(XSSFSheet sheet , XSSFWorkbook xssfWorkbook) {
        //创建行
        XSSFRow row = sheet.createRow(4);
        //创建列
        XSSFCell cell = row.createCell(6);
        //设置列中的内容
        cell.setCellValue("商品列表");
        //合并单元格
        sheet.addMergedRegion(new CellRangeAddress(4, 6, 6, 9));
        //设置样式
        buildCellStyle(xssfWorkbook, cell);
    }


    private void buildData(List<Product> productList, XSSFSheet sheet , XSSFWorkbook xssfWorkbook) {
        //日期格式的转换
        XSSFCellStyle cellStyle = xssfWorkbook.createCellStyle();
        cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
        for (int i = 0; i < productList.size(); i++) {
            Product product = productList.get(i);
            XSSFRow row = sheet.createRow(i + 8);
            row.createCell(6).setCellValue(product.getProName());
            row.createCell(7).setCellValue(product.getBrand().getBrandName());
            row.createCell(8).setCellValue(product.getPrice());
            XSSFCell cell = row.createCell(9);
            cell.setCellValue(DateUtil.date2String(product.getCreateDate(),DateUtil.Y_M_D));
            cell.setCellStyle(cellStyle);
        }
    }
    private void buildCellStyle(XSSFWorkbook xssfWorkbook, XSSFCell cell) {
        //创建行样式
        XSSFCellStyle cellStyle = xssfWorkbook.createCellStyle();
        //行水平居中
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        //垂直居中
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //设置颜色,前置背景,后置背景
        cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        cellStyle.setFillForegroundColor(HSSFColor.BLUE.index);
        //创建字体样式
        XSSFFont font = xssfWorkbook.createFont();
        //加粗
        font.setBold(true);
        //字体大小
        font.setFontHeightInPoints((short) 20);
        //字体颜色
        font.setColor(Font.COLOR_RED);
        //单元格设置字体样式
        cellStyle.setFont(font);
        //单元格设置样式
        cell.setCellStyle(cellStyle);
    }
    private void buildHead(XSSFSheet sheet) {
        XSSFRow row = sheet.createRow(7);
        String[] str = {"产品名" , "品牌名" , "产品价格" , "生产日期"};
        for (int i = 0; i < str.length; i++) {
            row.createCell(i+6).setCellValue(str[i]);
        }
    }

    private List createData(List<Product> proList, ProductCondition productCondition) {
        List list = new ArrayList();
        for (Product product : proList) {
            Map map = new HashMap();
            map.put("id", product.getId());
            map.put("productName", product.getProName());
            map.put("productPrice", product.getPrice());
            map.put("createDate", DateUtil.date2String(product.getCreateDate(), DateUtil.Y_M_D));
            map.put("bName", product.getBrand().getBrandName());
            map.put("imgurl", product.getImgurl());
            map.put("typeName",product.getTypeName());
            map.put("ishot",product.getIshot());
            map.put("upOrDownOrDelete",product.getUpOrDownOrDelete());
            list.add(map);
        }
        return list;
    }

}

