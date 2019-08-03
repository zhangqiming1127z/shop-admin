package com.fh.shop.commons;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.springframework.stereotype.Component;

@Component
public class test {
    public static PropertiesConfiguration configuration = null;
    static {
        try {
            String path = test.class.getClassLoader().getResource("config.properties").getPath();
            configuration = new PropertiesConfiguration(path);
            System.out.println(configuration.getString("redis.host"));
        } catch (ConfigurationException e) {
            e.printStackTrace();
        }
    }





}
