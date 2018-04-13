package com.hisen.web;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hisen.entity.BookClass;
import com.hisen.entity.Manager;
import com.hisen.entity.Message;
import com.hisen.service.BookClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class BookClassController {
    @Autowired
    BookClassService bookClassService;

    @RequestMapping(value="/bookClassReader")
    public String gotoBookClassReader(HttpSession session){
        session.setAttribute("readerId","1");
        session.setAttribute("managerId","1");
        return "bookClassReader";
    }

    @RequestMapping(value = "/bookClass" ,method = RequestMethod.GET)
    @ResponseBody //自动将结果转为Json字符串
    public Message queryAll(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        List<BookClass> list = bookClassService.queryAll();
        PageInfo page = new PageInfo(list,5);
        return Message.success().add("pageInfo",page);
        //浏览器收到发送的字符串
    }


    @RequestMapping(value="/bookClassQuery",method = RequestMethod.POST)
    @ResponseBody
    public Message bookClassQuery(@RequestBody Map<String,String> map){
        BookClass bookClass = new BookClass();
        bookClass.setBookName(map.get("bookName"));
        bookClass.setAuthor(map.get("authorName"));
        bookClass.setPublishCompany(map.get("publishCompanyName"));
        System.out.println(map.get("bookName")+"   "+map.get("authorName")+"   "+map.get("publishCompanyName"));
        PageHelper.startPage(1,5);
        List<BookClass> list = bookClassService.querySelective(bookClass);
        System.out.println(list);
        PageInfo page = new PageInfo(list,5);
        return Message.success().add("pageInfo",page);
    }


}
