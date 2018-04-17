package com.hisen.web;

import com.github.pagehelper.PageHelper;
import com.hisen.entity.ExBook;
import com.hisen.entity.Message;
import com.hisen.service.ExBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserSpaceController {

    @Autowired
    ExBookService exBookService;

    @RequestMapping(value="/UserSpace")
    public String toUserSpace(HttpSession session){
        //假设 为 用户Id 1
        session.setAttribute("readerId",1);
        return "UserSpace";
    }

    @RequestMapping(value = "/readerQueryRendBook",method = RequestMethod.GET)
    @ResponseBody
    public Message readerQueryRendBook(@RequestParam("readerId")String readerId){
        System.out.println("readerId:  "+readerId);
        List<ExBook> list = exBookService.queryRendBookByReaderId(readerId);
        return Message.success().add("list",list);
    }

    @RequestMapping(value="/readerReturnBook",method = RequestMethod.PUT)
    @ResponseBody
    public Message readerReturn(@RequestParam("bookId")String bookId){
            System.out.println(bookId);
            exBookService.returnBookByBookId(bookId);
            return Message.success();
    }
}
