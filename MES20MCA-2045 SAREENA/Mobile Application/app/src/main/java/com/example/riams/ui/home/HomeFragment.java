package com.example.riams.ui.home;

import android.app.ProgressDialog;
import android.hardware.lights.LightState;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.databinding.DataBindingUtil;
import androidx.databinding.ViewDataBinding;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.recyclerview.widget.LinearLayoutManager;

import com.example.riams.Files.response.liveclassresponse;
import com.example.riams.Files.rest.Api;
import com.example.riams.Files.rest.SessionManager;
import com.example.riams.R;
import com.example.riams.databinding.FragmentHomeBinding;

import java.util.HashMap;
import java.util.List;

import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

public class HomeFragment extends Fragment {

    private HomeViewModel homeViewModel;
    private FragmentHomeBinding binding;
    SessionManager session;
    String course,department;
    List<liveclassresponse>listliveclass;
    ViewLiveClassesAdapter viewLiveClassesAdapter;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        homeViewModel = new ViewModelProvider(this).get(HomeViewModel.class);

     // binding = FragmentHomeBinding.inflate(inflater,R.layout.fragment_home,container, false);
        //View root = binding.getRoot();
        binding= DataBindingUtil.inflate(inflater,R.layout.fragment_home,container,false);
        View root = binding.getRoot();
        session=new SessionManager(getContext());
        HashMap<String,String> students= session.getUserDetails();
        course=students.get(SessionManager.KEY_COURSE);
        department=students.get(SessionManager.KEY_DEPARTMENT);

        Log.i("course","course=="+course);
        Log.i("department","department=="+department);

     getliveclass();

//        final TextView textView = binding.textHome;
//        homeViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
//            @Override
//            public void onChanged(@Nullable String s) {
//                textView.setText(s);
//            }
//        });
        return root;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        binding = null;
    }

    private void getliveclass(){
        final ProgressDialog progressDialog=new ProgressDialog(getActivity());
        progressDialog.setCancelable(false);
        progressDialog.setMessage("Please Wait");
        progressDialog.show();
        Log.i("inside","insideapicourse");

        Api.getClient().liveclass(course,department, new Callback<List<liveclassresponse>>() {
            @Override
            public void success(List<liveclassresponse> liveclassresponses, Response response) {
                progressDialog.dismiss();

                listliveclass=liveclassresponses;
               setdatarecyclerView(listliveclass);

                
            }

            @Override
            public void failure(RetrofitError error) {

            }
        });
    }
    
    private void setdatarecyclerView(List<liveclassresponse>listliveclass){

        LinearLayoutManager linearLayoutManager=new LinearLayoutManager(getContext());
        
        binding.recyclerview.setLayoutManager(linearLayoutManager);

        viewLiveClassesAdapter=new ViewLiveClassesAdapter(getContext(),listliveclass);
        binding.recyclerview.setAdapter(viewLiveClassesAdapter);



    }
}