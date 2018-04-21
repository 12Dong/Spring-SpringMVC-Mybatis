package com.hisen.dao;

import com.hisen.entity.ReaderLogin;

import java.util.List;

public interface ReaderLoginDao {
    void insertUser(ReaderLogin readerLogin);

    List<ReaderLogin> selectReaderLogin(ReaderLogin readerLogin);
}
