package com.google.retinaldisease;

import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.widget.Button;
import android.widget.CheckBox;

public class Symptoms extends AppCompatActivity {
    SharedPreferences sh;
    CheckBox c1;
    Button b3;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_symptoms);
        c1=findViewById(R.id.checkBox);
        b3=findViewById(R.id.button7);
        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());

    }
}