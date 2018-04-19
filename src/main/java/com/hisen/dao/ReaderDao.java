package com.hisen.dao;

import com.hisen.entity.Reader;

import java.util.List;

public interface ReaderDao {
    Reader queryById(long readerId);
    List<Reader> queryAll();
    List<Reader> queryBySelective(Reader reader);
    void deleteById(long id);
    void updateById(Reader reader);
    void insertReader(Reader reader);

    void addFineByReaderId(Reader reader);

    void payFineByReaderId(String readerId);

    void orderBook(Reader reader);

    void noticeGetOrder(String readerId);

}
