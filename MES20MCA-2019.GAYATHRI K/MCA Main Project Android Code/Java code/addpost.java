package com.example.talkarena;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class addpost extends AppCompatActivity {
    EditText ed;
    Button b1;
    SharedPreferences jngt;
    String url;
    String post,userid;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_addpost);
        ed=findViewById(R.id.editTextTextPersonName9);
        b1=findViewById(R.id.button9);
        jngt= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());

        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                post=ed.getText().toString();
                RequestQueue queue = Volley.newRequestQueue(addpost.this);
                url = "http://" + jngt.getString("ip", "") + ":5000/send_post";
                // Request a string response from the provided URL.
                StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        // Display the response string.
                        Log.d("+++++++++++++++++", response);
                        try {
                            JSONObject json = new JSONObject(response);
                            String res = json.getString("task");
                            if (res.equalsIgnoreCase("invalid")) {
                            } else if((res.equals("valid"))) {
                                Toast.makeText(getApplicationContext(), "successfully posted", Toast.LENGTH_LONG).show();
                                Intent ik = new Intent(getApplicationContext(), userhome.class);
                                startActivity(ik);


                            }

                        } catch (JSONException e) {
                            //Toast.makeText(getApplicationContext(), "invalid username or password", Toast.LENGTH_LONG).show();

                            e.printStackTrace();
                        }
                    }
                }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Toast.makeText(getApplicationContext(), "Error" + error, Toast.LENGTH_LONG).show();
                    }
                }) {
                    @Override
                    protected Map<String, String> getParams() {
                        Map<String, String> params = new HashMap<String, String>();
                        params.put("post", post);
                        params.put("userid", jngt.getString("lid",""));
                        return params;
                    }
                };
                queue.add(stringRequest);
            }
        });
    }
}