package com.hisen.service;

import com.hisen.entity.BookClass;

import java.util.List;

public interface BookClassService {
    List<BookClass> queryAll();
    List<BookClass> querySelective(BookClass bookClass);
    void addNewBookClass(BookClass bookClass);
    void BookClassNumAdd1(String ISBN);
    void deleteBookClassByISBN(String ISBN);
    void BookClassNumMinus1(String ISBN);

}
