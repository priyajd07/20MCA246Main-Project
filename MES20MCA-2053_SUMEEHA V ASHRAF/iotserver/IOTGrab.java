import java.io.* ;
import java.net.*;
import java.*;
import java.util.concurrent.ArrayBlockingQueue;
import java.sql.Connection;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.nio.charset.*;
//import java.lang.Object
import java.util.Timer; 
import java.util.TimerTask; 
//------------------------------------------------------------------------------ 
  class IOTGrab extends Thread 
    {
     BufferedOutputStream Bfout = null ;   // For sending display data and files
     BufferedReader reqin = null;          // For reading client requests
     Connection con = null;

     int UDPPort=0, Tqcap=5,port=0;
     InetAddress address = null;
     
     String Debug;
     byte[] buf = new byte[256];
     Connection Con;
     IOTDB Db;
     DatagramSocket socket;
     
     ArrayBlockingQueue<String> QueStatus ;     
    
     public IOTGrab(Connection xCon,int xUdp,String xDebug) 
       {
         this.Debug         = xDebug;
         this.Con             = xCon;
         this.UDPPort     = xUdp;
         QueStatus = new ArrayBlockingQueue<String>(5);     
         System.out.println("Data Grab is ON UDP "+this.UDPPort);
     }
//-----------------run---------------------------------------------------------
//  This will be running always till it is stopped manually.
//  Constructor :
   public  void run()
     {       
      // read the IOTFields table and store the field length of each fileds
      // Look for data coming in
      // start the db writing thread
      // send repply to the IOT Client
      String Str = "*";
      DatagramPacket packet = null;
      int Reading    = 0;
 
      try {
           socket = new DatagramSocket(this.UDPPort);
      }
      catch (Exception e) 
      {
           String Err =e.getMessage().toString();
           Err=String.format(Err).replace('\n','0');
      }         
      
      while ( true )  
      {       
          try {
            packet = new DatagramPacket(buf, buf.length);
            socket.receive(packet);
            
            address = packet.getAddress();
            port = packet.getPort();
            packet = new DatagramPacket(buf, buf.length, address, port);
            Str = new String(packet.getData(), 0, packet.getLength());
            
            if (Str.equals("end")) 
                break;

            int Strlen = 0;
            String Func = "";

            Func = "WRITE_EDDAT(?,?,?,?) }";
            String call = "{ ? = call " + Func;
            CallableStatement cstmt = con.prepareCall(call);                         
            cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.VARCHAR);

            String Cod      = Str.substring(1,5).trim();
            String Dat  = Str.substring(5,8).trim();
            String Tim   = Str.substring(8,22).trim();
            String Val   = Str.substring(22,38).trim();

            cstmt.setString(2,Cod);     // Client Code
            cstmt.setString(3,Dat); // Data Type
            cstmt.setString(4,Tim);      // Date and Time 
            cstmt.setString(5,Val);  // Value
            cstmt.execute();
            Str = cstmt.getString(1);  
            System.out.println("Func-->"+"->"+Str);       

            if  ( Str == null)
                  Str= "Error";
          }
           catch (Exception e) 
           {
              String Err =e.getMessage().toString();
              Err=String.format(Err).replace('\n','0');
            }         

          try
           {
              buf = Str.getBytes();
              DatagramPacket SendPacket = new DatagramPacket(buf, buf.length, address, port);
              socket.send(SendPacket);
            }
           catch (Exception e) 
           {
              String Err =e.getMessage().toString();
              Err=String.format(Err).replace('\n','0');
            }         
      } // while
      socket.close();
 } // Top
} 