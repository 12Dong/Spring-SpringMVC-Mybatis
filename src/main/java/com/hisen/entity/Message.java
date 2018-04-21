package com.hisen.entity;

import java.util.HashMap;
import java.util.Map;

//用来返回Json数据
public class Message {
    private int code;//状态码
    //100 - 成功 200 - 失败
    private String message;
    //提示信息

//    用户返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String,Object>();

    public static Message success(){
        Message message = new Message();
        message.setCode(100);
        message.setMessage("处理成功");
        return message;
    }

    public static Message fail(){
        Message message = new Message();
        message.setCode(200);
        message.setMessage("处理失败");
        return message;
    }


    public Message add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
