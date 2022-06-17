import java.io.* ;
import java.net.*;
import java.*;


public class IOTClient  {
   public static void main(String args[]) throws Exception 
     {    
         
      
      while(true) 
        {
         try
	       {
	        new Middle().start();
	       }
	     finally
           {
		    System.out.println("");
		   }  
        }
    }

//------------------------------------------------------------------------------ 
  private static class Middle extends Thread 
    {
     public Middle() 
       {
       }
       
      
 //-----------------run---------------------------------------------------------
   public  void run()
     { 
   	  //static boolean RunFlg;
      int UdpPort = 2000;
 

         
         DatagramSocket serverSocket = null;
         try
              {
                serverSocket = new DatagramSocket(UdpPort);
              }  
          catch(Exception e ) 
              {
          }
         
         try
           {
            byte[] receiveData = new byte[1024];

            DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
            String sentence ;     

            while(true)
              {
               serverSocket.receive(receivePacket);
               sentence = receivePacket.getData().toString();
               System.out.println("Received Event "+ sentence);              
              }
           } 
         catch(Exception e ) 
           {
            System.out.println("Exception @ UDPServer");
           } 
        }
     }      
} 

