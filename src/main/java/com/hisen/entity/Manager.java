package com.hisen.entity;

import javax.validation.constraints.Pattern;

public class Manager {
    private long managerId;
    @Pattern(regexp = "(^[a-zA-Z]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,7}$)",message="姓名应该是3-16位英文或2-7中文")
    private String name;

    public long getManagerId() {
        return managerId;
    }

    public void setManagerId(long managerId) {
        this.managerId = managerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    @Override
    public String toString() {
        return "Manager{" +
                "managerId=" + managerId +
                ", name='" + name + '\'' +
                '}';
    }
}
