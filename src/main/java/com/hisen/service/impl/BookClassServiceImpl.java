package com.hisen.service.impl;

import com.hisen.dao.BookClassDao;
import com.hisen.entity.BookClass;
import com.hisen.service.BookClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookClassServiceImpl implements BookClassService{
    @Autowired
    BookClassDao bookClassDao;

    @Override
    public List<BookClass> queryAll() {
        System.out.println(bookClassDao.queryAll());
        return bookClassDao.queryAll();
    }

    @Override
    public List<BookClass> querySelective(BookClass bookClass) {
        return bookClassDao.queryBySelective(bookClass);
    }
}
