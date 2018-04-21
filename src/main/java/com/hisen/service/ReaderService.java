package com.hisen.service;

import com.hisen.entity.Reader;

public interface ReaderService {

    void insertReader(Reader reader);

    void addReaderFine(Reader reader);

    Reader findReaderById(long ReaderId);

    void payfine(String ReaderId);

    void orderBook(Reader reader);

    void noticeReaderToGetOrder(String readerId);
}
