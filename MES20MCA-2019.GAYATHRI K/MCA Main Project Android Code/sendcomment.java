package com.example.talkarena;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
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

import java.util.HashMap;
import java.util.Map;

public class sendcomment extends AppCompatActivity {
    EditText ed;
    Button b1;
    SharedPreferences jngt;
    String url;
    String comment,userid;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sendcomment);
        ed=findViewById(R.id.editTextTextPersonName9);
        b1=findViewById(R.id.button9);
        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                RequestQueue queue = Volley.newRequestQueue(sendcomment.this);
                url = "http://" + jngt.getString("ip", "") + ":5000/send_comments_to_others";

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

                                Toast.makeText(sendcomment.this, "Invalid username or password", Toast.LENGTH_SHORT).show();


                            } else if((res.equals("valid"))) {
                                String id = json.getString("id");
                                Intent ik = new Intent(getApplicationContext(), userhome.class);
                                startActivity(ik);
                                SharedPreferences.Editor cat = jngt.edit();
                                cat.putString("lid", id);
                                cat.commit();

                            }

                        } catch (JSONException e) {
                            Toast.makeText(getApplicationContext(), "invalid username or password", Toast.LENGTH_LONG).show();

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
                        params.put("comment", comment);
                        params.put("userid", userid);

                        return params;
                    }
                };
                queue.add(stringRequest);
            }
        });
    }
}