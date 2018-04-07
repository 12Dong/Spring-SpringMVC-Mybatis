package com.hisen.Test;

public class testRegx {
    static public void main(String argv[]){
        String regx = "^[\\u4e00-\\u9fa5]*$";
        System.out.println("舰娘大和的本子".matches(regx));
    }
}
