package com.google.retinaldisease;

import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;
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

public class Doctor_recommendation extends AppCompatActivity implements AdapterView.OnItemSelectedListener {
    SharedPreferences sh;

    Spinner s2;

    ListView l1;
    ArrayList<String>disease,disid,doctor,rating;
    String did;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_doctor_recommendation);

        s2=findViewById(R.id.spinner);

        l1=findViewById(R.id.doct);

        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());



        String url ="http://"+sh.getString("ip","")+":5000/disease";
//        s1.setOnItemSelectedListener(Monitoring_signal.this);
        RequestQueue queue = Volley.newRequestQueue(Doctor_recommendation.this);

        StringRequest stringRequest = new StringRequest(Request.Method.POST, url,new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                // Display the response string.
                Log.d("+++++++++++++++++",response);
                try {

                    JSONArray ar=new JSONArray(response);

                    disease= new ArrayList<>(ar.length());
                    disid= new ArrayList<>(ar.length());

                    for(int i=0;i<ar.length();i++)
                    {
                        JSONObject jo=ar.getJSONObject(i);
                        disease.add(jo.getString("Level"));
                        disid.add(jo.getString("id"));




                    }



                    ArrayAdapter<String> adp2 = new ArrayAdapter<String>(Doctor_recommendation.this,android.R.layout.simple_spinner_item, disease);
                    adp2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
                    s2.setAdapter(adp2);
                    s2.setOnItemSelectedListener(Doctor_recommendation.this);


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

    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {

        did=disid.get(i);



       String url ="http://"+sh.getString("ip","")+":5000/recommend";
        RequestQueue queue = Volley.newRequestQueue(Doctor_recommendation.this);

        StringRequest stringRequest = new StringRequest(Request.Method.POST, url,new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                // Display the response string.
                Log.d("+++++++++++++++++",response);
                try {

                    JSONArray ar=new JSONArray(response);

                    doctor= new ArrayList<>(ar.length());
                    rating= new ArrayList<>(ar.length());

                    for(int i=0;i<ar.length();i++)
                    {
                        JSONObject jo=ar.getJSONObject(i);
                        doctor.add(jo.getString("Fname")+" "+jo.getString("Lname"));
                        rating.add(jo.getString("rate"));



                    }
//
//                    ArrayAdapter<String> ad=new ArrayAdapter<String>(Doctor_recommendation.this,android.R.layout.simple_spinner_item,tip);
//                    l1.setAdapter(ad);

                     l1.setAdapter(new custom2(Doctor_recommendation.this,doctor,rating));

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

                params.put("disid",did);




                return params;
            }
        };
        queue.add(stringRequest);







    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {

    }
}