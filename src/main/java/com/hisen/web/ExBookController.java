package com.hisen.web;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hisen.entity.BookClass;
import com.hisen.entity.ExBook;
import com.hisen.entity.Message;
import com.hisen.service.BookClassService;
import com.hisen.service.ExBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.jms.Session;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class ExBookController {

    @Autowired
    ExBookService exBookService;

    @Autowired
    BookClassService bookClassService;

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

    @RequestMapping(value="/AddBook",method = RequestMethod.POST)
    @ResponseBody
    public Message addBook(@RequestBody Map<String,String> map){
        String ISBN = map.get("ISBN");
        bookClassService.BookClassNumAdd1(ISBN);
        String location = map.get("location");
        ExBook exBook = exBookService.selectLastExBook(ISBN);
        System.out.println(exBook.getBookId());
        String[] newBookIdGroup = exBook.getBookId().split("[.]");
        String newBookIdprefix = newBookIdGroup[0];
        String newBookIdSuffix = String.valueOf(Integer.parseInt(newBookIdGroup[1])+1);
        String bookId = newBookIdprefix+"."+newBookIdSuffix;
        ExBook newExBook = new ExBook();
        newExBook.setISBN(ISBN);
        newExBook.setBookId(bookId);
        newExBook.setLocation(location);
        newExBook.setStatus("未借出");
        exBookService.addNewBook(newExBook);
        return Message.success();
    }


    @RequestMapping(value = "/ExBookManager/{ISBN}")
    public String toBookListManger(@PathVariable("ISBN") String ISBN,Model model){
        model.addAttribute("ISBN",ISBN);
        return "bookListManager";
    }

    @RequestMapping(value = "/ExBookManager",method = RequestMethod.DELETE)
    @ResponseBody
    public Message deleteBook(@RequestBody Map<String,String> map){
        String bookId = map.get("bookId");
        String ISBN = map.get("ISBN");
        if(exBookService.searchNumByISBN(ISBN)!=1){
            exBookService.deleteByBookId(bookId);
            bookClassService.BookClassNumMinus1(ISBN);
            return Message.success().add("bookClass",true);
        }else{
            exBookService.deleteByBookId(bookId);
            bookClassService.deleteBookClassByISBN(ISBN);
            return Message.success().add("bookClass",false);
        }

    }


    @RequestMapping(value="/checkRenderable",method = RequestMethod.POST)
    @ResponseBody
    public Message checkBookNum(HttpSession session){
        String readerId = (String)session.getAttribute("readerId");
        if(exBookService.chechRendable(readerId)){
            return Message.success().add("rendable",true);
        }else{
            return Message.success().add("rendable",false);
        }
    }


}
