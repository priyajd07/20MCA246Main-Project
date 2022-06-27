package com.google.retinaldisease;


import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import android.annotation.SuppressLint;
import android.media.MediaPlayer;
import android.os.Build;
import android.os.Bundle;

import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Environment;
import android.os.Handler;
import android.os.PowerManager;
import android.os.StrictMode;
import android.preference.PreferenceManager;
import android.os.Bundle;
import android.speech.tts.TextToSpeech;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import android.net.Uri;
import android.os.Bundle;
import android.provider.ContactsContract;

import android.content.ContentResolver;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.Color;

import android.util.Log;
import android.view.Gravity;

import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;

import android.widget.Toast;

public class chatbot extends ListeningActivity implements TextToSpeech.OnInitListener {
    EditText e1;
    Button b2,bc;
    ImageButton b;
    SharedPreferences sp;
    LinearLayout lt;
    Handler hd;
    static String prv="";


    String msg="",ans="",ip="",url="",lid="",url2="",id="",txt;
    //    Context context;
    public static ArrayList<PackageInfo> pkgeList;
    ArrayList<String>msgg,date,from_id,toid,idd;
    ProgressDialog mProgressDialog;
    private PowerManager.WakeLock mWakeLock;
    static final int DIALOG_DOWNLOAD_PROGRESS = 2;
    String mgg="",lan;
    TextToSpeech textToSpeech;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chatbot);
        text="";
        e1 = (EditText) findViewById(R.id.editText1);//message
//        v=(TextView)findViewById(R.id.textView8);//answer
        b2 = (Button) findViewById(R.id.button1);//send
        textToSpeech = new TextToSpeech(this,  this);
        sp = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        lt = (LinearLayout) findViewById(R.id.linear1);


//        s.setOnItemSelectedListener(Chatbot.this);
        hd = new Handler();
        hd.post(r);


        //The following 3 lines are needed in every onCreate method of a ListeningActivit
//        ip = sp.getString("Ip", "");
        id = sp.getString("lid", "");
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
//		txt.setEnabled(false);
        // The following 3 lines are needed in every onCreate method of a ListeningActivity
        context = getApplicationContext(); // Needs to be set
        try {
            VoiceRecognitionListener.getInstance().setListener(this); // Here we set the current listener
        } catch (Exception e) {
            Toast.makeText(context, e.getMessage(), Toast.LENGTH_LONG).show();
        }
        startListening1(); // starts listening

        try {
            if (Build.VERSION.SDK_INT > 9) {
                StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
                StrictMode.setThreadPolicy(policy);
            }
        } catch (Exception e) {
        }
        b2.setOnClickListener(new OnClickListener() {
            @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
            @Override
            public void onClick(View view) {
                msg = e1.getText().toString();
                if (msg.equals("")) {
                    e1.setError("enter message");
                } else {
//                    convertTextToSpeech(msg);
                    final RequestQueue queue = Volley.newRequestQueue(chatbot.this);
                    String url = "http://" + sp.getString("ip", "") + ":5000/insertchatbot";
                    StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                        @Override
                        public void onResponse(String response) {
                            // Display the response string.

                            Log.d("+++++++++++++++++", response);
                            try {
                                JSONObject json = new JSONObject(response);
                                String res = json.getString("task");
                                //pDialog.hide
                                if (res.equals("success")) {
//                                    String fn=json.getString("fn");
//                                    stopListening();
//
//
//
//
//
//
                                    e1.setText("");
//                                    queue.stop();
                                }
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }
                        }
                    }, new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {
                            // pDialog.hide();
//                        Toast.makeText(getApplicationContext(),"Error",Toast.LENGTH_LONG).show();
                        }
                    }) {
                        @Override
                        protected Map<String, String> getParams() {
                            Map<String, String> params = new HashMap<String, String>();
                            params.put("lid", sp.getString("lid", ""));
                            params.put("msg", msg);
                            return params;
                        }
                    };
                    stringRequest.setRetryPolicy(new DefaultRetryPolicy(0, DefaultRetryPolicy.DEFAULT_MAX_RETRIES, DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
                    queue.add(stringRequest);

                }

            }
        });
//        b1.setOnClickListener(new OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                stopListening();
//            }
//        });














    }
    public static String text = "";
    @Override
    public void processVoiceCommands (String...voiceCommands){
        //content.removeAllViews();
        text = voiceCommands[0] + ".";

        e1.setText(text);
        // txt.setTextSize(20);
        e1.setTextColor(Color.BLACK);
        e1.setGravity(Gravity.CENTER);
        //content.addView(txt);
        //  }
        restartListeningService();

    }
    @Override
    public void onBackPressed(){
//        stopListening();
        e1.setText("");
        Intent i=new Intent(getApplicationContext(),Userhome.class);
        startActivity(i);
    }
    //        @Override
