import java.io.* ;
import java.net.*;
import java.*;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.concurrent.ArrayBlockingQueue;

class IOTThrDb extends Thread 
  {
//-----------------------------------------------------------------------------------------------------
     ArrayBlockingQueue<String> Que ;
     private Connection con = null;
     String Str ;

     public IOTThrDb(String xStr, Connection xCon, ArrayBlockingQueue<String> xQue) 
       {
         this.Str              = xStr;
         this.con              = xCon;
         this.Que              = xQue;  
System.out.println("AppThread "+xStr );   
      }
 //-----------------run---------------------------------------------------------
   public  void run()
     { 
       int Strlen = 0;
       String Func = "";

       try 
          {
              Func = "WRITE_EDDAT(?,?,?,?) }";
              String call = "{ ? = call " + Func;
              CallableStatement cstmt = con.prepareCall(call);                         
              cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.VARCHAR);

              String Cod      = Str.substring(0,4).trim();
              String Dat  = Str.substring(4,7).trim();
              String Tim   = Str.substring(7,21).trim();
              String Val   = Str.substring(21,39).trim();
              int Reading    = Integer.parseInt(Val);

              cstmt.setString(2,Cod);     // Client Code
              cstmt.setString(3,Dat); // Data Type
              cstmt.setString(4,Tim);      // Date and Time 
              cstmt.setInt(5,Reading);  // Reading 
              cstmt.execute();
              Str = cstmt.getString(1);  
              System.out.println("Func-->"+"->"+Str);       

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
           Str= "OE0"+String.format("%3s",Err.length()).replace(' ','0')+Err+"016From JIAppThread      OK";
       }          
                      
       Que.add(Str);
   }
}
