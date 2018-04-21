package com.hisen.web;

import com.hisen.entity.*;
import com.hisen.service.ManagerService;
import com.hisen.service.ReaderService;
import com.hisen.service.UserService;
import org.apache.ibatis.annotations.ResultMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class loginController {

    @Autowired
    UserService userService;

    @Autowired
    ReaderService readerService;

    @Autowired
    ManagerService managerService;

    @RequestMapping("/login")
    public String toLogin(){
        return "login";
    }

    @RequestMapping(value="/user",method = RequestMethod.PUT)
    @ResponseBody
    public Message registerUser(@RequestBody Map<String,String> map, HttpSession session){
        String userName = map.get("username");
        String password = map.get("password");
        String passwordConfirm = map.get("passwordConfirm");
        if(password.compareTo(passwordConfirm)!=0) return Message.fail();
        String NickName = map.get("userNickName");
        String telephone = map.get("telephone");
        String email = map.get("email");
        ReaderLogin readerLogin = new ReaderLogin();
        readerLogin.setUsername(userName);
        readerLogin.setPassword(password);
        userService.registerUser(readerLogin);
        Reader reader = new Reader();
        reader.setReaderId(readerLogin.getReaderId());
        reader.setName(NickName);
        reader.setTelephone(telephone);
        reader.setEmail(email);
        readerService.insertReader(reader);
        session.setAttribute("readerId",readerLogin.getReaderId());
        session.setAttribute("managerId","1");
        return Message.success();
    }

    @RequestMapping(value="/UserLogin",method = RequestMethod.POST)
    @ResponseBody
    public Message login(@RequestBody Map<String,String> map, HttpSession session){
        String username = map.get("username");
        String password = map.get("password");
        System.out.println(username);
        System.out.println(password);
        ReaderLogin readerLogin = new ReaderLogin();
        readerLogin.setUsername(username);
        readerLogin.setPassword(password);
        List<ReaderLogin> list = userService.login(readerLogin);
        if(list.size()==0) return Message.fail();
        ReaderLogin readerLogin1 =  list.get(0);
        Reader reader = readerService.findReaderById(Integer.parseInt(readerLogin1.getReaderId()));

        session.setAttribute("fine",reader.getFine());
        session.setAttribute("readerId",readerLogin1.getReaderId());
        session.setAttribute("managerId","1");
        if(reader.getReady()==1){
            return Message.success().add("ready",true);
        }
        return Message.success();
    }

    @RequestMapping(value="/ManagerLogin",method = RequestMethod.GET)
    public String managerLogin(){
        return "ManagerLogin";
    }

    @RequestMapping(value="/ManagerLogin",method = RequestMethod.POST)
    @ResponseBody
    public Message ManagerLogin(@RequestBody Map<String,String> map, HttpSession session){
        String username = map.get("username");
        String password = map.get("password");
        System.out.println(username);
        System.out.println(password);
        ManagerLogin managerLogin = new ManagerLogin();
        managerLogin.setUsername(username);
        managerLogin.setPassword(password);
        List<ManagerLogin> list = managerService.ManagerLogin(managerLogin);
        System.out.println(list.size());
        if(list.size()==0) return Message.fail();
        ManagerLogin managerLogin1 =  list.get(0);
        session.setAttribute("readerId",managerLogin1.getManagerId());
        session.setAttribute("managerId","1");
        return Message.success();
    }


}
