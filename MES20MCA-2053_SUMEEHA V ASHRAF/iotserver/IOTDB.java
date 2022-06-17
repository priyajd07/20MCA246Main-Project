import java.sql.Connection;
import java.io.* ;
import java.net.*;
import java.sql.DriverManager;

public class IOTDB 
{
   public int udpport= 22222 , selfport = 6789 ;
   String mDb="" ,  mHost="" , mPort="" , mSid="" , mUser="" , mPassword="", mDebug="0";
 
   void ReadParm() {
      try
         {
          File file = new File("IOTServer.cfg");
 
          BufferedReader br = new BufferedReader(new FileReader(file));

          int len=0,mark=0;
          String line,lstr,rstr;  
                   
          while((line = br.readLine()) != null) 
            {
             len = line.length(); 
             mark = line.indexOf(':');

             if ( len > 0 && mark > 0 ) {
                lstr = line.substring(0,mark);
                rstr = line.substring(mark+1,len);
          
                if (lstr.equals("db"))
                   mDb = rstr;
                else if (lstr.equals("host")) 
                   mHost = rstr;
                else if (lstr.equals("port"))
                   mPort = rstr;
                else if (lstr.equals("sid"))
                   mSid = rstr;
                else if (lstr.equals("user"))
                   mUser = rstr;
                else if (lstr.equals("password"))
                   mPassword = rstr;
                else if (lstr.equals("selfport"))
                   selfport = Integer.parseInt(rstr);
                else if (lstr.equals("udpport"))
                   udpport = Integer.parseInt(rstr);
              }     
            }  
            br.close();            
      }
      catch(Exception e)
      {
        System.out.println("IOTServer.cfg File error ");
      }	
  }
//------------------------------------------------------------------------------   
  public Connection connection() 
   {
      Connection Cn;
      String tns = mHost+":"+mPort+":"+mSid;
                             
      try 
         {
   	   Class.forName("oracle.jdbc.driver.OracleDriver");
   	   Cn = DriverManager.getConnection("jdbc:"+mDb+":thin:@"+tns,mUser,mPassword);
	   return(Cn);
      }  
      catch (Exception e) 
      {
       String Err =e.getMessage().toString()  ;
       Err=String.format(Err).replace('\n','0');
       //Str= "OE0"+String.format("%3s",Err.length()).replace(' ','0')+Err+"013From JIAppCnt      OK";
       Cn = null;
       System.out.println(Err);
       return(Cn);
      }
 }
}
     