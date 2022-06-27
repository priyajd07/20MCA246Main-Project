package com.google.retinaldisease;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {
    EditText e1;
    Button b1;
    SharedPreferences sh;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        e1=findViewById(R.id.ent);
        b1=findViewById(R.id.button5);
        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());

        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String ip=e1.getText().toString();
                if(ip.equals(""))
                {
                    e1.setError("enter ip");
                }
                else {
                    SharedPreferences.Editor ed = sh.edit();
                    ed.putString("ip", ip);
                    ed.commit();


                    Intent i = new Intent(getApplicationContext(), login.class);
                    startActivity(i);
                }

            }
        });
    }

}