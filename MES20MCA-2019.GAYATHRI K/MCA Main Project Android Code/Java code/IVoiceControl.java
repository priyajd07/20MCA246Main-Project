package com.example.talkarena;

public interface IVoiceControl {
    public abstract void processVoiceCommands(String... voiceCommands); 
    
    public void restartListeningService(); 
}
