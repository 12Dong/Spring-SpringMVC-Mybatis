package com.hisen.service.impl;

import com.hisen.dao.ManagerLoginDao;
import com.hisen.entity.ManagerLogin;
import com.hisen.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService{
    @Autowired
    ManagerLoginDao managerLoginDao;

    @Override
    public List<ManagerLogin> ManagerLogin(ManagerLogin managerLogin) {
        return managerLoginDao.selectManagerLogin(managerLogin);
    }
}
