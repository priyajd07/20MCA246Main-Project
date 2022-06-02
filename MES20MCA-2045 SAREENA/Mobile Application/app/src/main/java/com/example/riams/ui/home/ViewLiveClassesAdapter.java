package com.example.riams.ui.home;


import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;


import com.example.riams.Files.response.liveclassresponse;
import com.example.riams.R;

import java.util.List;

public class ViewLiveClassesAdapter extends RecyclerView.Adapter<ViewLiveClassesAdapter.ViewHolder> {

    Context context;
    List<liveclassresponse> rportedCrimeResponses;
    String url;

    public ViewLiveClassesAdapter( Context context, List<liveclassresponse> rportedCrimeResponses) {
        this.context = context;
        this.rportedCrimeResponses = rportedCrimeResponses;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.rawliveclass,viewGroup,false);
        ViewHolder viewHolder = new ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder viewHolder, int i) {

        viewHolder.department.setText("Department: "+rportedCrimeResponses.get(i).getDepartment());
        viewHolder.course.setText("Course: "+rportedCrimeResponses.get(i).getCourse());
        viewHolder.subject.setText("Subject: "+rportedCrimeResponses.get(i).getSubject());
        viewHolder.googlemeetlink.setText("Video class Link :"+rportedCrimeResponses.get(i).getGooglemeetlink());

        url=rportedCrimeResponses.get(i).getGooglemeetlink();//link from netbeans stored in url

        viewHolder.googlemeetlink.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
               // String url = "https://www.murait.com/";
                if (url.startsWith("https://") || url.startsWith("http://")) {
                    Uri uri = Uri.parse(url); //to load link in nw
                    Intent intent = new Intent(Intent.ACTION_VIEW, uri);//to call link to open
                    context.startActivity(intent);

                }else{
                    Toast.makeText(view.getContext(), "Invalid Url", Toast.LENGTH_SHORT).show();
                }
            }
        });



    }

    @Override
    public int getItemCount() {
        return rportedCrimeResponses.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {



        TextView department,course,subject,googlemeetlink;


        public ViewHolder(@NonNull View itemView) {
            super(itemView);

            department = itemView.findViewById(R.id.txtdepartment);
            course = itemView.findViewById(R.id.txtcourse);
            subject = itemView.findViewById(R.id.txtsubject);
            googlemeetlink=itemView.findViewById(R.id.txtlink);


        }
    }
}
