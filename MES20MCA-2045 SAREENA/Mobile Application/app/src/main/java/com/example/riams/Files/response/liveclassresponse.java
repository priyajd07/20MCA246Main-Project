package com.example.riams.Files.response;

public class liveclassresponse {
    String id,department,course,sem,subject,googlemeetlink;

    public liveclassresponse(String id, String department, String course, String sem, String subject, String googlemeetlink) {
        this.id = id;
        this.department = department;
        this.course = course;
        this.sem = sem;
        this.subject = subject;
        this.googlemeetlink = googlemeetlink;
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

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getSem() {
        return sem;
    }

    public void setSem(String sem) {
        this.sem = sem;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getGooglemeetlink() {
        return googlemeetlink;
    }

    public void setGooglemeetlink(String googlemeetlink) {
        this.googlemeetlink = googlemeetlink;
    }
}
