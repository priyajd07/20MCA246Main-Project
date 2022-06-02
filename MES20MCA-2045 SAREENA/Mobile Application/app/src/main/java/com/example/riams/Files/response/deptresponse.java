package com.example.riams.Files.response;

public class deptresponse {
    String id,department;

    public deptresponse(String id, String department) {
        this.id = id;
        this.department = department;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }


    @Override
    public String toString() {
        return

                department;
    }
}
