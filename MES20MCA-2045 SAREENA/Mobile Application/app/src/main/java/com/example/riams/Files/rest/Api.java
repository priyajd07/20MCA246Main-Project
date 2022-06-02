package com.example.riams.Files.rest;
import retrofit.RestAdapter;

public class Api {

    public static ApiInterface getClient(){
        RestAdapter adapter= new RestAdapter.Builder()
                .setEndpoint(CommonURL.baseurl).build();




        ApiInterface api = adapter.create(ApiInterface.class);
        return api;

    }
}

