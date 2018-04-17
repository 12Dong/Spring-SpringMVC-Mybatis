package com.hisen.service.impl;

import com.hisen.dao.ReaderDao;
import com.hisen.service.ReaderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import com.hisen.entity.Reader;

import java.util.List;

@Controller
public class ReaderServiceImpl implements ReaderService{
    @Autowired
    ReaderDao readerDao;

    @Override
    public void insertReader(Reader reader) {
        readerDao.insertReader(reader);
    }

}
