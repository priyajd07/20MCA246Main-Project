package com.example.riams.Files.rest;


import com.example.riams.Files.response.Regresponse;
import com.example.riams.Files.response.courseresponse;
import com.example.riams.Files.response.deptresponse;
import com.example.riams.Files.response.liveclassresponse;

import java.util.List;

import retrofit.Callback;
import retrofit.http.Field;
import retrofit.http.FormUrlEncoded;
import retrofit.http.GET;
import retrofit.http.POST;

public interface ApiInterface {
    @FormUrlEncoded
    @POST("/register.jsp")

    public void register(@Field("name") String name,
                         @Field("admissionnumber") String admissionnumber,
                         @Field("course") String course,
                         @Field("department") String department,
                         @Field("semester") String semester,
                         @Field("password") String password,
                         Callback<Regresponse> callback);



    @FormUrlEncoded
    @POST("/login.jsp")

    public void login(@Field("admissionnumber") String admissionnumber,
                      @Field("password") String password,
                      Callback<Regresponse> callback);









    @GET("/getdepartment.jsp")

    public void getdepartment(Callback<List<deptresponse>> callback);


    @GET("/getcourse.jsp")

    public void getcourse(Callback<List<courseresponse>> callback);

    @FormUrlEncoded
    @POST("/getliveclasslink.jsp")
    public void liveclass(
            @Field("course") String course,
            @Field("department") String department,

            Callback<List<liveclassresponse>> callback);

}

