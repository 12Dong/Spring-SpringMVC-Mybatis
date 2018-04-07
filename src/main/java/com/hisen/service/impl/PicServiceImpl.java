package com.hisen.service.impl;

import com.hisen.dao.PicDao;
import com.hisen.entity.Pic;
import com.hisen.service.PicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PicServiceImpl implements PicService{

    @Autowired
    private PicDao picDao;
    @Override
    public List<Pic> getPicIds() {
        return picDao.queryAll();

    }
}
