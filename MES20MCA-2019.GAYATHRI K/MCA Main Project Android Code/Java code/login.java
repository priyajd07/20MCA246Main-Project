package com.example.talkarena;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
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

public class login extends AppCompatActivity {
    EditText e1,e2;
    Button b1,b2;
    SharedPreferences jngt;
    String url;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        e1=findViewById(R.id.editTextTextPersonName4);
        e2=findViewById(R.id.editTextTextPassword);
        b1=findViewById(R.id.button2);
        b2=findViewById(R.id.button3);
        jngt= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String USERNAME =e1.getText().toString();
                String PASSWORD =e2.getText().toString();

                if(USERNAME.equalsIgnoreCase(""))
                {
                    e1.setError("please enter username");
                }
                else if(PASSWORD.equalsIgnoreCase(""))
                {
                   e2.setError("plaese enter your password");
                }
                else {
                    RequestQueue queue = Volley.newRequestQueue(login.this);
                    url = "http://" + jngt.getString("ip", "") + ":5000/login";

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

                                    Toast.makeText(login.this, "Invalid username or password", Toast.LENGTH_SHORT).show();


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
                            params.put("uname", USERNAME);
                            params.put("password", PASSWORD);

                            return params;
                        }
                    };
                    queue.add(stringRequest);

                }
            }
        });
        b2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent Q=new Intent(getApplicationContext(),signup.class);
                startActivity(Q);
            }
        });
    }
    public void onBackPressed() {
        // TODO Auto-generated method stub
        AlertDialog.Builder ald = new AlertDialog.Builder(login.this);
        ald.setTitle("Do you want to Exit")
                .setPositiveButton(" YES ", new DialogInterface.OnClickListener() {

                    @Override
                    public void onClick(DialogInterface arg0, int arg1) {
                        Intent in = new Intent(Intent.ACTION_MAIN);
                        in.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        in.addCategory(Intent.CATEGORY_HOME);
                        startActivity(in);
                    }
                })
                .setNegativeButton(" NO ", new DialogInterface.OnClickListener() {

                    @Override
                    public void onClick(DialogInterface arg0, int arg1) {

                    }
                });
        AlertDialog al=ald.create();
        al.show();
    }
}