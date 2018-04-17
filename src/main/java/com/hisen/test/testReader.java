package com.hisen.test;

import com.hisen.dao.*;
import com.hisen.entity.*;
import javafx.application.Application;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Date;
import java.util.List;

public class testReader {
    @Test
    public void testReader(){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring/spring-dao.xml","spring/spring-service.xml");
        ReaderDao readerDao = (ReaderDao) context.getBean("readerDao");
        Reader reader = new Reader();
//        reader.setReaderId(1);
        reader.setName("李四");
        reader.setTelephone("111111111111");
        readerDao.updateById(reader);

    }
    @Test
    public void testBookClass(){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring/spring-dao.xml","spring/spring-service.xml");
        BookClassDao bookClassDao = (BookClassDao)context.getBean("bookClassDao");
        BookClass bookClass = new BookClass();
        bookClass.setAuthor("BX");
        bookClass.setBookName("Fate");
        bookClass.setPublishCompany("Type");
        List<BookClass> list = bookClassDao.queryBySelective(bookClass);
        System.out.println(list);
        }

    @Test
    void testExBook(){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring/spring-dao.xml","spring/spring-service.xml");
        ExBookDao exBookDao = (ExBookDao)context.getBean("exBookDao");
        ExBook exBook = new ExBook();
        exBook.setBookId("C831.1");
        exBook.setLocation("1楼11排111层");
        exBookDao.insertExBook(exBook);
    }
    @Test
    void testManager(){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring/spring-dao.xml","spring/spring-service.xml");
        ManagerDao managerDao = (ManagerDao) context.getBean("managerDao");
        System.out.println(managerDao.queryAll());
    }
    @Test
    void testReaderr(){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring/spring-dao.xml","spring/spring-service.xml");
        ReaderDao readerDao=(ReaderDao)context.getBean("readerDao");
        Reader reader = new Reader();
        reader.setName("贞德·达克尔");
        reader.setTelephone("12345678901");
        reader.setEmail("77777@qq.com");
        readerDao.insertReader(reader);
    }

    @Test
    void testReaderLogin(){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring/spring-dao.xml","spring/spring-service.xml");
        ReaderLoginDao readerLoginDao = (ReaderLoginDao)context.getBean("readerLoginDao");
        ReaderLogin readerLogin = new ReaderLogin();
        readerLogin.setUsername("lisixiaotianshi");
        readerLogin.setPassword("wojiushilisi");
        readerLoginDao.insertUser(readerLogin);
    }
}
