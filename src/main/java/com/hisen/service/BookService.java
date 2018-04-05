package com.hisen.service;

import com.hisen.entity.Book;
import java.util.List;

/**
 * Created by hisen on 17-4-24.
 */
public interface BookService {
  Book getById(long bookId);
  Book getByIdWithPic(long bookId);

  List<Book> getList(int start, int pageNum);
  List<Book> getListWithPic(int start, int pageNum);
  int addBook(Book book);
  int updateBook(Book book);
  int deleteBookById(long id);
}
