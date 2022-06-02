package com.example.riams.Files.response;

public class Regresponse {
    String name,admnnumber,course,department,semester,password,msg;

    public Regresponse(String name,String admnnumber,String course,String department,String semester,String password,String msg) {
        this.name = name;
        this.admnnumber = admnnumber;
        this.course = course;
        this.department=department;
        this.semester=semester;
        this.password = password;
        this.msg = msg;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAdmnnumber() { return admnnumber; }

    public void setAdmnnumber(String admnnumber) {
        this.admnnumber = admnnumber;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) { this.course = course;   }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) { this.department = department;   }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) { this.semester = semester;   }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
