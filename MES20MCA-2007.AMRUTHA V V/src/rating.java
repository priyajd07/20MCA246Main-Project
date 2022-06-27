package com.google.retinaldisease;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class Rating extends AppCompatActivity {
    SharedPreferences sh;
    EditText t2;
    Button b1;
    String did,review;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rating);
        t2=findViewById(R.id.editTextTextPersonName2);
        b1=findViewById(R.id.button);
        did=getIntent().getStringExtra("did");
        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());


        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                review = t2.getText().toString();


                RequestQueue queue = Volley.newRequestQueue(Rating.this);
                String url = "http://" + sh.getString("ip", "") + ":5000/addreview";

                // Request a string response from the provided URL.
                StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        // Display the response string.
                        try {
                            JSONObject jo = new JSONObject(response);
                            String status = jo.getString("task");
//                                Toast.makeText(Login.this, status, Toast.LENGTH_SHORT).show();

                            if (status.equalsIgnoreCase("success")) {
//                                String lid = jo.getString("id");


                                Toast.makeText(Rating.this, "Review Added", Toast.LENGTH_SHORT).show();

                                Intent in = new Intent(getApplicationContext(), viewdoctor.class);
                                startActivity(in);
//                                    Intent i = new Intent(getApplicationContext(), LocationService.class);
//                                    startService(i);


                            } else {
                                Toast.makeText(Rating.this, "Invalid", Toast.LENGTH_SHORT).show();
                            }
                        } catch (Exception e) {
                            Log.d("=========", e.toString());
                            Toast.makeText(Rating.this, "" + e, Toast.LENGTH_SHORT).show();

                        }

                    }
                }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Toast.makeText(Rating.this, "err" + error, Toast.LENGTH_SHORT).show();
                    }
                }) {
                    @Override
                    protected Map<String, String> getParams() {
                        Map<String, String> params = new HashMap<>();
                        params.put("review", review);
                        params.put("did", did);
                        params.put("lid", sh.getString("lid",""));


                        return params;
                    }
                };
                // Add the request to the RequestQueue.
                queue.add(stringRequest);
            }


        });




    }
}