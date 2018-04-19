package com.hisen.web;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hisen.entity.*;
import com.hisen.service.BookClassService;
import com.hisen.service.ExBookService;
import com.hisen.service.ReaderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class BookClassController {
    @Autowired
    BookClassService bookClassService;

    @Autowired
    ExBookService exBookService;


    @Autowired
    ReaderService readerService;

    @RequestMapping(value="/bookClassReader")
    public String gotoBookClassReader(HttpSession session){
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

    @RequestMapping(value="/bookClassManager",method= RequestMethod.GET)
    String toBookClassManage(){
        return "bookClassManager";
    }
    @RequestMapping(value="/checkBookClass")
    @ResponseBody
    public Message checkBookClass(@RequestParam("ISBN")String ISBN){
        System.out.println("Check ISBN exits "+ISBN);
        BookClass bookClass = new BookClass();
        bookClass.setISBN(ISBN);
        List<BookClass> list = bookClassService.querySelective(bookClass);
        if(list.size()==0){
            return Message.success().add("exit",false);
        }else{
            return Message.success().add("exit",true);
        }
    }


    @RequestMapping(value="/ExBookManager",method = RequestMethod.POST)
    @ResponseBody
    public Message updateExBook(@RequestBody Map<String,String> map){
        String bookId = map.get("bookId");
        String location = map.get("location");
        String status  = map.get("status");
        if(status.equals("未借出")){
            Reader reader = exBookService.findOrderReaderByBookID(bookId);
            readerService.noticeReaderToGetOrder(reader.getReaderId());
            exBookService.updateOrderBookByBookId(bookId);
            return Message.success().add("message","成功转移预约");
        }
        else{
            ExBook exBook = new ExBook();
            exBook.setBookId(bookId);
            exBook.setLocation(location);
            exBook.setStatus(status);
            exBookService.modifedBookInfo(exBook);
        }
        return Message.success();

    }

    @RequestMapping(value="/bookClass",method = RequestMethod.POST)
    @ResponseBody
    public Message saveBookClass(@RequestBody Map<String,String> map){
        String ISBN = map.get("ISBN");
        String bookName = map.get("bookName");
        String authorName = map.get("authorName");
        String publishCompanyName = map.get("publishCompanyName");
        String publishDate = map.get("publishDate");
        BookClass bookClass = new BookClass();
        bookClass.setISBN(ISBN);
        bookClass.setBookName(bookName);
        bookClass.setAuthor(authorName);
        bookClass.setPublishCompany(publishCompanyName);
        bookClass.setPublishDate(publishDate);
        bookClass.setBookNum(1);
        System.out.println(authorName);
        bookClassService.addNewBookClass(bookClass);
        String bookId = map.get("bookId");
        bookId +=".1";
        String location = map.get("location");
        ExBook exBook = new ExBook();
        exBook.setBookId(bookId);
        exBook.setISBN(ISBN);
        exBook.setLocation(location);
        exBook.setStatus("未借出");
        exBookService.addNewBook(exBook);
        return Message.success();
    }


    @RequestMapping(value="/checkBookIsRendable",method = RequestMethod.GET)
    @ResponseBody
    public Message check(@RequestParam("ISBN")String ISBN){
        System.out.println("checkabe  "+ISBN);
        if(exBookService.checkBookableByISBN(ISBN)==true){
            return Message.success().add("able",true);
        }else{
            return Message.success().add("able",false).add("ISBN",ISBN);
        }
    }

    @RequestMapping(value="/orderBook",method = RequestMethod.GET)
    @ResponseBody
    public Message orderBook(@RequestParam("ISBN")String ISBN,HttpSession session){
        String readerId = (String ) session.getAttribute("readerId");
        System.out.println("order book"+ISBN);
        Reader reader = new Reader();
        reader.setReaderId(readerId);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        reader.setOrderdate(sdf.format(new Date()));
        reader.setISBN(ISBN);
        readerService.orderBook(reader);
        return Message.success();
    }
}
