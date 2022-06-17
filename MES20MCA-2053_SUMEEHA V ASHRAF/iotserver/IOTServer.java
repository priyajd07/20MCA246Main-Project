import java.io.* ;
import java.net.*;
import java.*;
import java.sql.Connection;

public class IOTServer
  {
   public static void main(String args[]) throws Exception   
    {                      
      String Debug = "";

      if (args.length > 0 )    
            Debug = args[0];
      
      IOTDB Fdb = new IOTDB();
      Fdb.ReadParm();
      Connection GrabCon = Fdb.connection();
      System.out.println("IOTServer Listening TCP on port "+ Integer.toString(Fdb.selfport));
      new IOTGrab(GrabCon,Fdb.udpport,Debug).start() ;

      ServerSocket welcomeSocket = new ServerSocket(Fdb.selfport);
      Socket ClientSocket;
     
      while(true) 
      {
         try
            {
              ClientSocket = welcomeSocket.accept();
System.out.println("Main--> Received a socket"+ClientSocket.getInetAddress().toString()  );
              Connection CntCon = Fdb.connection();
              new IOTCnt(ClientSocket,CntCon,Debug).start();
System.out.println("Main--> Control thread called");
             }
             catch ( Exception e) { System.out.println("Error In accepting connection from client"); }  
      }
   }
}


