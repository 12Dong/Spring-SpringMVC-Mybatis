package com.hisen.dao;

import com.hisen.entity.ExBook;

import java.util.List;

public interface ExBookDao {
    ExBook queryById(String id);
    List<ExBook> queryAll();
    List<ExBook> queryBySelective(ExBook exBook);
    void updateByI(ExBook exBook);
    void deleteById(long id);
    void insertExBook(ExBook exBook);
    List<ExBook> queryAllByISBN(String ISBN);
    void rendBook(ExBook exbook);
    List<ExBook> queryALLablee(String ISBN);

    List<ExBook> queryRendBookByReaderId(String readerId);

}
