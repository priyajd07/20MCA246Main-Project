package com.example.roaddamageapp;

import android.Manifest;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.hardware.SensorListener;
import android.hardware.SensorManager;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.speech.tts.TextToSpeech;
import android.telephony.SmsManager;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.widget.Toast;

import androidx.core.app.ActivityCompat;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

// Volley Imports

public class LocationService extends Service implements SensorListener {
	//	private static final Location TODO = ;
	private LocationManager locationManager;
	private Boolean locationChanged;

	private Handler handler = new Handler();
	public static Location curLocation;
	public static boolean isService = true;
	private File root;
	private ArrayList<String> fileList = new ArrayList<String>();

	public static String lati = "", logi = "", place = "";
	String ip = "";
	String[] zone;
	String pc = "";
	TextToSpeech textToSpeech;

	String imei = "";
	String encodedImage = null;

//	TelephonyManager telemanager;
	SharedPreferences sh;


	// Emergency Service Variables
	private long lastUpdate = -1;
	private float x, y, z;
	private float last_x, last_y, last_z;
	private static final int SHAKE_THRESHOLD = 2400;
	float speed = 0;
	public static double latitude;
	public static double longitude;
	private SensorManager sensorMgr;


	LocationListener locationListener = new LocationListener() {

		public void onLocationChanged(Location location) {
			if (curLocation == null) {
				curLocation = location;
				locationChanged = true;
			} else if (curLocation.getLatitude() == location.getLatitude() && curLocation.getLongitude() == location.getLongitude()) {
				locationChanged = false;
				return;
			} else
				locationChanged = true;
			curLocation = location;

			if (locationChanged)
				locationManager.removeUpdates(locationListener);
		}

		public void onProviderDisabled(String provider) {
		}

		public void onProviderEnabled(String provider) {
		}

		@Override
		public void onStatusChanged(String provider, int status, Bundle extras) {
			// TODO Auto-generated method stub
			if (status == 0)// UnAvailable
			{
			} else if (status == 1)// Trying to Connect
			{
			} else if (status == 2) {// Available
			}
		}
	};


//	@SuppressLint("MissingPermission")
	@Override
	public void onCreate() {
		super.onCreate();

		if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED&& ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
			// TODO: Consider calling
			//    ActivityCompat#requestPermissions
			// here to request the missing permissions, and then overriding
			//   public void onRequestPermissionsResult(int requestCode, String[] permissions,
			//                                          int[] grantResults)
			// to handle the case where the user grants the permission. See the documentation
			// for ActivityCompat#requestPermissions for more details.
//			telemanager = (TelephonyManager) getApplicationContext().getSystemService(Context.TELEPHONY_SERVICE);



		}
		curLocation = getBestLocation();

		if (curLocation == null) {
			System.out.println("starting problem.........3...");
			Toast.makeText(this, "GPS problem..........", Toast.LENGTH_SHORT).show();
		} else {
			// Log.d("ssssssssssss", String.valueOf("latitude2.........."+curLocation.getLatitude()));
		}
		isService = true;

