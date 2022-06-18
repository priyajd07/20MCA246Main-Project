package com.example.onlineexam;

import androidx.appcompat.app.AppCompatActivity;

import android.content.ContentValues;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.os.StrictMode;
import android.preference.PreferenceManager;
import android.provider.MediaStore;
import android.speech.tts.TextToSpeech;
import android.util.Log;
import android.widget.Toast;

import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;
import java.util.prefs.PreferenceChangeEvent;

public class Camera extends AppCompatActivity  implements TextToSpeech.OnInitListener {

    public static String imageurl="";
    File f=null;
    private Uri mImageCaptureUri;
    public static Bitmap imag =null;
    private File outPutFile = null;

    SharedPreferences sh;
    String path,fileName;
    byte[] byteArray = null;
    Uri imageUri=null;
    private static final int CAMERA_PIC_REQUEST = 0;
    String url="";
    TextToSpeech textToSpeech;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_camera);

        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());

        if(android.os.Build.VERSION.SDK_INT>9)
        {
            StrictMode.ThreadPolicy policy=new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }
        textToSpeech = new TextToSpeech(this,  this);
        ContentValues values = new ContentValues();
        values.put(MediaStore.Images.Media.TITLE, "NewPicture");
        values.put(MediaStore.Images.Media.DESCRIPTION, "From your Camera");
        imageUri = getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        intent.putExtra(MediaStore.EXTRA_OUTPUT, imageUri);
        startActivityForResult(intent, CAMERA_PIC_REQUEST);
//        uploadFile(imageurl);

    }

        @Override
        protected void onActivityResult(int requestCode, int resultCode, Intent data) {
            super.onActivityResult(requestCode, resultCode, data);

            if  (requestCode == CAMERA_PIC_REQUEST)
            {
                if (resultCode == RESULT_OK)
                {
                    try {

                        Bitmap thumbnail = MediaStore.Images.Media.getBitmap(getContentResolver(), imageUri);

                        Bitmap newbit=thumbnail;
//                        ivImage.setImageBitmap(newbit);
//                        ivImage.setVisibility(View.VISIBLE);
                        imageurl = getRealPathFromURI(imageUri);
                        path=imageurl;

//                        e2.setText(path);
                        File file = new File(imageurl);
                        String[] val=path.split("/");
                        fileName=val[val.length-1];
                        Toast.makeText(this,"ff-----"+fileName, Toast.LENGTH_LONG).show();
                        int ln=(int) file.length();

                        try
                        {
                            InputStream inputStream = new FileInputStream(file);
                            ByteArrayOutputStream bos = new ByteArrayOutputStream();

                            byte[] b = new byte[ln];
                            int bytesRead =0;

                            while ((bytesRead = inputStream.read(b)) != -1)
                            {
                                bos.write(b, 0, bytesRead);
                            }
                            inputStream.close();
                            byteArray = bos.toByteArray();

                            uploadFile(path);
                        }
                        catch (IOException e)
                        {
                            Toast.makeText(this,"Stringsss :"+e.getMessage().toString(), Toast.LENGTH_LONG).show();
                        }


                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        private String getRealPathFromURI(Uri contentURI) {

            Cursor cursor = getContentResolver()
                    .query(contentURI, null, null, null, null);
            if (cursor == null)
                path=contentURI.getPath();

            else {
                cursor.moveToFirst();
                int idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA);
                path=cursor.getString(idx);

            }
            if(cursor!=null)
                cursor.close();
            return path;
        }

        public void uploadFile(String sourceFileUri) {

	        url="http://"+sh.getString("ip", "") +":5001/addimg";

            String fileName = sourceFileUri;
            try {
                FileUpload client = new FileUpload(url);
                client.connectForMultipart();

                Toast.makeText(getApplicationContext(), fileName+"", Toast.LENGTH_LONG).show();
                client.addFilePart("files", fileName, byteArray);
                client.finishMultipart();
                String result = client.getResponse();
                Log.d("lllllllll---------",result);
                JSONObject json = new JSONObject(result);
                String res = json.getString("result");
//                Toast.makeText(this,"res-----"+result, Toast.LENGTH_LONG).show();
                String []resu=res.split("#");
                if(resu[0].equalsIgnoreCase( "na"))
                {
//                    Intent i=new Intent(getApplicationContext(),RegisterActivity.class);
//                    i.putExtra("img",resu[1]);
//                    startActivity(i);
                    Toast.makeText(this,"INVALID USER !!!", Toast.LENGTH_LONG).show();
                    String msgg="INVALID USER";
                    convertTextToSpeech(msgg);
                }
                else
                {
                    SharedPreferences.Editor ed=sh.edit();
                    ed.putString("id",resu[1]);
                    ed.putString("name",resu[0]);
                    Intent i=new Intent(getApplicationContext(),view_exam_notification.class);
//                    i.putExtra("name",resu[0]);
                    startActivity(i);
                }

                Log.d("response=======",result);
            }
            catch (Exception e){
                Toast.makeText(getApplicationContext(), "Exception 123 : " +e, Toast.LENGTH_LONG).show();
            }

        }

    public void convertTextToSpeech(String text) {
        if (null == text || "".equals(text)) {
            text = "START VERIFICATION...";
        }
//        Toast.makeText(getApplicationContext(), "Errorrrrr", Toast.LENGTH_LONG).show();
        textToSpeech.speak(text, TextToSpeech.LANG_AVAILABLE, null);
    }
    @Override
    public void onInit(int status) {
        if (status == TextToSpeech.SUCCESS) {
            int result = textToSpeech.setLanguage(Locale.US);
            if (result == TextToSpeech.LANG_MISSING_DATA
                    || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                Log.e("error", "This Language is not supported");
            }
            else {
                convertTextToSpeech("");
            }
        } else {
            Log.e("error", "Initilization Failed!");
        }
    }

    @Override
    public void onBackPressed() {

        super.onBackPressed();
        Intent i=new Intent(getApplicationContext(),home.class);
        startActivity(i);
    }
}
