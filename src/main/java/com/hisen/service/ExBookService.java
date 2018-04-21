package com.hisen.service;

import com.hisen.entity.ExBook;
import com.hisen.entity.Reader;
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

    void modifedBookInfo(ExBook exBook);

    boolean chechRendable(String readerId);


    long culcateFine(String bookId);

    void updateOrderBookByBookId(String bookId);


    boolean checkBookableByISBN(String ISBN);

    Reader findOrderReaderByBookID(String bookId);

}
