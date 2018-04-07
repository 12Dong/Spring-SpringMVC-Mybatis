package com.hisen.dao;

import com.hisen.entity.Pic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PicDao {
    Pic queryById(long id);
    List<Pic> queryAll();
}
