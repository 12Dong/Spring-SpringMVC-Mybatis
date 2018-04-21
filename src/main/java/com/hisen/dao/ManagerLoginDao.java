package com.hisen.dao;

import com.hisen.entity.Manager;
import com.hisen.entity.ManagerLogin;

import java.util.List;

public interface ManagerLoginDao {
    List<ManagerLogin> selectManagerLogin(ManagerLogin managerLogin);
}
