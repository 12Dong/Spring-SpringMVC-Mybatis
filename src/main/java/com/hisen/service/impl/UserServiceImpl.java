package com.hisen.service.impl;

import com.hisen.dao.ReaderLoginDao;
import com.hisen.entity.ReaderLogin;
import com.hisen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    ReaderLoginDao readerLoginDao;

    @Override
    public void registerUser(ReaderLogin readerLogin) {
        readerLoginDao.insertUser(readerLogin);
    }

    @Override
    public List<ReaderLogin> login(ReaderLogin readerLogin) {
        return  readerLoginDao.selectReaderLogin(readerLogin);
    }
}
