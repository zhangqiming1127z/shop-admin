package com.fh.shop.model.product;

import com.fh.shop.model.brand.Brand;
import com.fh.shop.model.productType.ProductType;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Product implements Serializable {
        private static final long serialVersionUID = -1341925435747509781L;
        private  Integer id;
        private  String proName;
        private  float price;
        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date createDate;
        private Brand brand = new Brand();
        private String imgurl;
        private Integer gc1;
        private Integer gc2;
        private Integer gc3;
        private String typeName;
        private String sonimg;
        private Integer ishot;
        private Integer upOrDownOrDelete;
        private String newImgageUrl;

        public String getNewImgageUrl() {
                return newImgageUrl;
        }

        public void setNewImgageUrl(String newImgageUrl) {
                this.newImgageUrl = newImgageUrl;
        }

        public Integer getId() {
                return id;
        }

        public void setId(Integer id) {
                this.id = id;
        }

        public String getProName() {
                return proName;
        }

        public void setProName(String proName) {
                this.proName = proName;
        }

        public float getPrice() {
                return price;
        }

        public void setPrice(float price) {
                this.price = price;
        }

        public Date getCreateDate() {
                return createDate;
        }

        public void setCreateDate(Date createDate) {
                this.createDate = createDate;
        }

        public Brand getBrand() {
                return brand;
        }

        public void setBrand(Brand brand) {
                this.brand = brand;
        }

        public String getImgurl() {
                return imgurl;
        }

        public void setImgurl(String imgurl) {
                this.imgurl = imgurl;
        }

        public Integer getGc1() {
                return gc1;
        }

        public void setGc1(Integer gc1) {
                this.gc1 = gc1;
        }

        public Integer getGc2() {
                return gc2;
        }

        public void setGc2(Integer gc2) {
                this.gc2 = gc2;
        }

        public Integer getGc3() {
                return gc3;
        }

        public void setGc3(Integer gc3) {
                this.gc3 = gc3;
        }

        public String getTypeName() {
                return typeName;
        }

        public void setTypeName(String typeName) {
                this.typeName = typeName;
        }

        public String getSonimg() {
                return sonimg;
        }

        public void setSonimg(String sonimg) {
                this.sonimg = sonimg;
        }

        public Integer getIshot() {
                return ishot;
        }

        public void setIshot(Integer ishot) {
                this.ishot = ishot;
        }

        public Integer getUpOrDownOrDelete() {
                return upOrDownOrDelete;
        }

        public void setUpOrDownOrDelete(Integer upOrDownOrDelete) {
                this.upOrDownOrDelete = upOrDownOrDelete;
        }
}
