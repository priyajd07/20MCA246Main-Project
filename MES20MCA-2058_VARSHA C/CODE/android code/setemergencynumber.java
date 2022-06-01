package com.example.roaddamageapp;

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

public class setemergencynumber extends AppCompatActivity {

    EditText e1;
    Button b1;
    SharedPreferences sh;
    String number;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_setemergencynumber);
        e1=findViewById(R.id.editTextTextPersonName);
        b1=findViewById(R.id.button7);
        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        e1.setText(sh.getString("enumber",""));
        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                number=e1.getText().toString();


                SharedPreferences.Editor ed = sh.edit();
                ed.putString("enumber", number);
                ed.commit();
                startActivity(new Intent(getApplicationContext(), home.class));

            }
        });

    }
}