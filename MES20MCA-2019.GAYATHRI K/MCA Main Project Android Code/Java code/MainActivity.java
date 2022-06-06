package com.example.talkarena;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {
    EditText E1;
    Button B1;
    SharedPreferences jngt;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        E1=findViewById(R.id.editTextTextPersonName);
        B1=findViewById(R.id.LOGIN);
        jngt= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());

        B1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String ip=E1.getText().toString();
                if(ip.equalsIgnoreCase(""))
                {
                    E1.setError("please enter ip");
                }
                else {
                    SharedPreferences.Editor cat = jngt.edit();
                    cat.putString("ip", ip);
                    cat.commit();
                    Intent w = new Intent(getApplicationContext(), login.class);
                    startActivity(w);
                }
            }
        });

    }
}