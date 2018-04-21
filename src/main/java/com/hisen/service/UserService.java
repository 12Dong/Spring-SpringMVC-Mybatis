package com.hisen.service;

import com.hisen.entity.ReaderLogin;

import java.util.List;

public interface UserService {
    void registerUser(ReaderLogin readerLogin);
    List<ReaderLogin> login(ReaderLogin readerLogin);

}
