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

import java.util.HashMap;
import java.util.Map;

public class SENDCOMMENTS extends AppCompatActivity {
    EditText E1;
    Button B1;
    SharedPreferences jngt;
    String url,COMMENT;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_s_e_n_d_c_o_m_m_e_n_t_s);
        E1=findViewById(R.id.editTextTextPersonName10);
        B1=findViewById(R.id.button14);
        jngt= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        B1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

               COMMENT=E1.getText().toString();
                if(COMMENT.equalsIgnoreCase(""))
                {
                    E1.setError("please enter your  feedback");
                }
                else {
                    RequestQueue queue = Volley.newRequestQueue(SENDCOMMENTS.this);
                    url = "http://" + jngt.getString("ip", "") + ":5000/sendfeedbacks";

                    // Request a string response from the provided URL.
                    StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                        @Override
                        public void onResponse(String response) {
                            // Display the response string.
                            Log.d("+++++++++++++++++", response);
                            try {
                                JSONObject json = new JSONObject(response);
                                String res = json.getString("task");

                                if (res.equalsIgnoreCase("success")) {

                                    Toast.makeText(SENDCOMMENTS.this, "success", Toast.LENGTH_SHORT).show();

                                    Intent ik = new Intent(getApplicationContext(), userhome.class);
                                    startActivity(ik);

                                } else {

                                    Toast.makeText(SENDCOMMENTS.this, "cant post the comment", Toast.LENGTH_SHORT).show();

                                }
                            } catch (JSONException e) {
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
                            params.put("fbk", COMMENT);
                            params.put("lid", jngt.getString("lid",""));

                            return params;
                        }
                    };
                    queue.add(stringRequest);
                }

            }
        });
    }
}