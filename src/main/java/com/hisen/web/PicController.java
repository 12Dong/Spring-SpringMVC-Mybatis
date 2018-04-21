package com.hisen.web;

import com.hisen.entity.Message;
import com.hisen.entity.Pic;
import com.hisen.service.PicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

//处理和Pic有关的请求
@Controller
public class PicController {

    @Autowired
    private PicService picService;

//    返回所有部门信息
    @RequestMapping("/Pic")
    @ResponseBody
    public Message getPic(){
        List<Pic> list = picService.getPicIds();
        return Message.success().add("Pic",list);
    }
}
