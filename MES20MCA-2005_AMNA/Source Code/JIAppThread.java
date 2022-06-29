import java.io.* ;
import java.net.*;
import java.*;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.concurrent.ArrayBlockingQueue;

class JIAppThread extends Thread 
  {
// Gets 5 parameters from appcontrol . client string,dbcon,package,que,type of call
// if type =1  , it calls initfranch of the package else it separates the parameters
// for validate and calls the validate of the package. The thread exists after inserting
// the returned string into the que . 
//-----------------------------------------------------------------------------------------------------
     ArrayBlockingQueue<String> Que ;
     private Connection con = null;
     private int Typ=0;
     String Str , Prg ;

     public JIAppThread(String xStr, Connection xCon, String xPrg,
            ArrayBlockingQueue<String> xQue,int xTyp ) 
       {
         this.Str              = xStr;
         this.con              = xCon;
         this.Prg              = xPrg;
         this.Que              = xQue;  
         this.Typ              = xTyp;  
System.out.println("AppThread "+xStr + xTyp + xPrg);   
   }
 //-----------------run---------------------------------------------------------
   public  void run()
     { 
       int Ptr=0,RecNo;
       Str = Decompress(Str);
       String Func = "",Blk ,FldName,FldVal="" , Act,RC ;

       try 
          {
           if ( Typ < 2 ) {  // first time connection 
              // Full Client String is sent to the function. Splitting is done inside the function
              // to extract actual Client type , Token , Sequnce number. Other things can
              // also be added in future
              Func = ".InitFirst(?) }" ;
              FldVal = Ferry(1,Prg,Func, Str," ", 0," " , " ") ;
           }
           else if ( Str.equals("I") )  {
              Func =  ".Init() }" ;
              FldVal = Ferry(2,Prg,Func, " "," ", 0," " , " ") ;
           }
           else {
              Func = ".Validate(?,?,?,?,?) }";
              char cher = (char) 127; 

              while ( true ) {
                    Blk      = Str.substring(0,8).trim();
                    FldName  = Str.substring(8,16).trim();
                    RC    = Str.substring(16,21).trim();
                    RecNo    = Integer.parseInt(RC);
                    Act   = Str.substring(21,23).trim();
                    Ptr    = Str.indexOf(cher);

                    if  (Ptr<0) 
                         Ptr = Str.length();

                    FldVal= Str.substring(23,Ptr);
                    FldVal = Ferry(3,Prg,Func,Blk,FldName, RecNo,FldVal,Act) ;   

                    if ( FldVal.substring(0,2).equals("OE")) 
                          break;
 
                    if  ( Str.length()-Ptr < 8)
                           break;
                    else
                        Str = Str.substring(Ptr+1,Str.length());
                  } // while
              }  // else
        }  //try
        catch (Exception e) 
         {
           String Err="";         
           Err=String.format(Err).replace('\n','0');
           Str= "OE0"+String.format("%3s",Err.length()).replace(' ','0')+Err+"016From JIAppThread      OK";
       }          
                      
       Que.add(FldVal);
       return;
 }
//----------------------------------------Call PL SQL Proc----------------------------------   
   private String Ferry(int Typ,String Prg , String Func , String Blk ,String   FldName, int  RecNo, 
                      String  FldVal , String  Act) 
     { 

      String call = "{ ? = call "+ Prg + Func;
      try 
          {
           CallableStatement cstmt = con.prepareCall(call);                         
           cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.VARCHAR);

           if ( Typ == 1 )  
              cstmt.setString(2,Blk);
           else if ( Typ == 3 ) {
              cstmt.setString(2,Blk);     // Block (parent) of The item following
              cstmt.setString(3,FldName); // Item
              cstmt.setInt(4,RecNo);      // Record Number
              cstmt.setString(5,FldVal);  // Content of the Item 
              cstmt.setString(6,Act);     // Action ( Event) Code
           }
           cstmt.execute();
           call = cstmt.getString(1);  

           if  (call == null)
                 call= "OF";
         }
        catch (Exception e) 
         {
           String Err;
         
           if (e.getMessage()==null)
              Err="Could not call package "+Prg;
           else
              Err=e.getMessage().toString();
          
           Err=String.format(Err).replace('\n','0');
           Str= "OE0"+String.format("%3s",Err.length()).replace(' ','0')+Err+"016From JIAppThread      OK";
       }          
System.out.println("before back"+call);
       return call;
 }
// -------------------------- HEX To Ascii---------------------------------------
 private int Hex(char Ch ) {
    int ascii = (int) Ch; 
    if (ascii < 58 )
        ascii = ascii - 48;
    else
        ascii = ascii - 55;
    return ascii;  
 }
// ------------------------------ Decompress---------------------------------------
 private String Decompress(String Dec)  
  { 
    int k,l;
    String Str = Dec;
    while (true) {
       k = Str.indexOf("%");

       if ( k==-1)      
          break;

       l = Hex(Str.charAt(k+1))*16 + Hex(Str.charAt(k+2)); 
       Str = Str.substring(0,k) + Character.toString((char)l)+
                Str.substring(k+3,Str.length()); 
    }
    return Str;
 }
}
