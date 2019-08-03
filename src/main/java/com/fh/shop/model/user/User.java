package com.fh.shop.model.user;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@Data
public class User implements Serializable {
        private Integer id;
        private String userName;
        private String userPassWord;
        private String  realName;
        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date birthday;
        private Integer sex;
        private String salt;
        private Date loginTime;
        private String phone;
        private String mail;
        private String photo;
        private Integer study;
        private Integer nation;
        private String idNumber;
        private Integer province;
        private Integer city;
        private Integer county;
        private String site;
        private String areaName;
}