		textToSpeech = new TextToSpeech(getApplicationContext(), new TextToSpeech.OnInitListener() {
			@Override
			public void onInit(int i) {

				// if No error is found then only it will run
				if(i!=TextToSpeech.ERROR){
					// To Choose language of speech
					textToSpeech.setLanguage(Locale.UK);
				}
			}
		});
	}

	final String TAG = "LocationService";

	@Override
	public int onStartCommand(Intent intent, int flags, int startId) {
		return super.onStartCommand(intent, flags, startId);
	}

	@Override

	public void onLowMemory() {
		super.onLowMemory();

	}

	@Override
	public void onStart(Intent intent, int startId) {
		//  Toast.makeText(this, "Start services", Toast.LENGTH_SHORT).show();

		sh = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());

		String provider = Settings.Secure.getString(getContentResolver(), Settings.Secure.LOCATION_PROVIDERS_ALLOWED);

		if (!provider.contains("gps")) { //if gps is disabled
			final Intent poke = new Intent();
			poke.setClassName("com.android.settings", "com.android.settings.widget.SettingsAppWidgetProvider");
			poke.addCategory(Intent.CATEGORY_ALTERNATIVE);
			poke.setData(Uri.parse("3"));
			sendBroadcast(poke);
		}
		handler.postDelayed(GpsFinder, 10000);

		//Toast.makeText(this, "Start Services", Toast.LENGTH_SHORT).show();
		handler.post(GpsFinder);

		// start motion detection
		sensorMgr = (SensorManager) getSystemService(SENSOR_SERVICE);
		boolean accelSupported = sensorMgr.registerListener(this, SensorManager.SENSOR_ACCELEROMETER, SensorManager.SENSOR_DELAY_GAME);

		if (!accelSupported) {
			// on accelerometer on this device
			sensorMgr.unregisterListener((SensorListener) this,
					SensorManager.SENSOR_ACCELEROMETER);
		}
	}

	@Override
	public void onDestroy() {
		String provider = Settings.Secure.getString(getContentResolver(), Settings.Secure.LOCATION_PROVIDERS_ALLOWED);

		if (provider.contains("gps")) { //if gps is enabled
			final Intent poke = new Intent();
			poke.setClassName("com.android.settings", "com.android.settings.widget.SettingsAppWidgetProvider");
			poke.addCategory(Intent.CATEGORY_ALTERNATIVE);
			poke.setData(Uri.parse("3"));
			sendBroadcast(poke);
		}

		handler.removeCallbacks(GpsFinder);
		handler = null;
		Toast.makeText(this, "Service Stopped..!!", Toast.LENGTH_SHORT).show();
		isService = false;
	}


	public Runnable GpsFinder = new Runnable() {


		public void run() {


			String provider = Settings.Secure.getString(getContentResolver(), Settings.Secure.LOCATION_PROVIDERS_ALLOWED);

			if (!provider.contains("gps")) { //if gps is disabled
				final Intent poke = new Intent();
				poke.setClassName("com.android.settings", "com.android.settings.widget.SettingsAppWidgetProvider");
				poke.addCategory(Intent.CATEGORY_ALTERNATIVE);
				poke.setData(Uri.parse("3"));
				sendBroadcast(poke);
			}


			Location tempLoc = getBestLocation();

			if (tempLoc != null) {

				//Toast.makeText(getApplicationContext(), phoneid, Toast.LENGTH_LONG).show();

				curLocation = tempLoc;
				// Log.d("MyService", String.valueOf("latitude"+curLocation.getLatitude()));

				lati = String.valueOf(curLocation.getLatitude());
				logi = String.valueOf(curLocation.getLongitude());



				loc();


				// Toast.makeText(getApplicationContext(),URL+" received", Toast.LENGTH_SHORT).show();
				Toast.makeText(getApplicationContext(), "\nlat.. and longi.." + lati + "..." + logi, Toast.LENGTH_SHORT).show();


				String loc = "";
				String address = "";
				Geocoder geoCoder = new Geocoder(getBaseContext(), Locale.getDefault());
				try {
					List<Address> addresses = geoCoder.getFromLocation(curLocation.getLatitude(), curLocation.getLongitude(), 1);
					if (addresses.size() > 0) {
						for (int index = 0; index < addresses.get(0).getMaxAddressLineIndex(); index++)
							address += addresses.get(0).getAddressLine(index) + " ";
						//Log.d("get loc...", address);

						place = addresses.get(0).getFeatureName().toString();


						//	 loc= addresses.get(0).getLocality().toString();
						//	Toast.makeText(getBaseContext(),address , Toast.LENGTH_SHORT).show();
						//	Toast.makeText(getBaseContext(),ff , Toast.LENGTH_SHORT).show();
					} else {
						//Toast.makeText(getBaseContext(), "noooooooo", Toast.LENGTH_SHORT).show();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}

				Toast.makeText(getBaseContext(), "locality-" + place, Toast.LENGTH_SHORT).show();


			}
			handler.postDelayed(GpsFinder, 55000);// register again to start after 20 seconds...
		}


	};

	private void loc() {
		imei = Settings.Secure.getString(getContentResolver(),
				Settings.Secure.ANDROID_ID);
//		Toast.makeText(getApplicationContext(), "UID loc " + imei, Toast.LENGTH_LONG).show();
		RequestQueue queue = Volley.newRequestQueue(LocationService.this);
		String url = "http://" + sh.getString("ip","") + ":5000/loc";

		StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
			@Override
			public void onResponse(String response) {

				try {
					JSONObject json = new JSONObject(response);
					String res = json.getString("task");

					if (res.equalsIgnoreCase("error")) {
						Toast.makeText(getApplicationContext(), res, Toast.LENGTH_SHORT).show();
					} else {


						textToSpeech.speak(res,TextToSpeech.QUEUE_FLUSH,null);

						Toast.makeText(getApplicationContext(), res, Toast.LENGTH_SHORT).show();
					}
				} catch (JSONException e) {
					e.printStackTrace();
				}


			}
		}, new Response.ErrorListener() {
			@Override
			public void onErrorResponse(VolleyError error) {


				Toast.makeText(getApplicationContext(), "Error" + error, Toast.LENGTH_SHORT).show();
			}
		}) {
			@Override
			protected Map<String, String> getParams() {
				Map<String, String> params = new HashMap<String, String>();

				params.put("lati", lati);
				params.put("longi", logi);

				return params;
			}
		};
		// Add the request to the RequestQueue.
		queue.add(stringRequest);







	}



	private Location getBestLocation() {
		Location gpslocation = null;
		Location networkLocation = null;
		if (locationManager == null) {
			locationManager = (LocationManager) getApplicationContext().getSystemService(Context.LOCATION_SERVICE);
		}
		try {
			if (locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {

				if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
					// TODO: Consider calling
					//    ActivityCompat#requestPermissions
					// here to request the missing permissions, and then overriding
					//   public void onRequestPermissionsResult(int requestCode, String[] permissions,
					//                                          int[] grantResults)
					// to handle the case where the user grants the permission. See the documentation
					// for ActivityCompat#requestPermissions for more details.
					return gpslocation;
				}
				locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 5000, 0, locationListener);// here you can set the 2nd argument time interval also that after how much time it will get the gps location
	                gpslocation = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
	             //  System.out.println("starting problem.......7.11....");
	              
	            }
	            if(locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)){
	                locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER,5000, 0, locationListener);
	                networkLocation = locationManager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER);
	            }
	        } catch (IllegalArgumentException e) {
	            Log.e("error", e.toString());
	        }
	        if(gpslocation==null && networkLocation==null)
	            return null;

	        if(gpslocation!=null && networkLocation!=null){
	            if(gpslocation.getTime() < networkLocation.getTime()){
	                gpslocation = null;
	                return networkLocation;
	            }else{
	                networkLocation = null;
	                return gpslocation;
	            }
	        }
	        if (gpslocation == null) {
	            return networkLocation;
	        }
	        if (networkLocation == null) {
	            return gpslocation;
	        }
	        return null;
	    }


	@Override
	public IBinder onBind(Intent arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void onSensorChanged(int arg0, float[] arg1) {
		if (arg0 == SensorManager.SENSOR_ACCELEROMETER) {
			long curTime = System.currentTimeMillis();
			// only allow one update every 100ms.
			if ((curTime - lastUpdate) > 100) {
				long diffTime = (curTime - lastUpdate);
				lastUpdate = curTime;

				x = arg1[SensorManager.DATA_X];
				y = arg1[SensorManager.DATA_Y];
				z = arg1[SensorManager.DATA_Z];

				if (Round(x, 4) > 10.0000) {
					Log.d("sensor", "X Right axis: " + x);
					//     Toast.makeText(this, "Right shake detected", Toast.LENGTH_SHORT).show();
				} else if (Round(y, 4) > 10.0000) {
					Log.d("sensor", "X Right axis: " + x);
					//    Toast.makeText(this, "Top shake detected", Toast.LENGTH_SHORT).show();
				} else if (Round(y, 4) > -10.0000) {
					Log.d("sensor", "X Right axis: " + x);
					//     Toast.makeText(this, "Bottom shake detected", Toast.LENGTH_SHORT).show();
				} else if (Round(x, 4) < -10.0000) {
					Log.d("sensor", "X Left axis: " + x);
					//    Toast.makeText(this, "Left shake detected", Toast.LENGTH_SHORT).show();
				}

				speed = Math.abs(x + y + z - last_x - last_y - last_z) / diffTime * 10000;

				// Log.d("sensor", "diff: " + diffTime + " - speed: " + speed);
				if (speed > SHAKE_THRESHOLD) {
					Log.d("sensor", "Shake detected w/ speed: " + speed);

//					TelephonyManager telephonyManager = (TelephonyManager) getApplicationContext().getSystemService(Context.TELEPHONY_SERVICE);

//					Thread th = new Thread(new Runnable() {
//						@Override
//						public void run() {
//							RequestQueue queue = Volley.newRequestQueue(LocationService.this);
//							final String url ="http://"+sh.getString("ip", "") + ":5000/prediction";
//							StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
//								@Override
//								public void onResponse(String response) {
//									// Display the response string.
//
//									try {
//										JSONObject json = new JSONObject(response);
										String res ="";// json.getString("task");
										String msg="http://maps.google.com/maps?q="+LocationService.lati+","+LocationService.logi;


//										if (res.equalsIgnoreCase("ok")) {
											Toast.makeText(getApplicationContext(), "success", Toast.LENGTH_LONG).show();
                                            SmsManager smsManager = SmsManager.getDefault();
                                            smsManager.sendTextMessage(sh.getString("enumber","9495779552"), null, "HELP!!"+msg, null, null);




//										} else {
//
//
//
//										}
//								} catch (JSONException e) {
//											e.printStackTrace();
//									}
//
//
//								}
//
//							}, new Response.ErrorListener() {
//								@Override
//								public void onErrorResponse(VolleyError error) {
//
//
////                                    Toast.makeText(getApplicationContext(), "Error" + error, Toast.LENGTH_LONG).show();
//								}
//							}) {
//								@Override
//								protected Map<String, String> getParams() {
//									Map<String, String> params = new HashMap<String, String>();
//
//
//									params.put("latitude", ""+LocationService.lati);
//
//									params.put("longitude", ""+LocationService.logi);
////									params.put("loc", place);
//
//									params.put("speed",""+speed);
//									params.put("ax_z",""+x);
//									params.put("uid",sh.getString("lid",""));
//
//
//
//									return params;
//								}
//							};
//							queue.add(stringRequest);

//						}
//					});
//					th.start();




					if (ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
						// TODO: Consider calling
						//    ActivityCompat#requestPermissions
						// here to request the missing permissions, and then overriding
						//   public void onRequestPermissionsResult(int requestCode, String[] permissions,
						//                                          int[] grantResults)
						// to handle the case where the user grants the permission. See the documentation
						// for ActivityCompat#requestPermissions for more details.
						return;
					}

					Thread thh = new Thread(new Runnable() {
						@Override
						public void run() {
							RequestQueue queue = Volley.newRequestQueue(LocationService.this);
							final String url ="http://"+sh.getString("ip", "") + ":5000/addemergency";
							StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
								@Override
								public void onResponse(String response) {
									// Display the response string.
									Log.d("+++++++++++++++++", response);
									try {
										JSONObject json = new JSONObject(response);
										String res = json.getString("task");
										String msg="http://maps.google.com/maps?q="+lati+","+logi;

										if (res.equalsIgnoreCase("ok")) {
											String ph=sh.getString("carephone","");
											String blindName = sh.getString("name", "");
											SmsManager smsManager = SmsManager.getDefault();
											smsManager.sendTextMessage(ph, null, blindName + " Emergency , Location: " + msg, null, null);

										} else {

										}
									} catch (JSONException e) {
										e.printStackTrace();
									}

								}

							}, new Response.ErrorListener() {
								@Override
								public void onErrorResponse(VolleyError error) {


//                                    Toast.makeText(getApplicationContext(), "Error" + error, Toast.LENGTH_LONG).show();
								}
							}) {
								@Override
								protected Map<String, String> getParams() {
									Map<String, String> params = new HashMap<>();
									params.put("imei", sh.getString("UID", ""));
									params.put("latt", lati);
									params.put("longi", logi);
									return params;
								}
							};
							queue.add(stringRequest);

						}
					});
//					th.start();

					last_x = x;
					last_y = y;
					last_z = z;
				}
			}
		}}

	@Override
	public void onAccuracyChanged(int sensor, int accuracy) {

	}

	public static float Round(float x2, int i) {
		// TODO Auto-generated method stub
		float p = (float) Math.pow(10, i);
		x2 = x2 * p;
		float tmp = Math.round(x2);
		return (float) tmp / p;
	}
}
