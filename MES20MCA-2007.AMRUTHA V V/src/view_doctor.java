package com.google.retinaldisease;

import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.ListView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class viewdoctor extends AppCompatActivity {
    SharedPreferences sh;
    ListView l1;
ArrayList<String>Name,Experience,Phone;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_viewdoctor);
        l1=findViewById(R.id.list);
        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        String url ="http://"+sh.getString("ip","")+":5000/viewdoctor";
//        s1.setOnItemSelectedListener(Monitoring_signal.this);
        RequestQueue queue = Volley.newRequestQueue(viewdoctor.this);

        StringRequest stringRequest = new StringRequest(Request.Method.POST, url,new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                // Display the response string.
                Log.d("+++++++++++++++++",response);
                try {

                    JSONArray ar=new JSONArray(response);

                    Name= new ArrayList<>(ar.length());
                    Experience= new ArrayList<>(ar.length());

                    Phone= new ArrayList<>(ar.length());


                    for(int i=0;i<ar.length();i++)
                    {
                        JSONObject jo=ar.getJSONObject(i);
                        Name.add(jo.getString("Fname")+" "+jo.getString("Lname"));
                        Experience.add(jo.getString("Experience"));

                        Phone.add(jo.getString("Phone"));




                    }



                    l1.setAdapter(new custom3(viewdoctor.this,Name,Experience,Phone));

                } catch (JSONException e) {
                    e.printStackTrace();
                }


            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

                Toast.makeText(getApplicationContext(),"Error",Toast.LENGTH_LONG).show();
            }
        }){
            @Override
            protected Map<String, String> getParams() {
                Map<String, String> params = new HashMap<>();




                return params;
            }
        };
        queue.add(stringRequest);



    }
}
