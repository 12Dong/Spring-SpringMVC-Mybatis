package com.hisen.dao;

import com.hisen.entity.ExBook;
import com.hisen.entity.Reader;

import java.util.List;

public interface ExBookDao {
    ExBook queryById(String id);
    List<ExBook> queryAll();
    List<ExBook> queryBySelective(ExBook exBook);
    void updateById(ExBook exBook);
    void deleteById(long id);
    void insertExBook(ExBook exBook);
    List<ExBook> queryAllByISBN(String ISBN);
    void rendBook(ExBook exbook);
    List<ExBook> queryALLablee(String ISBN);

    List<ExBook> queryRendBookByReaderId(String readerId);

    void returnBookByBookId(String bookId);

    ExBook selectLast(String ISBN);

    void deleteByBookId(String bookId);

    List<ExBook> selectByISBN(String ISBN);

    void modifiedExBook(ExBook exBook);

    int selectNumofBook(String readerId);

    ExBook returnBookBefore(String ISBN);

    List<ExBook> checkExBookableByISBN(String ISBN);

    Reader findOrderReaderByBookID(String bookId);

    void updateOrderBookByBookId(String bookId);
}
