package com.example.riams.Files;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;
import androidx.databinding.DataBindingUtil;

import com.example.riams.Files.response.Regresponse;
import com.example.riams.Files.rest.Api;
import com.example.riams.Files.rest.SessionManager;
import com.example.riams.MainActivity;
import com.example.riams.R;
import com.example.riams.databinding.ActivityLoginBinding;
import com.example.riams.databinding.ActivityMainBinding;


import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

public class Login extends AppCompatActivity {
    ActivityLoginBinding bind;
    String admnnumber;
    String password;
    SessionManager sessionManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        bind = DataBindingUtil.setContentView(this, R.layout.activity_login);

        sessionManager=new SessionManager(getApplicationContext());



        if (sessionManager.isSignIn()) {

            Intent intent=new Intent(getApplicationContext(),MainActivity.class);
            startActivity(intent);
        }
        bind.login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {


                login();
            }});
            bind.signuplink.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent i=new Intent(getApplicationContext(),Register.class);
                    startActivity(i);


                }

            });




    }

    private void login() {
        // display a progress dialog
        final ProgressDialog progressDialog = new ProgressDialog(Login.this);
        progressDialog.setCancelable(false); // set cancelable to false
        progressDialog.setMessage("Please Wait"); // set message
        progressDialog.show(); // show progress dialog

        admnnumber = bind.admnnumber.getText().toString().trim();
        password = bind.pswd.getText().toString().trim();

        Api.getClient().login(admnnumber, password, new Callback<Regresponse>() {
            @Override
            public void success(Regresponse regresponse, Response response) {

                progressDialog.dismiss();
                if (regresponse.getMsg().equals("LoginSuccessfull")) {

                    sessionManager.createSignInSession(admnnumber,password);

                    Intent i = new Intent(getApplicationContext(), MainActivity.class);
                    startActivity(i);

                } else {
                    Intent i = new Intent(getApplicationContext(), Login.class);
                    startActivity(i);
                }


            }

            @Override
            public void failure(RetrofitError error) {

            }

        });

    }
}