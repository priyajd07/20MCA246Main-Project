package com.example.talkarena;

import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.widget.ListView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class viewmypost extends AppCompatActivity {
    ListView l1;
    SharedPreferences sh;
    ArrayList<String> post,date;
    String url;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_viewmypost);
        l1=findViewById(R.id.lsv);
        //l1.setOnItemClickListener(viewfriendrequest.this);
        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());

        url ="http://"+sh.getString("ip", "") + ":5000/view_my_post";
        RequestQueue queue = Volley.newRequestQueue(viewmypost.this);

        StringRequest stringRequest = new StringRequest(Request.Method.POST, url,new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                // Display the response string.
                Log.d("+++++++++++++++++",response);
                try {

                    JSONArray ar=new JSONArray(response);
                    post= new ArrayList<>();
                    date= new ArrayList<>();


                    for(int i=0;i<ar.length();i++)
                    {
                        JSONObject jo=ar.getJSONObject(i);
                        post.add(jo.getString("Post"));
                        date.add(jo.getString("Date"));




                    }

                    // ArrayAdapter<String> ad=new ArrayAdapter<>(Home.this,android.R.layout.simple_list_item_1,name);
                    //lv.setAdapter(ad);

                    l1.setAdapter(new custom22(viewmypost.this,post,date));


                } catch (Exception e) {
                    Log.d("=========", e.toString());
                }


            }

        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

                Toast.makeText(viewmypost.this, "err"+error, Toast.LENGTH_SHORT).show();
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
//        AlertDialog.Builder ald=new AlertDialog.Builder(viewfriendrequest.this);
//        ald.setTitle("Select Option")
//                .setPositiveButton(" FOLLOW ", new DialogInterface.OnClickListener() {
//
//                    @Override
//                    public void onClick(DialogInterface arg0, int arg1) {
//                        try
//                        {
//                            RequestQueue queue = Volley.newRequestQueue(viewfriendrequest.this);
//                            url = "http://" +sh.getString("ip","")+ ":5000/send_friendrequest2";
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
//                                            Toast.makeText(viewfriendrequest.this, "success", Toast.LENGTH_SHORT).show();
////                                            Toast.makeText(getApplicationContext(),"", Toast.LENGTH_LONG).show();
//                                            Intent ik = new Intent(getApplicationContext(),viewfriendrequest.class);
//                                            startActivity(ik);
//
//                                        } else {
//
//                                            Toast.makeText(viewfriendrequest.this, "Invalid", Toast.LENGTH_SHORT).show();
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
//                            Toast.makeText(getApplicationContext(),e+"", Toast.LENGTH_LONG).show();
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
