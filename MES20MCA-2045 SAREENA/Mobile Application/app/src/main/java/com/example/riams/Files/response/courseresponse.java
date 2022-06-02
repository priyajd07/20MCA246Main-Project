package com.example.riams.Files.response;

public class courseresponse {
    String id,course,department,noofsemester;

    public courseresponse(String id, String course, String department,String noofsemester) {
        this.id = id;
        this.course = course;
        this.department = department;
        this.noofsemester=noofsemester;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getNoofsemester() {
        return noofsemester;
    }

    public void setNoofsemester(String noofsemester) {
        this.noofsemester = noofsemester;
    }

    @Override
    public String toString() {
        return
               course;
    }
}
