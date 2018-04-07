package com.hisen.web;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hisen.entity.Book;
import com.hisen.entity.Message;
import com.hisen.service.BookService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.apache.ibatis.annotations.ResultMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * Created by hisen on 17-4-24.
 */
@Controller
//@RequestMapping("/book")
public class BookController {
//  private Logger logger = LoggerFactory.getLogger(this.getClass());

  @Autowired
  private BookService bookService;

  //需要倒入Jackson包
  @RequestMapping("/ReturnJson")
  @ResponseBody //自动将结果转为Json字符串
  public Message getBookWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
    PageHelper.startPage(pn,5);
    List<Book> list = bookService.getListWithPic();
    PageInfo page = new PageInfo(list,5);
    return Message.success().add("pageInfo",page);
    //浏览器收到发送的字符串
  }



//  查询书籍目录 分页查询
  @RequestMapping("/Newlist")
  private String list(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model) {
    //引入分页插件
    PageHelper.startPage(pn,5);
    //startPage紧跟的查询 就是分页查询
    List<Book> list = bookService.getListWithPic();
//    使用pageInfo包装查询后结果
    PageInfo page = new PageInfo(list,5);
    //只需将pageInfo交给页面即可
    model.addAttribute("pageInfo", page);
    return "Newlist";// WEB-INF/jsp/"list".jsp
  }
  @RequestMapping("/list")
  private String list(Model model) {
    List<Book> list = bookService.getListWithPic();
    model.addAttribute("list", list);
    return "list";// WEB-INF/jsp/"list".jsp
  }

  @RequestMapping(value="/book",method=RequestMethod.POST)
  @ResponseBody
  public Message saveBook(@Valid Book book, BindingResult result){
      if(result.hasErrors()) {
        Map<String,Object> map = new HashMap<String,Object>();
        List<FieldError> fieldErrors = result.getFieldErrors();
        for (FieldError fieldError : fieldErrors) {
          System.out.println(fieldError.getField());
          System.out.println(fieldError.getDefaultMessage());
          map.put(fieldError.getField(), fieldError.getDefaultMessage());
      }
        return Message.fail().add("errorFields",map);
      }else{
        bookService.addBook(book);
        return Message.success();
      }

  }

//  支持SpringMVC JSP303校验 需要倒入 hibernate-Validator包
  @RequestMapping("/checkBookName")
  @ResponseBody
  public Message checkBookName(@RequestParam("name") String bookName){

    String regx = "^[\\u2E80-\\u9FFF]{2,7}$";
    System.out.println(bookName);
    System.out.println(bookName.matches(regx));
    if(bookName.matches(regx)==false) return Message.fail().add("va_message","用户名应该是是2-5位中文或3-16英文数字");
    boolean flag=bookService.checkBookName(bookName);
    if(flag) return Message.success();
    else return Message.fail().add("va_message","用户名不可用");
  }

//  按照员工课程id查询员工
  @RequestMapping(value = "/book/{id}",method=RequestMethod.GET)
  @ResponseBody
  public Message getBook(@PathVariable("id") Integer id)
  {
    Book book = bookService.getById(id);
    return Message.success().add("book",book);
  }

//  保存员工更新
  @RequestMapping(value="/book/{bookId}",method=RequestMethod.PUT)
  @ResponseBody
  public Message saveBook(Book book){
    System.out.println(book);
    bookService.updateBook(book);
    return Message.success();
  }

  @RequestMapping(value="/book/{id}",method = RequestMethod.DELETE)
  @ResponseBody
  public Message deleteBook(@PathVariable("id") long id){
      bookService.deleteBookById(id);
      return Message.success();
  }
//  @RequestMapping(value = "/detail/{bookId}", method = RequestMethod.GET)
//  private String detail(@PathVariable("bookId") Long bookId, Model model) {
//    Book book = bookService.getById(bookId);
//    model.addAttribute("book", book);
//    return "detail";
//  }
//
//  @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
//  @ResponseBody
//  private String add(Book book) {
//    Book hasBook = bookService.getById(book.getBookId());
//    int i = -2;
//    if (hasBook == null) {
//      i = bookService.addBook(book);
//    }
//    return i > 0 ? "success" : "error";
//  }
//
//  @RequestMapping(value = "/del/{bookId}", method = RequestMethod.GET)
//  @ResponseBody
//  private String deleteBookById(@PathVariable("bookId") Long id) {
//    int i = bookService.deleteBookById(id);
//    return i > 0 ? "success" : "error";
//  }

}
