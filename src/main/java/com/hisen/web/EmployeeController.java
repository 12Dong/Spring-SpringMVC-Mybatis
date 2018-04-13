package com.hisen.web;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hisen.entity.Book;
import com.hisen.entity.Manager;
import com.hisen.entity.Message;
import com.hisen.service.EmployeeService;
import com.hisen.service.impl.EmployeeServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/employeeManager")
    private String list(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model) {
        //引入分页插件
        PageHelper.startPage(pn,5);
        //startPage紧跟的查询 就是分页查询
        List<Manager> list = employeeService.queryAll();
//    使用pageInfo包装查询后结果
        PageInfo page = new PageInfo(list,5);
        System.out.println(page);
        //只需将pageInfo交给页面即可
        model.addAttribute("pageInfo", page);
        return "employeeManager";// WEB-INF/jsp/"employeeManager".jsp
    }

    @RequestMapping(value = "/employeeQuery" ,method = RequestMethod.GET)
    @ResponseBody //自动将结果转为Json字符串
    public Message getEmployeeQueryByName(@RequestParam("name")String name){
        PageHelper.startPage(1,5);
        Manager manager = new Manager();
        manager.setName(name);
        List<Manager> list = employeeService.queryByName(manager);
        PageInfo page = new PageInfo(list,5);
        return Message.success().add("pageInfo",page);
        //浏览器收到发送的字符串
    }

    @RequestMapping(value = "/employee" ,method = RequestMethod.GET)
    @ResponseBody //自动将结果转为Json字符串
    public Message getEmployeeWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        List<Manager> list = employeeService.queryAll();
        PageInfo page = new PageInfo(list,5);
        return Message.success().add("pageInfo",page);
        //浏览器收到发送的字符串
    }

    @RequestMapping(value="/employee",method= RequestMethod.POST)
    @ResponseBody
    public Message saveEmployee(Manager manager,BindingResult result){
        if(result.hasErrors()) {
            Map<String,Object> map = new HashMap<String,Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println(fieldError.getField());
                System.out.println(fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Message.fail().add("errorFields",map);
        }else{
            employeeService.insertEmployee(manager);
            return Message.success();
        }
    }

    //  保存员工更新
    @RequestMapping(value="/employee/{managerId}",method=RequestMethod.PUT)
    @ResponseBody
    public Message updateManager(Manager manager){
        System.out.println(manager);
        employeeService.updateEmployee(manager);
        return Message.success();
    }

    @RequestMapping(value="/employee/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public Message deleteBook(@PathVariable("id") long id){
        try{
            employeeService.deleteEmployee(id);
            return Message.success();
        }catch(Exception e){
            return Message.fail();
        }
    }
}
