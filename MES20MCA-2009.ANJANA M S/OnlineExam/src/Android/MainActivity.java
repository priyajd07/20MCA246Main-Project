package com.example.onlineexam;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Point;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.Display;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Toast;
import android.widget.ToggleButton;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.vision.CameraSource;
import com.google.android.gms.vision.Detector;
import com.google.android.gms.vision.Tracker;
import com.google.android.gms.vision.face.Face;
import com.google.android.gms.vision.face.FaceDetector;
import com.google.android.gms.vision.face.LargestFaceFocusingProcessor;
import com.google.android.material.snackbar.Snackbar;

import java.io.IOException;



public class MainActivity extends AppCompatActivity {
    private static final float MIN_FACE_SIZE_RATIO = 0.2f;
    public static final int MSG_DISMISS_DIALOG = 1;
    public static final int MSG_SHOW_DIALOG = 0;
    public static final int MSG_TIMEOUT = 2000;
    private static final int RC_HANDLE_CAMERA_PERM = 2;
    private static final int RC_HANDLE_GMS = 9001;
    private static final float REQUEST_FPS = 30.0f;
    private static final String TAG = "MainActivity";
    private static boolean sIsScreenOn = true;
    public static int sScreenHeight;
    public static int sScreenWidth;
    private AlertDialog mAlertDialog;
    private Handler mAlertHandler;
    private CameraSource mCameraSource;
    private GraphicOverlay mGraphicOverlay;
    private CameraSourcePreview mPreview;

    private class GraphicFaceTracker extends Tracker<Face> {
        private FaceGraphic mFaceGraphic;
        private GraphicOverlay mOverlay;

        GraphicFaceTracker(GraphicOverlay overlay) {
            this.mOverlay = overlay;
            this.mFaceGraphic = new FaceGraphic(this.mOverlay, MainActivity.this.mAlertHandler,getApplicationContext());
        }

        public void onNewItem(int faceId, Face item) {
        }

        public void onUpdate(Detector.Detections<Face> detections, Face face) {
            if (face!=null)
            {
                Intent i=new Intent(MainActivity.this,Camera.class);
                startActivity(i);
            }

            this.mOverlay.add(this.mFaceGraphic);
            this.mFaceGraphic.updateFace(face);
        }

        public void onMissing(Detector.Detections<Face> detections) {
            this.mOverlay.remove(this.mFaceGraphic);
        }

        public void onDone() {
            this.mOverlay.remove(this.mFaceGraphic);
        }
    }

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        this.mPreview = (CameraSourcePreview) findViewById(R.id.cameraSourcePreview);
        this.mGraphicOverlay = (GraphicOverlay) findViewById(R.id.graphicOverlay);
        if (sIsScreenOn) {
            this.mPreview.setAlpha(1.0f);
        } else {
            this.mPreview.setAlpha(0.0f);

        }

