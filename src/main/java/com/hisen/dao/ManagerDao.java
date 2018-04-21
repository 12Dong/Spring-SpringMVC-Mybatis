package com.hisen.dao;

import com.hisen.entity.Manager;

import java.util.List;

public interface ManagerDao {
    Manager queryById(long id);
    List<Manager> queryAll();
    List<Manager> queryBySelective(Manager manager);
    void updateById(Manager manager);
    void insertManager(Manager manager);
    void deleteById(long id);

}
