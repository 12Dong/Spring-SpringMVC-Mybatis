package com.hisen.service.impl;

import com.hisen.dao.ExBookDao;
import com.hisen.entity.ExBook;
import com.hisen.service.ExBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExBookServiceImpl implements ExBookService{
    @Autowired
    ExBookDao exBookDao;

    @Override
    public List<ExBook> queryAll(String ISBN) {
        return exBookDao.queryAllByISBN(ISBN);
    }

    @Override
    public void rendBook(String bookId, String readerId, String managerId) {
        ExBook exBook = new ExBook();
        exBook.setBookId(bookId);
        exBook.setManagerId(managerId);
        exBook.setReaderId(readerId);
        exBookDao.rendBook(exBook);
    }

    @Override
    public List<ExBook> queryALlable(String ISBN) {
        return exBookDao.queryALLablee(ISBN);
    }


    @Override
    public List<ExBook> queryRendBookByReaderId(String readerId) {
        return exBookDao.queryRendBookByReaderId(readerId);
    }

    @Override
    public void returnBookByBookId(String bookId) {
        exBookDao.returnBookByBookId(bookId);
    }

    @Override
    public ExBook selectLastExBook(String ISBN) {
        return exBookDao.selectLast(ISBN);
    }

    @Override
    public void addNewBook(ExBook exBook) {
        exBookDao.insertExBook(exBook);
    }


    @Override
    public void deleteByBookId(String bookId) {
        exBookDao.deleteByBookId(bookId);
    }

    @Override
    public int searchNumByISBN(String ISBN) {
        return exBookDao.selectByISBN(ISBN).size();
    }
}