        if (ActivityCompat.checkSelfPermission(this, "android.permission.CAMERA") == 0) {
            createAlert();
            createCameraSource();
            return;
        }
        requestCameraPermission();
    }

    private void createCameraSource() {
        Context context = getApplicationContext();
        FaceDetector detector = new FaceDetector.Builder(context).setProminentFaceOnly(true).setClassificationType(MSG_DISMISS_DIALOG).setTrackingEnabled(true).setMinFaceSize(MIN_FACE_SIZE_RATIO).build();
        detector.setProcessor(new LargestFaceFocusingProcessor(detector, new GraphicFaceTracker(this.mGraphicOverlay)));
        if (!detector.isOperational()) {
            Log.w(TAG, "Face detector dependencies are not yet available.");
        }
        Display display = getWindowManager().getDefaultDisplay();
        Point screenSize = new Point();
        display.getSize(screenSize);
        if (getResources().getConfiguration().orientation == MSG_DISMISS_DIALOG) {
            sScreenWidth = screenSize.y;
            sScreenHeight = screenSize.x;
        } else {
            sScreenWidth = screenSize.x;
            sScreenHeight = screenSize.y;
        }
        this.mCameraSource = new CameraSource.Builder(context, detector).setRequestedPreviewSize(sScreenWidth, sScreenHeight).setFacing(MSG_DISMISS_DIALOG).setRequestedFps(REQUEST_FPS).setAutoFocusEnabled(true).build();
    }

    private void requestCameraPermission() {
        Log.w(TAG, "Camera permission is not granted. Requesting permission");
        final String[] permissions = new String[MSG_DISMISS_DIALOG];
        permissions[MSG_SHOW_DIALOG] = "android.permission.CAMERA";
        if (ActivityCompat.shouldShowRequestPermissionRationale(this, "android.permission.CAMERA")) {
            Snackbar.make(this.mGraphicOverlay, R.string.permission_camera_rationale, 2).setAction(R.string.ok, new View.OnClickListener() {
                public void onClick(View view) {
                    ActivityCompat.requestPermissions(MainActivity.this, permissions, MainActivity.RC_HANDLE_CAMERA_PERM);
                }
            }).show();
            return;
        }
        ActivityCompat.requestPermissions(this, permissions, RC_HANDLE_CAMERA_PERM);
    }

    private void createAlert() {
        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(this);
        alertDialogBuilder.setView(LayoutInflater.from(this).inflate(R.layout.alert_popup, null, false));
        this.mAlertDialog = alertDialogBuilder.create();
        this.mAlertDialog.setCanceledOnTouchOutside(true);
        Sounds.initAlertSound(this);
        this.mAlertHandler = new Handler(new Handler.Callback() {
            public boolean handleMessage(Message msg) {
                switch (msg.what) {
                    case MainActivity.MSG_SHOW_DIALOG /*0*/:
                        if (!(MainActivity.this.mAlertDialog == null || MainActivity.this.mAlertDialog.isShowing())) {
//                            MainActivity.this.mAlertDialog.show();
//                            Sounds.alert();
                            break;
                        }
                    case MainActivity.MSG_DISMISS_DIALOG /*1*/:
                        if (MainActivity.this.mAlertDialog != null && MainActivity.this.mAlertDialog.isShowing()) {
//                            MainActivity.this.mAlertDialog.dismiss();
                            break;
                        }
                }
                return true;
            }
        });
    }

    public void onMuteButtonClicked(View v) {
        Sounds.changeState(((ToggleButton) v).isChecked());
        if (((ToggleButton) v).isChecked()) {
            Toast.makeText(getApplicationContext(), R.string.sound_off, Toast.LENGTH_LONG).show();
        } else {
            Toast.makeText(getApplicationContext(), R.string.sound_on, Toast.LENGTH_LONG).show();
        }
    }

    public void onCameraButtonClicked(View v) {
        if (((ToggleButton) v).isChecked()) {
            this.mPreview.setAlpha(0.0f);
            this.mPreview.animate().translationY((float) ((-this.mPreview.getHeight()) + MSG_DISMISS_DIALOG));
            sIsScreenOn = false;

            Toast.makeText(getApplicationContext(), R.string.hide_screen, Toast.LENGTH_LONG).show();
            return;
        }
        this.mPreview.setAlpha(1.0f);
        this.mPreview.animate().translationY(0.0f);
        sIsScreenOn = true;
        Toast.makeText(getApplicationContext(), R.string.show_screen, Toast.LENGTH_LONG).show();
    }

    public void onExitButtonClicked(View v) {
        finish();
    }

    public void onInfoButtonClicked(View v) {
        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(this);
        alertDialogBuilder.setView(LayoutInflater.from(this).inflate(R.layout.info_popup, null, false));
        alertDialogBuilder.setCancelable(false).setPositiveButton(R.string.ok, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
            }
        });
        alertDialogBuilder.create().show();
    }

    protected void onResume() {
        super.onResume();
        startCameraSource();
        showFirstMessage();
    }

    private void showFirstMessage() {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(getBaseContext());
        if (!prefs.getBoolean(getString(R.string.pref_previously_started), false)) {
            SharedPreferences.Editor edit = prefs.edit();
            edit.putBoolean(getString(R.string.pref_previously_started), Boolean.TRUE.booleanValue());
            edit.apply();
            AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(this);
            alertDialogBuilder.setView(LayoutInflater.from(this).inflate(R.layout.start_popup, null, false));
            alertDialogBuilder.setTitle(R.string.start_title);
            alertDialogBuilder.setCancelable(false).setPositiveButton(R.string.ok, new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int id) {
                }
            });
            alertDialogBuilder.create().show();
        }
    }

    protected void onPause() {
        super.onPause();
        if (this.mAlertDialog != null && this.mAlertDialog.isShowing()) {
            this.mAlertDialog.dismiss();
        }
        this.mPreview.stop();
    }

    protected void onDestroy() {
        super.onDestroy();
        if (this.mCameraSource != null) {
            this.mCameraSource.release();
        }
    }

    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode != RC_HANDLE_CAMERA_PERM) {
            Log.d(TAG, "Got unexpected permission result: " + requestCode);
            super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        } else if (grantResults.length == 0 || grantResults[MSG_SHOW_DIALOG] != 0) {
            Log.e(TAG, "Permission not granted: results len = " + grantResults.length + " Result code = " + (grantResults.length > 0 ? Integer.valueOf(grantResults[MSG_SHOW_DIALOG]) : "(empty)"));
            new AlertDialog.Builder(this).setTitle(R.string.app_name).setMessage(R.string.no_camera_permission).setPositiveButton(R.string.ok, new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int id) {
                    MainActivity.this.finish();
                }
            }).show();
        } else {
            Log.d(TAG, "Camera permission granted - initialize the camera source");
            createCameraSource();
        }
    }


    private void startCameraSource() {
        int code = GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(getApplicationContext());
        if (code != 0) {
            GoogleApiAvailability.getInstance().getErrorDialog(this, code, RC_HANDLE_GMS).show();
        }
        if (this.mCameraSource != null) {
            try {
                this.mPreview.start(this.mCameraSource, this.mGraphicOverlay);
            } catch (IOException e) {
                Log.e(TAG, "Unable to start camera source.", e);
                this.mCameraSource.release();
                this.mCameraSource = null;
            }
        }
    }
    @Override
    public void onBackPressed() {

        super.onBackPressed();
        Intent i=new Intent(getApplicationContext(),home.class);
        startActivity(i);
    }
}
