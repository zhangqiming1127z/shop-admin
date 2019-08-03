package com.fh.shop.TestMapEach;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
public class Test {
    public static void main(String[] args) {
        Map<String,String> map = new HashMap<>();
        map.put("name","张奇明");
        map.put("sex","男");
        map.put("age","20");
        Iterator<Map.Entry<String, String>> iterator = map.entrySet().iterator();
        StringBuffer sbr = new StringBuffer();
        while (iterator.hasNext()){
            Map.Entry<String, String> next = iterator.next();
            String key = next.getKey();
            String value = next.getValue();
            sbr.append(key).append("=").append(value).append(",");
        }
        System.out.println(sbr.toString());
        test2();
        test3();
        test4();
        test5();
    }
    public static void test2(){
        Map<String,String> map = new HashMap();
        map.put("name","李四");
        map.put("sex","男");
        map.put("age","20");
        Iterator<Map.Entry<String, String>> iterator = map.entrySet().iterator();
        StringBuffer sbr=new StringBuffer();
        while (iterator.hasNext()){
            Map.Entry<String, String> next = iterator.next();
            String key = next.getKey();
            String value = next.getValue();
            sbr.append(key).append("=").append(value).append(",");
        }
        System.out.println(sbr);
    }
    public  static  void test3(){
        Map<String,String>map =new HashMap<>();
        map.put("name","张三");
        map.put("sex","女");
        map.put("age","20");
        Iterator<Map.Entry<String, String>> iterator = map.entrySet().iterator();
        StringBuilder sbr=new StringBuilder();
        while (iterator.hasNext()){
            Map.Entry<String, String> next = iterator.next();
            String key = next.getKey();
            String value = next.getValue();
            sbr.append(key).append("=").append(value).append(",");
        }
        System.out.println(sbr);
    }
    public static void test4(){
        Map<String,String> map =new HashMap<>();
        map.put("name","王五");
        map.put("sex","女");
        map.put("age","10");
        Iterator<Map.Entry<String, String>> iterator = map.entrySet().iterator();
        StringBuilder sbr=new StringBuilder();
        while (iterator.hasNext()){
            Map.Entry<String, String> next = iterator.next();
            String key = next.getKey();
            String value = next.getValue();
            sbr.append(key).append("=").append(value).append(",");
        }
        System.out.println(sbr);
    }
    public static void test5(){
        Map<String,String>map = new HashMap<>();
        map.put("name","小屁孩");
        map.put("sex","男");
        map.put("age","8岁");
        Iterator<Map.Entry<String, String>> iterator = map.entrySet().iterator();
        StringBuffer sbr = new StringBuffer();
        while (iterator.hasNext()){
            Map.Entry<String, String> next = iterator.next();
            String key = next.getKey();
            String value = next.getValue();
            sbr.append(key).append("=").append(value).append(",");
        }
        System.out.println(sbr.toString());
    }


}
