package com.hisen.test;

import org.junit.jupiter.api.Test;

public class testRegx {
    @Test
    public void main(){
        String[] newBookIdGroup = "C831.1".split("[.]");
        for(String str:newBookIdGroup){
            System.out.println(str);
        }
        String newBookIdprefix = newBookIdGroup[0];
        String newBookIdSuffix = String.valueOf(Integer.parseInt(newBookIdGroup[1])+1);
    }
}
