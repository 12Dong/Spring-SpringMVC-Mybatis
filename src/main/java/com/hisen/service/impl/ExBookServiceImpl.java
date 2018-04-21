package com.hisen.service.impl;

import com.hisen.dao.ExBookDao;
import com.hisen.entity.ExBook;
import com.hisen.entity.Reader;
import com.hisen.service.ExBookService;
import com.hisen.service.ReaderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
        Date date = new Date();
        SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");
        String rendDate = smf.format(date);
        Calendar rDate = Calendar.getInstance();
        rDate.setTime(date);
        rDate.add(Calendar.MONTH,1);
        Date reDate = rDate.getTime();
        String returnDate = smf.format(reDate);
        exBook.setRenddate(rendDate);
        exBook.setReturndate(returnDate);

        exBookDao.rendBook(exBook);
    }

    @Override
    public List<ExBook> queryALlable(String ISBN) {
        return exBookDao.queryALLablee(ISBN);
    }


    @Override
    public List<ExBook> queryRendBookByReaderId(String readerId) {
        System.out.println("queryRendBookByReaderId   " + readerId );
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

    @Override
    public void modifedBookInfo(ExBook exBook) {
        exBookDao.modifiedExBook(exBook);
    }

    @Override
    public boolean chechRendable(String readerId) {
        return exBookDao.selectNumofBook(readerId)<10;
    }

    @Override
    public long culcateFine(String bookId) {
        ExBook exBook = exBookDao.returnBookBefore(bookId);
        SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");
        try{
            Date realreturnDate = new Date();
            Date returnDate = smf.parse(exBook.getReturndate());
            long day = (realreturnDate.getTime()-returnDate.getTime())/(24*60*60*1000);
            if(day<=0) return 0;
            else{
                long fine = day*1;
                return fine;
            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public boolean checkBookableByISBN(String ISBN) {
        if(exBookDao.checkExBookableByISBN(ISBN).size()==0){
            return false;
        }else{
            return true;
        }
    }

    @Override
    public Reader findOrderReaderByBookID(String bookId) {
        return exBookDao.findOrderReaderByBookID(bookId);
    }

    @Override
    public void updateOrderBookByBookId(String bookId) {
        exBookDao.updateOrderBookByBookId(bookId);
    }
}
