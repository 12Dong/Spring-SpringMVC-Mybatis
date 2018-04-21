package com.hisen.service.impl;

import com.hisen.dao.ManagerDao;
import com.hisen.entity.Manager;
import com.hisen.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService{
    @Autowired
    ManagerDao managerDao;

    @Override
    public List<Manager> queryAll() {
        return managerDao.queryAll();
    }

    @Override
    public void insertEmployee(Manager manager) {
        managerDao.insertManager(manager);
    }

    @Override
    public void updateEmployee(Manager manager) {
        managerDao.updateById(manager);
    }

    @Override
    public void deleteEmployee(long id) {
        managerDao.deleteById(id);
    }

    @Override
    public List<Manager> queryByName(Manager manager) {
        return managerDao.queryBySelective(manager);
    }
}
