package com.example.talkarena;

import androidx.appcompat.app.AppCompatActivity;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.text.InputType;
import android.util.Log;
import android.util.Patterns;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class signup extends AppCompatActivity {
    EditText E1,E2,E3,E4,E5,E6,E7;
    Button B1;
    SharedPreferences jngt;
    String url;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup);
        E1=findViewById(R.id.editTextTextPersonName2);
        E2=findViewById(R.id.editTextTextPersonName3);
        E3=findViewById(R.id.editTextTextPersonName5);
        E4=findViewById(R.id.editTextTextPersonName6);
        E5=findViewById(R.id.editTextTextPersonName7);
        E6=findViewById(R.id.editTextTextPersonName8);
        E7=findViewById(R.id.editTextTextPassword2);
        B1=findViewById(R.id.button4);
        jngt= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());



        B1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String FNAME=E1.getText().toString();
                String LNAME=E2.getText().toString() ;
                String place=E3.getText().toString();
                String EMAIL=E4.getText().toString();
                String PHNO=E5.getText().toString();
                String UN=E6.getText().toString();
                String PASS=E7.getText().toString();

                if(FNAME.equalsIgnoreCase(""))
                {
                    E1.setError("please enter your  name");
                }
                else if(!FNAME.matches("^[a-zA-Z]*$"))
                {
                    E1.setError("characters allowed");
                }

                else if(LNAME.equalsIgnoreCase(""))
                {
                    E2.setError("plaese enter your LNAME");
                }
                else if(!LNAME.matches("^[a-zA-Z]*$"))
                {
                    E2.setError("characters allowed");
                }
                else if(place.equalsIgnoreCase(""))
                {
                    E3.setError("plaese enter your place");
                }
                else if(EMAIL.equalsIgnoreCase(""))
                {
                    E4.setError("plaese enter your EMAIL ");
                }
                else if(!Patterns.EMAIL_ADDRESS.matcher(EMAIL).matches())
                {
                    E4.setError("Enter Valid EMAIL");
                    E4.requestFocus();
                }


                else if(PHNO.equalsIgnoreCase(""))
                {
                    E5.setError("plaese enter your PHONE NUMBER");
                }
                else if(PHNO.length()!=10)
                {
                    E5.setError("10 nos required");
                    E5.requestFocus();


                }


                else if(UN.equalsIgnoreCase(""))
                {
                    E6.setError("plaese enter your USERNAME");
                }
                else if(PASS.equalsIgnoreCase(""))
                {
                    E6.setError("plaese enter your PASSWORD");
                }
                else if(PASS.length()<6)
                {
                    E7.setError("Minimum 6 nos required");
                    E7.requestFocus();


                }


                else {


                    RequestQueue queue = Volley.newRequestQueue(signup.this);
                    url = "http://" + jngt.getString("ip", "") + ":5000/reg";

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

                                    Toast.makeText(signup.this, "REGISTRATION SUCCESS", Toast.LENGTH_SHORT).show();
                                    Intent ik = new Intent(getApplicationContext(), login.class);
                                    startActivity(ik);

                                } else {

                                    Toast.makeText(signup.this, "REGISTRATION FAILED ", Toast.LENGTH_SHORT).show();

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
                            params.put("fname", FNAME);
                            params.put("lname", LNAME);
                            params.put("place", place);
                            params.put("email", EMAIL);
                            params.put("phone", PHNO);
                            params.put("uname", UN);
                            params.put("password", PASS);


                            return params;
                        }
                    };
                    queue.add(stringRequest);

                }

            }
        });
    }
}