//        public void onDestroy() {
//            super.onDestroy();
//            getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
//        }
    public Runnable r=new Runnable() {

        @Override
        public void run() {

            url2="http://"+sp.getString("ip", "")+":5000/response";
            final RequestQueue mqueu=Volley.newRequestQueue(chatbot.this);

            StringRequest string=new StringRequest(Request.Method.POST,url2,
                    new Response.Listener<String>() {
                        public void onResponse(String respo)
                        {



                            try {
                                JSONArray arr = new JSONArray(respo);
                                if(respo.length() > 0){


                                    from_id=new ArrayList<String>();
                                    toid=new ArrayList<String>();
                                    msgg=new ArrayList<String>();
                                    date=new ArrayList<String>();

                                    lt.removeAllViews();
                                    for (int i = 0; i < arr.length(); i++) {
                                        JSONObject c = arr.getJSONObject(i);

                                        from_id.add(c.getString("frmid"));
                                        toid.add(c.getString("toid"));
                                        msgg.add(c.getString("msg"));

                                        TextView tv=new TextView(getApplicationContext());
                                        TextView tv1=new TextView(getApplicationContext());


//                                        if(!c.getString("date").equals(prv))
//                                        {
                                        //Toast.makeText(getApplicationContext(), "result is"+prv, Toast.LENGTH_LONG).show();
//                                            tv1.setText(c.getString("date"));
                                        tv1.setGravity(Gravity.CENTER);
                                        tv1.setTextColor(Color.BLACK);
                                        tv1.setBackgroundColor(Color.YELLOW);
//                                            prv=c.getString("date");
//                                        }

                                        if(from_id.get(i).equalsIgnoreCase(id)){


                                            tv.setTextColor(Color.BLACK);
                                            tv.setText("Me"+": "+msgg.get(i));
                                            tv.setGravity(Gravity.RIGHT);

                                            tv.setBackgroundColor(Color.WHITE);

                                            //tv1.setTextColor(Color.RED);
                                            //tv1.setText(date.get(i)+"");

                                            tv1.setBackgroundColor(Color.WHITE);

                                        }
                                        else{
                                            tv.setTextColor(Color.BLACK);
                                            tv.setGravity(Gravity.LEFT);
                                            tv.setBackgroundColor(Color.LTGRAY);
                                            //tv1.setTextColor(Color.BLACK);
                                            //tv1.setText(date.get(i));
                                            //tv1.setGravity(Gravity.CENTER);
                                            tv1.setBackgroundColor(Color.LTGRAY);
                                            mgg=msgg.get(i);
                                            try {
//                                                String aa[] = mgg.split(".");
//                                                Integer len = aa.length;
//                                                String ext = aa[len - 1];
//                                                if (ext == ".pdf" || ext == ".doc" || ext == ".txt") {

                                                tv.setText("  "+msgg.get(i));


//                                                } else {
//                                                    tv.setText(msgg.get(i));
//                                                }
                                            }
                                            catch (Exception e)
                                            {
                                                Toast.makeText(chatbot.this, e.toString(), Toast.LENGTH_SHORT).show();

                                            }

                                        }
//                                        convertTextToSpeech(mgg);

                                        lt.addView(tv);
                                        lt.addView(tv1);


                                    }

                                }
                            }
                            catch (JSONException e) {
                                // TODO Auto-generated catch block
                                Toast.makeText(getApplicationContext(), "err"+e, Toast.LENGTH_LONG).show();
                                e.printStackTrace();
                            }
                            hd.postDelayed(r, 2000);
                        }
                    }

                    , new Response.ErrorListener() {
                public void  onErrorResponse(VolleyError error)
                {
                    Toast.makeText(getApplicationContext(), "err"+error, Toast.LENGTH_LONG).show();
                }
            })

            {
                protected Map<String,String> getParams() throws AuthFailureError
                {
                    Map<String,String> params=new HashMap<String, String>();
                    params.put("lid", sp.getString("lid",""));
                    return params;
                }
            };
            mqueu.add(string);
        }
    };
    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public void convertTextToSpeech(String text) {
        if (null == text || "".equals(text)) {
            text = "Please give some input.";
        }
//        Toast.makeText(getApplicationContext(), "Errorrrrr", Toast.LENGTH_LONG).show();
        textToSpeech.speak(text, TextToSpeech.QUEUE_FLUSH, null);
    }
    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    public void onInit(int status) {
//        if (status == TextToSpeech.SUCCESS) {
//            int result = textToSpeech.setLanguage(Locale.forLanguageTag("ml_IN"));
//            if (result == TextToSpeech.LANG_MISSING_DATA
//                    || result == TextToSpeech.LANG_NOT_SUPPORTED) {
//                Log.e("error", "This Language is not supported");
//            }
//
//            else {
//                convertTextToSpeech("");
//            }
//        } else {
//            Log.e("error", "Initilization Failed!");
//        }
//
    }
}

