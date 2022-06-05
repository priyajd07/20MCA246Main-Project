package com.example.talkarena;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
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

public class viewfriends extends AppCompatActivity {
    ListView l1;
    SharedPreferences sh;
    ArrayList<String> name,photo,rid;
    String url;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_viewfriends);
        l1=findViewById(R.id.lv1);
        //l1.setOnItemClickListener(viewfriends.this);
        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());

        url ="http://"+sh.getString("ip", "") + ":5000/view_friends";
        RequestQueue queue = Volley.newRequestQueue(viewfriends.this);

        StringRequest stringRequest = new StringRequest(Request.Method.POST, url,new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                // Display the response string.
                Log.d("+++++++++++++++++",response);
                try {

                    JSONArray ar=new JSONArray(response);
                    rid= new ArrayList<>();
                    name= new ArrayList<>();

                    photo=new ArrayList<>();

                    for(int i=0;i<ar.length();i++)
                    {
                        JSONObject jo=ar.getJSONObject(i);
                        rid.add(jo.getString("lid"));
                        name.add(jo.getString("fname"));

                        photo.add(jo.getString("image"));


                    }

                    // ArrayAdapter<String> ad=new ArrayAdapter<>(Home.this,android.R.layout.simple_list_item_1,name);
                    //lv.setAdapter(ad);

                    l1.setAdapter(new custom2(viewfriends.this,photo,name));


                } catch (Exception e) {
                    Log.d("=========", e.toString());
                    Toast.makeText(getApplicationContext(),"eee  "+e,Toast.LENGTH_LONG).show();

                }


            }

        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

                Toast.makeText(viewfriends.this, "err"+error, Toast.LENGTH_SHORT).show();
            }
        }) {
            @Override
            protected Map<String, String> getParams() {
                Map<String, String> params = new HashMap<>();
                params.put("uid",sh.getString("lid",""));

                return params;
            }
        };
        queue.add(stringRequest);
    }

//    @Override
//    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
//
//        AlertDialog.Builder ald=new AlertDialog.Builder(viewfriends.this);
//        ald.setTitle("Select Option")
//                .setPositiveButton(" FOLLOW ", new DialogInterface.OnClickListener() {
//
//                    @Override
//                    public void onClick(DialogInterface arg0, int arg1) {
//                        try
//                        {
//                            RequestQueue queue = Volley.newRequestQueue(viewfriends.this);
//                            url = "http://" +sh.getString("ip","")+ ":5000/view_friends";
//
//                            // Request a string response from the provided URL.
//                            StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
//                                @Override
//                                public void onResponse(String response) {
//                                    // Display the response string.
//                                    Log.d("+++++++++++++++++", response);
//                                    try {
//                                        JSONObject json = new JSONObject(response);
//                                        String res = json.getString("task");
//
//                                        if (res.equalsIgnoreCase("success")) {
//                                            Toast.makeText(viewfriends.this, "success", Toast.LENGTH_SHORT).show();
////                                            Toast.makeText(getApplicationContext(),"", Toast.LENGTH_LONG).show();
//                                            Intent ik = new Intent(getApplicationContext(),viewfriends.class);
//                                            startActivity(ik);
//
//                                        } else {
//
//                                            Toast.makeText(viewfriends.this, "Invalid", Toast.LENGTH_SHORT).show();
//
//                                        }
//                                    } catch (JSONException e) {
//                                        e.printStackTrace();
//                                    }
//
//
//                                }
//                            }, new Response.ErrorListener() {
//                                @Override
//                                public void onErrorResponse(VolleyError error) {
//
//
//                                    Toast.makeText(getApplicationContext(), "Error" + error, Toast.LENGTH_LONG).show();
//                                }
//                            }) {
//                                @Override
//                                protected Map<String, String> getParams() {
//                                    Map<String, String> params = new HashMap<String, String>();
//                                    params.put("fromid",sh.getString("lid",""));
//                                    params.put("toid",rid.get(position));
//
//                                    return params;
//                                }
//                            };
//                            queue.add(stringRequest);
//
//
//
//
//                        }
//                        catch(Exception e)
//                        {
//                            Toast.makeText(getApplicationContext(),e+"",Toast.LENGTH_LONG).show();
//                        }
//
//                    }
//                })
//                .setNegativeButton(" cancel ", new DialogInterface.OnClickListener() {
//
//                    @Override
//                    public void onClick(DialogInterface arg0, int arg1) {
//
//
//                    }
//                });
//
//        AlertDialog al=ald.create();
//        al.show();
//
//
//    }
    }
