package com.example.talkarena;

import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.SpeechRecognizer;

import java.util.ArrayList;

public class
VoiceRecognitionListener implements RecognitionListener {
 
 private static VoiceRecognitionListener instance = null;
 
 IVoiceControl listener; 
 public static VoiceRecognitionListener getInstance() {
  if (instance == null) {
   instance = new VoiceRecognitionListener();
  }
  return instance;
 }
 
 private VoiceRecognitionListener() { }
 
 public void setListener(IVoiceControl listener) {
        this.listener = listener;
    }
 
    public void processVoiceCommands(String... voiceCommands) {
        listener.processVoiceCommands(voiceCommands);
    }
 
    
 public void onResults(Bundle data) {
	
  ArrayList matches = data.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
  String[] commands = new String[matches.size()];

  commands = (String[]) matches.toArray(commands);
  processVoiceCommands(commands);
 }
 
 
 public void onBeginningOfSpeech() {
  System.out.println("Starting to listen");
 }
 
 public void onBufferReceived(byte[] buffer) { }
 
 
 public void onEndOfSpeech() {
  System.out.println("Waiting for result...");
 }
 
 
 public void onError(int error) {
  if (listener != null) {
   listener.restartListeningService();
  }
 }
 public void onEvent(int eventType, Bundle params) { }
 
 public void onPartialResults(Bundle partialResults) { }
 
 public void onReadyForSpeech(Bundle params) { }
 
 public void onRmsChanged(float rmsdB) { }
}
