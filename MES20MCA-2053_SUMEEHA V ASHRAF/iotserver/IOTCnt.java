import java.io.* ;
import java.net.*;
import java.*;
import java.util.concurrent.ArrayBlockingQueue;
import java.sql.Connection;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.nio.charset.*;
import java.util.Date;
import java.util.Timer; 
import java.util.TimerTask; 
//------------------------------------------------------------------------------ 
  class IOTCnt extends Thread 
    {
     BufferedOutputStream Bfout = null ;   // For sending display data and files
     BufferedReader reqin = null;          // For reading client requests

     Connection Con = null;
     int Mqcap=10,Tqcap=5;
     private String Debug;
     private String Str="",call = "";
     CallableStatement cstmt = null;
     Socket Soc = new Socket();
     
     public IOTCnt(Socket xSoc,Connection xCon,String xDebug) 
       {
         this.Soc              = xSoc  ;
         this.Con               = xCon;
         this.Debug         = xDebug;
      System.out.println("IOT control is running");
       }
//-----------------run---------------------------------------------------------
   public  void run()
    { 
      try {       
          reqin   = new BufferedReader(new InputStreamReader(Soc.getInputStream()));
          Str = Read_Clt(reqin);                    
          int Strlen = 0;
          String Func = "",Packtype,Cln,Ass,DatCod,Loc;
          Packtype = Str.substring(0,1);
        
          if  ( Packtype.equals("R") ) {
              Func = "LAST_CLIENT_NO() }";
              call = "{ ? = call " + Func;
              cstmt = Con.prepareCall(call);                         
              cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.VARCHAR);
              cstmt.execute();
              Cln = cstmt.getString(1);
              int No = Integer.parseInt(Cln) + 1;
              Cln  = Integer.toString(No);  

              Func = "WRITE_EDGCLN(?,?) }";
              call = "{ ? = call " + Func;
              cstmt = Con.prepareCall(call);                         
              cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.VARCHAR);
              Loc  = Str.substring(1,Str.length());

              cstmt.setString(2,Cln);     // Client Code
              cstmt.setString(3,Loc); // Description
              cstmt.execute();
              Str = cstmt.getString(1);  
              System.out.println("Func-->"+"->"+Str);       
           }
          // asignment
          else if  ( Packtype.equals("A") ) {
              Func = "WRITE_CLNASS(?,?,?) }";
              call = "{ ? = call " + Func;
              cstmt = Con.prepareCall(call);                         
              cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.VARCHAR);
              Cln      = Str.substring(1,5).trim();
              DatCod  = Str.substring(5,8).trim();
              Ass       = Str.substring(8,11).trim();

              cstmt.setString(2,Cln);     // Client Code
              cstmt.setString(3,DatCod); // Data Type
              cstmt.setString(4,Ass);      // Assignment 
              cstmt.execute();
              Str = cstmt.getString(1);  
              System.out.println("Func-->"+"->"+Str);       
           }
          else if  ( Packtype.equals("M") ) {
              Func = "WRITE_IOTMESSAGE(?,?,?,?) }";
              call = "{ ? = call " + Func;
              cstmt = Con.prepareCall(call);                         
              cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.VARCHAR);

              Cln      = Str.substring(1,5).trim();
              Loc     = Str.substring(5,19).trim();

              cstmt.setString(2,Cln);     // Client Code
              cstmt.setString(3,Loc);    // Date and time
              cstmt.execute();
              Str = cstmt.getString(1);  
              System.out.println("Func-->"+"->"+Str);       
           }

          if  ( Str == null)
                  Str= "Error";
        }
        catch (Exception e) 
         {
           String Err;
         
           if (e.getMessage()==null)
              Err="Could not call function ";
           else
              Err=e.getMessage().toString();
          
           Err=String.format(Err).replace('\n','0');
           Str= Err;
       }                                
       try {
           Bfout   = new BufferedOutputStream(Soc.getOutputStream());
           Send_and_Close(Str,true);
       }
        catch (Exception e) 
         {
         }
  } // pfunction    
 /* ------------------------------  Send_To_Client ------------------------------*/ 
  private void Send_and_Close(String Snd,boolean Cl)   
  {
        String ToSnd=Snd;
System.out.println(ToSnd); 
        try {       
           BufferedOutputStream Bout = new BufferedOutputStream(Soc.getOutputStream());
           Send_To_Client (ToSnd,Bout);  
        }
        catch ( Exception e) {
           System.out.println("Error in creating streams for sending ");
        }   

        if (Cl)
           Close_All();       
  }

 /* ------------------------------  Send_To_Client ------------------------------*/ 
  private void Send_To_Client(String Snd,BufferedOutputStream ackout)   
   {
    byte[] Bbuff = new byte[Snd.length()*2+6]; 
 
    try {
       Bbuff = Snd.getBytes(Charset.forName("UTF-8"));
       int cnt = Bbuff.length;
       ackout.write(Bbuff , 0, cnt );
       ackout.flush();     
       System.out.println("Sent To Clt "+Snd);
    }   
    catch (IOException e) 
      {
       //System.out.println("IOException e Error");
       String Err =e.getMessage().toString();
       System.out.println("Error in sending ");
       //Err=String.format(Err).replace('\n','0');
       //Str= "OE0"+String.format("%3s",Err.length()).replace(' ','0')+Err+"018From JItecMw-RunIO      OK";
      }
  }                        
 /* ------------------------------  Read Client ------------------------------*/
 private String  Read_Clt( BufferedReader reqin)  {
    String ClStr = "";

    try {
       ClStr   = reqin.readLine();
       }    
    catch (IOException e) 
      {
       ClStr= "Read error";
      }
   
    System.out.println("FROM Clt "+ClStr);

    return ClStr;
 }
//----------------------------------------------------------------------------   
  private void Close_All() {
      try {       
         Soc.close();
         Con.close();
         System.out.println("Socket closed");
      }
      catch ( Exception e) {
      }
   }
} // Top
 