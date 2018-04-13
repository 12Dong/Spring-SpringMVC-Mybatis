package com.hisen.web;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hisen.entity.ExBook;
import com.hisen.entity.Message;
import com.hisen.service.ExBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ExBookController {

    @Autowired
    ExBookService exBookService;

    @RequestMapping(value="/ExBook/{ISBN}")
    public String toExBook(@PathVariable("ISBN") String ISBN, Model model)
    {
        System.out.println(ISBN);
        model.addAttribute("ISBN",ISBN);
        return "bookListReader";
    }
    @RequestMapping(value="/ExBookQuery/{ISBN}")
    @ResponseBody
    public Message getExBookListByISBN(@PathVariable("ISBN") String ISBN){

        PageHelper.startPage(1,5);
        List<ExBook> list = exBookService.queryAll(ISBN);
        PageInfo page = new PageInfo(list,5);
        return Message.success().add("pageInfo",page);
    }

    @RequestMapping(value="/ExBookQueryable/{ISBN}")
    @ResponseBody
    public Message getExBookListByISBNable(@PathVariable("ISBN") String ISBN){
        System.out.println("Now QueryAvailableBook... ...");
        PageHelper.startPage(1,5);
        List<ExBook> list = exBookService.queryALlable(ISBN);
        PageInfo page = new PageInfo(list,5);
        return Message.success().add("pageInfo",page);
    }

    @RequestMapping(value="/Book/{bookId}",method = RequestMethod.PUT)
    @ResponseBody
    public Message renderBook(@RequestParam("bookId") String bookId, HttpSession session){
        System.out.println(bookId);
        String readerId = (String)session.getAttribute("readerId");
        String managerId = (String) session.getAttribute("managerId");
        exBookService.rendBook(bookId,readerId,managerId);
        return Message.success();
    }

}
