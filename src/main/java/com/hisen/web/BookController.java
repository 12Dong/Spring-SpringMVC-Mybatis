package com.hisen.web;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hisen.entity.Book;
import com.hisen.service.BookService;
import java.util.List;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * Created by hisen on 17-4-24.
 */
@Controller
//@RequestMapping("/book")
public class BookController {
//  private Logger logger = LoggerFactory.getLogger(this.getClass());

  @Autowired
  private BookService bookService;

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

  @RequestMapping(value = "/detail/{bookId}", method = RequestMethod.GET)
  private String detail(@PathVariable("bookId") Long bookId, Model model) {
    Book book = bookService.getById(bookId);
    model.addAttribute("book", book);
    return "detail";
  }

  @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  @ResponseBody
  private String add(Book book) {
    Book hasBook = bookService.getById(book.getBookId());
    int i = -2;
    if (hasBook == null) {
      i = bookService.addBook(book);
    }
    return i > 0 ? "success" : "error";
  }

  @RequestMapping(value = "/del/{bookId}", method = RequestMethod.GET)
  @ResponseBody
  private String deleteBookById(@PathVariable("bookId") Long id) {
    int i = bookService.deleteBookById(id);
    return i > 0 ? "success" : "error";
  }
}
