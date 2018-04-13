package com.hisen.service;

import com.hisen.entity.BookClass;

import java.util.List;

public interface BookClassService {
    List<BookClass> queryAll();
    List<BookClass> querySelective(BookClass bookClass);
}
