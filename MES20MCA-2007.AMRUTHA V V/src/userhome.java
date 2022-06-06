package com.google.retinaldisease;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class Userhome extends AppCompatActivity {
    Button B1,B2,B3,B4,B5,b7,b8;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_userhome);
        B1=findViewById(R.id.tips);
        B2=findViewById(R.id.treatment);
        B3=findViewById(R.id.upload);
        B4=findViewById(R.id.sndfdbck);
        B5=findViewById(R.id.lgout);

        b7=findViewById(R.id.view_doctor);
        b8=findViewById(R.id.view_complaint_reply);


        B1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent i=new Intent(getApplicationContext(),viewtip.class);
                startActivity(i);
            }
        });
        B2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i=new Intent(getApplicationContext(),viewtreatment.class);
                startActivity(i);

            }
        });
        B3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i=new Intent(getApplicationContext(),UploadImage.class);
                startActivity(i);

            }
        });
        B4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i=new Intent(getApplicationContext(),sendfeedback.class);
                startActivity(i);

            }
        });
        B5.setOnClickListener(new View.OnClickListener() {
                                  @Override
                                  public void onClick(View v) {
                                      Intent i = new Intent(getApplicationContext(), login.class);
                                      startActivity(i);

                                  }
                              });
       
        b7.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(getApplicationContext(),viewdoctor.class);
                startActivity(i);

            }
        });
        b8.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(getApplicationContext(), view_complaint_reply.class);
                startActivity(i);

            }
        });
    }
}