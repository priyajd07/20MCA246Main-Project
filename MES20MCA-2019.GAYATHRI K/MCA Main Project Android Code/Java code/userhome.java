package com.example.talkarena;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.renderscript.Byte4;
import android.view.View;
import android.widget.Button;

public class userhome extends AppCompatActivity {
    Button B2,B3,B4,B6,B7,B8,B9,B10,B11,B12;
    SharedPreferences jngt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_userhome);
        B2=findViewById(R.id.button5);
        B3=findViewById(R.id.button6);
        B4 =findViewById(R.id.button7);
        B7 =findViewById(R.id.button15);
        B8=findViewById(R.id.button);
        B9=findViewById(R.id.button18);
        B10=findViewById(R.id.button19);
        B11=findViewById(R.id.button22);
        B12=findViewById(R.id.button23);
        jngt= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());

        B6=findViewById(R.id.button10);


        B2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent b= new Intent(getApplicationContext(),ADD_COMPLAINTS.class);
                startActivity(b);
            }
        });

        B3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent c= new Intent(getApplicationContext(),Chatbot.class);
                startActivity(c);
            }
        });
        B4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent d= new Intent(getApplicationContext(),COMPLAINTS.class);
                startActivity(d);
            }
        });

        B6.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent f= new Intent(getApplicationContext(),login.class);
                startActivity(f);
            }
        });
        B7.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent G = new Intent(getApplicationContext(), SENDCOMMENTS.class);
                startActivity(G);
            }
        });

        B8.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent b= new Intent(getApplicationContext(),sendfriendrequest.class);
                startActivity(b);
            }
        });

        B9.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent b= new Intent(getApplicationContext(),viewfriendrequest.class);
                startActivity(b);
            }
        });

        B10.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent b= new Intent(getApplicationContext(),viewfriends.class);
                startActivity(b);
            }
        });

        B11.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent b= new Intent(getApplicationContext(),addpost.class);
                startActivity(b);
            }
        });

        B12.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent b= new Intent(getApplicationContext(),viewmypost.class);
                startActivity(b);
            }
        });


    }
}