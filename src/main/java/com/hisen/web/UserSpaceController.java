package com.hisen.web;

import com.github.pagehelper.PageHelper;
import com.hisen.entity.ExBook;
import com.hisen.entity.Message;
import com.hisen.entity.Reader;
import com.hisen.service.ExBookService;
import com.hisen.service.ReaderService;
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

    @Autowired
    ReaderService readerService;



    @RequestMapping(value="/UserSpace")
    public String toUserSpace(HttpSession session){
        //假设 为 用户Id 1
        return "UserSpace";
    }

    @RequestMapping(value = "/readerQueryRendBook",method = RequestMethod.GET)
    @ResponseBody
    public Message readerQueryRendBook(HttpSession session){
        String readerId = (String) session.getAttribute("readerId");
        System.out.println("readerId:  "+readerId);
        List<ExBook> list = exBookService.queryRendBookByReaderId(readerId);
        return Message.success().add("list",list);
    }

    @RequestMapping(value="/readerReturnBook",method = RequestMethod.PUT)
    @ResponseBody
    public Message readerReturn(@RequestParam("bookId")String bookId,HttpSession session){
            System.out.println(bookId);
            long fine = exBookService.culcateFine(bookId);
            System.out.println(session.getAttribute("readerId")+ "fine : " + fine);
            if(fine<=0) return Message.fail().add("reason","罚金为负");
            Reader reader = new Reader();
            reader.setReaderId((String)session.getAttribute("readerId"));
            reader.setFine(fine);
            readerService.addReaderFine(reader);
            reader = exBookService.findOrderReaderByBookID(bookId);
            if(reader!=null){
                readerService.noticeReaderToGetOrder(reader.getReaderId());
            }else{
                exBookService.returnBookByBookId(bookId);
            }
            return Message.success().add("fine",fine);
    }

    @RequestMapping(value="/pay_fine",method = RequestMethod.GET)
    @ResponseBody
    public Message payFine(HttpSession session){
        String readerId = (String) session.getAttribute("readerId");
        readerService.payfine(readerId);
        session.setAttribute("fine",0);
        return Message.success();
    }
}
