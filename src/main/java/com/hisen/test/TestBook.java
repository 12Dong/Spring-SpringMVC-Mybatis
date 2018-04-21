package com.hisen.test;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TestBook {
    public static void main(String argv[]) throws Exception{
        String minus = "2018-4-19";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date minusDate = sdf.parse(minus);
        System.out.println((new Date().getTime()-minusDate.getTime())/(24*60*60*1000));
    }
}
