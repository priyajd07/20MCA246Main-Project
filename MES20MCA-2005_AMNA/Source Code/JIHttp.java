import java.io.* ;
import java.net.*;
import java.*;
import java.util.concurrent.ArrayBlockingQueue;

public class JIHttp
  {
   public static void main(String args[]) throws Exception   
    {    
      int mStaSndPort=0 , SelfPort = 6789 ;
      String mDb="" ,  mHost="" , mPort="" , mSid="" , mUser="" , mPassword="",
             APrg="",BPrg="",CPrg="", mDebug="0";

      System.out.println("Command line arguments--> user password Program ListenPort");

      try
         {
          File file = new File("JIHttp.cfg");
 
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
                else if (lstr.equals("APrg"))
                   APrg = rstr;
                else if (lstr.equals("BPrg"))
                   BPrg   = rstr;
                else if (lstr.equals("CPrg"))
                   CPrg = rstr;
                else if (lstr.equals("selfport"))
                   SelfPort = Integer.parseInt(rstr);
                else if (lstr.equals("staport"))
                   mStaSndPort = Integer.parseInt(rstr);
              }     
            }  
            br.close();            
      }
      catch(Exception e)
      {
        System.out.println("JItecMw.cfg File error ");
      }	
                  
      if (args.length > 0 ) {   
         String Chn="Overridden ";
         for(int i=0;i<args.length;i++) { 
            if (i==0) {
               mDebug = args[i];
               Chn = Chn + " Debug->"+mDebug;
            }
            if (i==1) {
               mUser = args[i];
               Chn = Chn + " User->"+mUser;
            }
            if (i==2) {
               mPassword = args[i];
               Chn = Chn + " Pwd->"+mPassword;
            } 
            if (i==3) {
               APrg = args[i];
               Chn = Chn + " Android_Prog->"+APrg;
            } 
            if (i==4) {
               BPrg = args[i];
               Chn = Chn + " Browser_Prog->"+BPrg;
            } 
            if (i==5) {
               CPrg = args[i];
               Chn = Chn + " Client_Prog->"+CPrg;
            } 
            if (i==6) {
               SelfPort = Integer.parseInt(args[i]);
               Chn = Chn + " Listening Port->"+SelfPort;
            } 
         } 
         System.out.println(Chn);     
      }    
         
      System.out.println("JItecMw Listening on port "+ Integer.toString(SelfPort));
      ServerSocket welcomeSocket = new ServerSocket(SelfPort);
      Socket ClientSocket;
      
      ArrayBlockingQueue<Socket> SendSoc = new ArrayBlockingQueue<Socket>(10);
      new JIAppCnt(SendSoc,mDb,mHost,mPort,mSid,mUser,mPassword,APrg,BPrg,CPrg,mStaSndPort,mDebug,SelfPort).start();
      
      while(true) 
      {
         try
	    {
              ClientSocket = welcomeSocket.accept();
System.out.println("Main--> Received a socket"+ClientSocket.getInetAddress().toString()  );
              SendSoc.put(ClientSocket);
System.out.println("Main--> socket inserted in que");
	 }
	 catch ( Exception e) { System.out.println("Error In accepting connection from client"); }  
      }
   }
}
