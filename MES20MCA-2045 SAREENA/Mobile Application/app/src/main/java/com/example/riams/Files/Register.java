package com.example.riams.Files;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.databinding.DataBindingUtil;

import com.example.riams.Files.response.Regresponse;
import com.example.riams.Files.response.courseresponse;
import com.example.riams.Files.response.deptresponse;
import com.example.riams.Files.rest.Api;
import com.example.riams.Files.rest.SessionManager;
import com.example.riams.R;
import com.example.riams.databinding.ActivityMain2Binding;


import java.util.List;

import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

public class Register extends AppCompatActivity {
    ActivityMain2Binding bind;
    String name;
    String admissionno;
    deptresponse selecteddepartment;
    courseresponse selectedcourse;
    String selectedsemester;
    String password;
    String sem,selecteddeptid,selectedcourseid,seletedsem;
    SessionManager sessionManager;

    String[] semester1 ={"select your semester"};
    List<deptresponse> departmentresponse;
    List<courseresponse> courseresponse;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        bind = DataBindingUtil.setContentView(this, R.layout.activity_main2);


        sessionManager=new SessionManager(getApplicationContext());
        getdepartment();
        getcourse();
        bind.Signup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {


                reg();


            }
        });



        bind.spinnerdept.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {


                selecteddepartment=departmentresponse.get(position);

                selecteddeptid=selecteddepartment.getId();
                Toast.makeText(getApplicationContext(), "Selected: " + selecteddepartment.toString(), Toast.LENGTH_LONG).show();
            }
            @Override
            public void onNothingSelected(AdapterView <?> parent) {
            }
        });


        bind.spinnercourse.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String tutorialsName = parent.getItemAtPosition(position).toString();

                selectedcourse=courseresponse.get(position);

                selectedcourseid=selectedcourse.getId();
                Toast.makeText(getApplicationContext(),"Selected"+ selectedcourse.toString(), Toast.LENGTH_LONG).show();

                Log.i("Semester","Noofsem="+selectedcourse.getNoofsemester());
                sem = selectedcourse.getNoofsemester();

                if (sem!=null) {

                    Log.i("inside if", "check");
                    semester1 = new String[Integer.parseInt(sem)];
                    //semester1 = new String[Integer.parseInt(sem)];
                    for (int i = 0; i < Integer.parseInt(sem); i++) {

                        semester1[i] = (i + 1) + "";

                    }
                }
semadapter();

            }
            @Override
            public void onNothingSelected(AdapterView <?> parent) {
            }
        });

    }


    private void reg() {


        final ProgressDialog progressDialog = new ProgressDialog(Register.this);
        progressDialog.setCancelable(false);
        progressDialog.setMessage("Please Wait");
        progressDialog.show();


        name = bind.Name.getText().toString().trim();
        admissionno = bind.admn.getText().toString().trim();
        //selecteddepartment = bind.spinnerdept.getText().toString().trim();
        // selectedcourse = bind.spinnercourse.getText().toString().trim();
        // selectedsem =bind.spinnersemester.getText().toString().trim();
        password = bind.password.getText().toString().trim();

        Api.getClient().register(name, admissionno, selectedcourseid, selecteddeptid, selectedsemester, password, new Callback<Regresponse>() {
            @Override
            public void success(Regresponse regresponse, Response response) {

                progressDialog.dismiss();


                if (regresponse.getMsg().equals("RegistrationSuccess")) {

                    sessionManager.createuserInSession(selectedcourseid,selecteddeptid);
                    Intent i = new Intent(getApplicationContext(), Login.class);
                    startActivity(i);

                } else if (regresponse.getMsg().equals("RegistrationFailed")) {
                    Intent i = new Intent(getApplicationContext(), Register.class);
                    startActivity(i);
                }
            }


            @Override
            public void failure(RetrofitError error) {

            }
        });
    }


    private void getdepartment(){
        final ProgressDialog progressDialog = new ProgressDialog(Register.this);
        progressDialog.setCancelable(false);
        progressDialog.setMessage("Please Wait");
        progressDialog.show();

        Log.i("inside progress","progress");

        Api.getClient().getdepartment(new Callback<List<deptresponse>>() {
            @Override
            public void success(List <deptresponse> regresponse, Response response) {

                Log.i("inside progress","progress2");

                progressDialog.dismiss();
                Log.i("inside progress","progress3");
                departmentresponse=regresponse;

             //   Log.i("Response","Length of array=="+departmentresponse.toString());

                setDataInSpinnerDepartment();

             //   Log.i("Response","Department=="+regresponse.);


            }


            @Override
            public void failure(RetrofitError error) {

            }
        });


    }


    public void setDataInSpinnerDepartment(){

        Log.i("inside progress","inside spinner");
        // Creating adapter for spinner
        ArrayAdapter<deptresponse> dataAdapter = new ArrayAdapter<deptresponse>(getApplicationContext(), android.R.layout.simple_spinner_item, departmentresponse);

        // Drop down layout style - list view with radio button
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        Log.i("inside progress","inside spinner2");
        // attaching data adapter to spinner
        bind.spinnerdept.setAdapter(dataAdapter)


        ;

    }
    private void getcourse(){
        final ProgressDialog progressDialog = new ProgressDialog(Register.this);
        progressDialog.setCancelable(false);
        progressDialog.setMessage("Please Wait");
        progressDialog.show();

        Api.getClient().getcourse(new Callback<List<courseresponse>>() {
            @Override
            public void success(List <courseresponse> regresponse, Response response) {

                progressDialog.dismiss();

                courseresponse=regresponse;

                Log.i("Response","Length of array=="+courseresponse.toString());

                setDataInSpinnerCourse();

                //   Log.i("Response","Course=="+regresponse.);


            }


            @Override
            public void failure(RetrofitError error) {

            }
        });


    }


    public void setDataInSpinnerCourse(){
        // Creating adapter for spinner
        ArrayAdapter<courseresponse> dataAdapter = new ArrayAdapter<courseresponse>(getApplicationContext(), android.R.layout.simple_spinner_item, courseresponse);

        // Drop down layout style - list view with radio button
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        // attaching data adapter to spinner
        bind.spinnercourse.setAdapter(dataAdapter)


        ;

    }



    public void semadapter(){


        if (semester1!=null) {

            Log.i("inside semester","semester");
            ArrayAdapter aa = new ArrayAdapter(this, android.R.layout.simple_spinner_item, (semester1));
            aa.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
            //Setting the ArrayAdapter data on the Spinner
            bind.spinnersemester.setAdapter(aa);


            bind.spinnersemester.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                    selectedsemester = semester1[position];

                    Toast.makeText(getApplicationContext(), selectedsemester, Toast.LENGTH_LONG).show();
                }


                @Override
                public void onNothingSelected(AdapterView<?> parent) {

                }
            });


        }

    }

}




