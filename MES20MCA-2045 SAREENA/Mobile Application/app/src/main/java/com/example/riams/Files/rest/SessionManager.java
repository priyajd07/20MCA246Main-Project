package com.example.riams.Files.rest;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.HashMap;
//for storing data..once login data stored..to chek whether login or not,it chek session manager
public class SessionManager {
    SharedPreferences pref;
    SharedPreferences.Editor editor;
    Context context;

    int PRIVATE_MODE = 0;
 private static final String PREF_NAME = "MusicApp";
 private static final String IS_SIGNIN = "IsSignIn";
 public static final String KEY_USERNAME = "Username";
 public static final String KEY_PASSWORD = "Password";
    public static final String KEY_COURSE = "Course";
    public static final String KEY_DEPARTMENT = "Department";



    public static final String KEY_TROUPNAME = "troupname";
    public static final String KEY_LOCATION = "location";
    public static final String KEY_MOBILE = "mobile";
    public static final String KEY_EMAIL = "email";


 public SessionManager(Context context){
     this.context = context;
     pref=context.getSharedPreferences(PREF_NAME,PRIVATE_MODE);
     editor = pref.edit();
 }
   public void createSignInSession(String Email, String Password){
     editor.putBoolean(IS_SIGNIN,true);
     editor.putString(KEY_USERNAME,Email);
     editor.putString(KEY_PASSWORD,Password);
     editor.commit();
     }

    public void createuserInSession(String Course, String Department){
        editor.putBoolean(IS_SIGNIN,true);
        editor.putString(KEY_COURSE, String.valueOf(Course));
        editor.putString(KEY_DEPARTMENT, String.valueOf(Department));
        editor.commit();
    }
     public void checkSignin(){
     if (!this.isSignIn()){

         }
     }


    public void saveTroupDetails(String troupname, String location, String mobile, String email, String username, String password){

     editor.putString(KEY_TROUPNAME,troupname);
        editor.putString(KEY_LOCATION,location);
        editor.putString(KEY_MOBILE,mobile);
        editor.putString(KEY_EMAIL,email);
        editor.putString(KEY_USERNAME,username);
        editor.putString(KEY_PASSWORD,password);



        editor.commit();
    }
   /* public TroupResponse getTroupDetails(){

     return new TroupResponse(pref.getString(KEY_TROUPNAME,null),pref.getString(KEY_LOCATION,null),pref.getString(KEY_MOBILE,null),pref.getString(KEY_EMAIL,null),"",pref.getString(KEY_USERNAME,null),pref.getString(KEY_PASSWORD,null),"");


    }
*/
    public HashMap<String, String> getUserDetails(){
     HashMap<String, String> user = new HashMap<String, String>();
     user.put(KEY_USERNAME,pref.getString(KEY_USERNAME,null));
     user.put(KEY_PASSWORD,pref.getString(KEY_PASSWORD,null));
        user.put(KEY_COURSE,pref.getString(KEY_COURSE,null));
        user.put(KEY_DEPARTMENT,pref.getString(KEY_DEPARTMENT,null));
     return user;
    }
public boolean isSignIn(){
     return pref.getBoolean(IS_SIGNIN,false);
}
}
