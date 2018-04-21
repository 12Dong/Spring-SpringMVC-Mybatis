package com.hisen.service;

import com.hisen.entity.Book;
import com.hisen.entity.Message;

import java.util.List;

/**
 * Created by hisen on 17-4-24.
 */
public interface BookService {
  Book getById(long bookId);
  Book getByIdWithPic(long bookId);

  List<Book> getList(int start, int pageNum);
  List<Book> getListWithPic();
  int addBook(Book book);

  boolean checkBookName(String bookName);

    int updateBook(Book book);
  int deleteBookById(long id);
}
