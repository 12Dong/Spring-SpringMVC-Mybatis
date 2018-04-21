package com.hisen.dao;

import com.hisen.entity.BookClass;

import java.util.List;

public interface BookClassDao {
    BookClass queryById(long id);
    List<BookClass> queryAll();
    List<BookClass> queryBySelective(BookClass bookClass);
    void updateById(BookClass bookClass);
    void deleteById(long id);
    void insertBookClass(BookClass bookClass);
    void addBookClassNum(String ISBN);
    void minusBookClassNum(String ISBN);
    void deleteByISBN(String ISBN);
}
