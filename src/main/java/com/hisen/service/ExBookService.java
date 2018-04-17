package com.hisen.service;

import com.hisen.entity.ExBook;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ExBookService {
    List<ExBook> queryAll(String ISBN);

    void rendBook(String bookId,String readerId,String managerId);

    List<ExBook> queryALlable(String ISBN);

    List<ExBook> queryRendBookByReaderId(String readerId);

    void returnBookByBookId(String bookId);

    ExBook selectLastExBook(String ISBN);
    void addNewBook(ExBook exBook);

    void deleteByBookId(String bookId);

    int searchNumByISBN(String ISBN);

}
