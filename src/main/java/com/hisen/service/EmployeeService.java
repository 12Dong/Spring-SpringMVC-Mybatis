package com.hisen.service;

import com.hisen.entity.Manager;

import java.util.List;

public interface EmployeeService {
    public List<Manager> queryAll();
    public List<Manager> queryByName(Manager manager);
    public void insertEmployee(Manager manager);
    public void updateEmployee(Manager manager);
    public void deleteEmployee(long id);

}
