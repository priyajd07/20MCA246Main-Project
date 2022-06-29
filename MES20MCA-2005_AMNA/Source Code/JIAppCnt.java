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
  class JIAppCnt extends Thread 
    {
     private ArrayBlockingQueue<Socket> Que;  // queue for receving socket of requests from clients
     private ArrayBlockingQueue<String> Tstat; // Queue for receving results from AppThread
     private ArrayBlockingQueue<String> PrnStr; // Queue for receving print pages from Print Thread

     PrintWriter out = null;               // For sending Http commands 
     BufferedOutputStream Bfout = null ;   // For sending display data and files
     BufferedReader reqin = null;          // For reading client requests

     String SelfIP = "";
     int SelfPort = 0;

     Connection con = null;
     int MaxClt = 99, Inactivity_Minutes=100; // Maximum client index (0 based) , Inactivity time Allowed

     // JIRptThread Rpt;
     boolean PrintStarted = false;

     JIClntdat Clt[] = new JIClntdat[MaxClt+1];     // Array of Client data class . 
     int Active[] = new int [MaxClt+1], LastReg = -1 , Typ=0 , 
               LSeq=10000,StaSndPort,SeqLoc=0,Mqcap=10,Tqcap=5;
     
     private String Script,APrg,BPrg,CPrg,Db,Port,Host,Sid,User,Password,Delay,Tmp,Debug;

     public JIAppCnt(ArrayBlockingQueue<Socket> xQue,String xDb, String xHost,String xPort,
            String xSid,String xUser,String xPassword, String xAPrg,String xBPrg,String xCPrg,
            int xStaSndPort,String xDebug,int Sprt) 
       {
         this.Que              = xQue  ;
         this.Db               = xDb;
         this.Host             = xHost;
         this.Port             = xPort;
         this.Sid              = xSid;
         this.User             = xUser;
         this.Password         = xPassword;
         this.APrg             = xAPrg;
         this.BPrg             = xBPrg;
         this.CPrg             = xCPrg;
         this.StaSndPort       = xStaSndPort; 
         this.Debug            = xDebug;
         this.SelfPort          = Sprt;
      System.out.println("Appcontrol is ON ");
       }
//-----------------run---------------------------------------------------------
//  This will be running always till it is stopped manually.
//  Constructor :
//    1. accepts a queue id and databse connection details from main as parameters.
//  RUN 
//    Reads the scriptfile named JIClient.JSC and stores in the string Script.
//    Main sends a socket , each time it accepts a server socket connection, through a queue.
//    After creating a connection and streams,a line is read.Then test is done to determine
//    whether this is the first call from a client by comparing the string following GET command.
//    If it is a first call, the received string will contain clientype ( 1Char) followed by
//    a token. An instance of a client data class is created. Clienttype stored. If client type is 
//    B ( browser ) , Content of script is send to the client after embedding a sequnce number through
//    a variable in javascript. Returning calls will beging with the sequnce number. 
//    In the second call The line will conatin only the seq number. 
//    If it is the second call,then a connection is created to the database which will be stored.

 
//    If it is not a browser , In each returning call an appthread
//    class is instatiated by passing 4 parameters string from client,output stream to
//    client,connection to database,package name,Que for receiving information back to
//    this thread. The string passed to the appthread in the second call will be the 
//    string recieved in the first call. Appthread calls the package.procedure in database
//    and returns the result to the client.further detials are written in APP THREAD. 
//     
//    =============================Printing=========================================
//    Process_Return checks for print commands. If detected PrintStarted flag is set 
//    to true and creates a thread JIHRpt and an instance of Print data class. This is 
//    needed to make the data persistant between subsequent instatiation of this thread.
//    if balance data of print is continuously processed from one call to this thread,
//    showing the first page on the brwser will be delayed. 
//    if printing is creating load on the server side, screen display can be moved to
//    JS and writing to file can be at the backend.Again printing has to be resolved 

   public  void run()
     { 
       // Create timer and schedule it to run at 1 Minute interval
       Timer Watch = new Timer(); 
       TimerTask Dog = new WatchDog();           
       Watch.schedule(Dog, 10000 , 60000);

       //Mark all clients inactive
       for ( int ii=0 ; ii <= MaxClt; ii++) {
           Active[ii] = 0;
       }                       
       // Server IP and Port should follow the Sequence number 
       // It is not in the stored file since inadvertantly adding a space or a line
       // will create problem. So after sequence number both variables are added
       // with line feeds
       Script = Load_Script();
       SeqLoc = Script.indexOf("10000000");
 
       try {
           InetAddress Ina = InetAddress.getLocalHost(); 
           SelfIP=Ina.getHostAddress(); 
       }
       catch ( Exception e) {}

       Socket Soc;
       String ClStr="",RetStr="";
       System.out.println("Control-->Looping to read queue");

       while ( true ) { 
          try 
           {            
              try {
                 ClStr = "*";
                 RetStr = "*";
                 boolean LogOut;

                 for ( int ii=0 ; ii <= LastReg; ii++) {
                    if ( Active[ii]==1) {
                        while ( Clt[ii].QueStatus.remainingCapacity() < Tqcap ) {
                           RetStr = Clt[ii].QueStatus.take();
System.out.println("from app que"+RetStr);
                          //return boolean is added to differentiate between OQ 
                          // and others. after OQ it should quit, otherwise, queue
                          // checking gives null pointer error on QueStatus
                          LogOut = Process_Return(RetStr,ii);

                          if (LogOut)
                             break;
                        }
                    }                     
                 }                       
 
                 if ( Que.remainingCapacity() < Mqcap ) {
                    System.out.println("Control-->Reading que");
                    Soc = Que.take();
                    System.out.println("Control-->To Process Request");
                    LogOut = Process_Request(Soc);
                    System.out.println("Control-->Going to read que");
                 }                  
              }
              catch (Exception e) {
                 StringWriter sw = new StringWriter();
                 e.printStackTrace(new PrintWriter(sw));
                 String exceptionAsString = sw.toString();
                 System.out.println(exceptionAsString);  
              }
           }  // upper try
         catch ( Exception e)  {
            System.out.println("Error in Outer Try");   
         }
      }  // while
    } // run 
  //-------------------------------------------------------------------------------------
  private boolean Process_Request (Socket Soc) {      
      String Str = null;
      int Subs=0;
      boolean Lgout = false,Err=false;

      System.out.println("Control-->Received a socket"+Soc.getInetAddress().toString());

      try {       
         Bfout   = new BufferedOutputStream(Soc.getOutputStream());
         reqin   = new BufferedReader(new InputStreamReader(Soc.getInputStream()));
         out     = new PrintWriter(Soc.getOutputStream());
       }
      catch ( Exception e) {
      }

      Str = Read_Clt(reqin);                    
      Str = Get_Get(Str);

      if (Str.equals("*") ) {  
         Send_To_Client("B","",Bfout,out);
         Close_All(Soc);
         Err = true;
      }            

      if (!Err) { // Continue 1
         if ( "0123456789".indexOf(Str.substring(0,1)) < 0 )  {    // new client     
            if ( "ABC".indexOf(Str.substring(0,1)) < 0 ) {
               System.out.println("Unidentified Client Type");
               Send_To_Client("B","",Bfout,out);
               Close_All(Soc);
               Err = true;
            }  

            Subs = Vacant_Client();                

            if ( Subs == -1 ) {
               System.out.println("No client vacancy");
               Send_To_Client("B","",Bfout,out);
               Close_All(Soc);
               Err = true;
            }  

            if (!Err) {
               // Continue 2 
               // All client connection requests should start with ClientType followed by a client token                       
               // This will be padded with space to make it 10 ( 1+9). If it is more than 10, it should
               // be cut to make it 10. After this , Sequence number should added before sending to AppThread

               Clt[Subs] = new JIClntdat();
               Clt[Subs].OCFlag = "N";
               Clt[Subs].CltType = Str.substring(0,1); // This is needed till end of session 
               Clt[Subs].CurPrg = 0;
               String Tns  =Host+":"+Port+":"+Sid;
               con = connection( Db,Tns ,User ,Password);       
               Clt[Subs].con = con;
               Clt[Subs].USR = User;
               Clt[Subs].PWD = Password;
               Clt[Subs].DBIP = Host;
               Clt[Subs].DBPORT = Port;
               Clt[Subs].Soc = Soc;
               LSeq++;  // increment for next;
               // first 5 digits is for client, which is incremented on first 
               // connection from client. Next 3 digit is for the slot allocated
               // to the client. Eg: after 3rd client logs in, the seq is 10003
               // and number sent is 10003003.    
               // if second person logs out and a new client comes in, the seq will
               // 10004 and slot will be 2. so the number sent is 10004002.
               Clt[Subs].SEQ = Integer.toString(LSeq*1000+Subs);

               if  (Str.length() > 10)
                   Str = Str.substring(0,10) + Clt[Subs].SEQ;
               else
                   Str = String.format("%1$-10s",Str) + Clt[Subs].SEQ;
                                                                      // received string padded to 9 plus Seq 
                                                                      // is temporarily stored here.
               Clt[Subs].Future[0] = Str;
               Clt[Subs].IP = Soc.getInetAddress().toString();
               Clt[Subs].PORT =  Integer.toString(Soc.getPort());
               System.out.println("Control-->db connection tns : "+Db+" , "+Tns +" , "+User +" , "+Password);
               System.out.println("Control-->IP Address of Client:" + 
                    Clt[Subs].IP + " Port: " + Clt[Subs].PORT);
               Tstat = new ArrayBlockingQueue<String>(Tqcap); 
               Clt[Subs].QueStatus =  Tstat;
                           
               System.out.println("Client Type-->"+Clt[Subs].CltType + "  Token-->" + Str.substring(1,10));

               // Android (A), Browser (B), Client (C);

               Clt[Subs].InactivityAllowed = Inactivity_Minutes;
               Clt[Subs].Inactivity = 0;

               if (Clt[Subs].CltType.equals("B")) {   // Browser connection              
                  //Only the first script is sent from here with out spawning app thread.
                  String Jvc = Script.substring(0,SeqLoc) + Clt[Subs].SEQ+ 
                            "\"; Sport = "+ Integer.toString(SelfPort) + 
                            "; Shost = "+ "\""+ SelfIP  + 
                            Script.substring(SeqLoc+8,Script.length());
                            // "; of SEQ is there . so no need of both after SelfIP
                  Clt[Subs].PrgArr[0] = BPrg;
                  Send_To_Client("B",Jvc,Bfout,out);
                  Close_All(Soc);
                }
               else {    
                  if (Clt[Subs].CltType.equals("A")) 
                     Clt[Subs].PrgArr[0] = APrg;
                  else  
                     Clt[Subs].PrgArr[0] = CPrg;
System.out.println("First program " +Clt[Subs].PrgArr[0]);
            
                  Send_To_Client(Clt[Subs].CltType,Clt[Subs].SEQ,Bfout,out);
                  //new JIAppThread(Clt[Subs].Future[0],con,Clt[Subs].GetProg(),Tstat,0).start();
                  Close_All(Soc);
               }
            }  // IF Continue 2
         }   // New client         
         else {  // returning
            Typ = 2;
            Subs = -1;
            Str = Str.trim();
             
            Subs = Integer.parseInt(Str.substring(5,8));
            String Sq = "";
            boolean UnKnown;

            try {
                Sq = Clt[Subs].SEQ;
                UnKnown = !(Sq.equals(Str.substring(0,8))) ;                              
            }
            catch (Exception e) {
                UnKnown = true;
            }

            if ( UnKnown || Active[Subs]==0 )   {         
               JIDenied Jid = new JIDenied();
               String Ms = Jid.Denied();
               Send_To_Client ("C",Ms,Bfout,out); // C get preference. if browser let it hang 
            }
            else if ( Clt[Subs].Inactivity > Clt[Subs].InactivityAllowed) {
               // OE Button cnt length of mess in 3d message length of caption title in 3d caption title
               Send_and_Close(Subs,"OE0018Inactivity Timeout011Logging Out      OK",true);
               LogOut(Subs);
               Lgout = true;
            }
            else {    // Continue 2
               System.out.println("Iteration Str<--->Clt["+ Subs +"] "  + Str+ 
                                                        "<--->" + Clt[Subs].SEQ );
               String Valid;
               Clt[Subs].Inactivity = 0;

               if ( Str.length() == 8 )  {
                     Clt[Subs].CurPrg = 0;
                     Typ    = 1;
                     Valid  = Clt[Subs].Future[0];  // Saved client Type + token + Seqno
                     // since this is needed only in second call(Typ=1)
                     // and Future is used only after the return from Second call 
                     // it is temporarily stored here to avoid creating another variable
               }
               else {   
                   Clt[Subs].CurPrg = Integer.parseInt( Str.substring(8,11) );
                   Valid    = Str.substring(11,Str.length()) ;
               }

               //Server Only Actions
               if  ( Valid.equals("LOGOUT%3C%3C")) {
                      Close_All(Soc) ;
                      LogOut(Subs);
                      Lgout = true;
                }
               else if  ( Valid.substring(0,1).equals("?") ) 
                      Lgout = Server_Action(Subs,Valid,true);
               else {                  
                  Clt[Subs].Soc = Soc;
                  con = Clt[Subs].con;

                   new JIAppThread(Valid,con,
                   Clt[Subs].GetProg(),Clt[Subs].QueStatus,Typ).start();
               } 
            } // else of continue 2
          } //returning
       } // Continue 1
       return Lgout;
    } // pfunction    
 /* ------------------------------  Process_Return ------------------------------*/  
  private boolean Process_Return(String RetStr,int Ptr) 
  {
     String Snd = RetStr;
     boolean Lgout = false;
     
     //OZ1OE0
     //81 = Drill down button ( field value will be line data ) 
     //82 = Ready for next data  ( if Token is -1 , stop print process and close  cursor)
     //85 = Call Back

     Clt[Ptr].Inactivity = 0;

     while ( true ) { 
        if  (Snd.substring(0,2).equals("OC") ) {  // this should be last command 
             int k = Snd.indexOf("@!");

             if ( k > 0 )
                Snd = Snd.substring(0,k-1);

             Snd = Snd.substring(2,Snd.length());

             if ( Clt[Ptr].PrgAdd(Snd) > -1)  // PrgAdd allocates new program No 
              {
                Tstat = Clt[Ptr].QueStatus;
                con = Clt[Ptr].con;
                Clt[Ptr].OCFlag = "Y";
                new JIAppThread("I",con,Snd,Tstat,2).start(); 
                // I Franchcode in case we need franch code. frachncode followed by f
                // will be used to to check only. in both case procdure will be init
                // If an error occurs in init, Frame command will not be received, instead
                // Error command is received. So set OCflag in Clt class. This is
                // not required in OL since the program number will be 0 

                break;
             }         
             else
                Snd = "OE0018Wrong Program Name004Call      OK";
        }
        if (Snd.substring(0,2).equals("OL")) {   
           // OL can effect only before sending any program details
           // separated parameters
           String Ostr[] = new String[8];
           int k ;
           Snd = Snd.substring(2,Snd.length());

           for ( int ii=0 ; ii< 8 ; ii++) {
              k = Snd.indexOf(",");
              if ( k > -1) {
                 Ostr[ii] = Snd.substring(0,k);
                 Snd      = Snd.substring(k+1,Snd.length());
              }
           }

           Db     =   Ostr[3];
           Host   =   Ostr[4];
           Port   =   Ostr[5];
           Sid    =   Ostr[6];
           Delay  =   Ostr[7];

           try {
              Clt[Ptr].con.close();
           }
           catch (SQLException e) 
           {
              int i=0;
           }   

           String Tns  =Host+":"+Port+":"+Sid;
           Clt[Ptr].con = connection( Db,Tns ,Ostr[1],Ostr[2]);
              
           Clt[Ptr].CurPrg = 0;
           Clt[Ptr].PrgArr[0] = Ostr[0];
                  
           new JIAppThread("I",Clt[Ptr].con,Ostr[0],Tstat,2).start(); 
           break;
        }

        if (Snd.substring(0,2).equals("OB")) { 
           int k ;
           Snd = Snd.substring(2,Snd.length()-1);
           // Squash Syndrome!!!! . OB is followed by block and Item Separated By comma.
           // Take off comma and padd both to length 8
  
           k = Snd.indexOf(",");

           Snd = String.format("%1$-8s",Snd.substring(0,k)) +
                 String.format("%1$-8s",Snd.substring(k+1,Snd.length()))+
                 "0000000  "; // Zeroes and spaces are added to avoid index of range error in APP

           String Pg = Clt[Ptr].GetProg();
           new JIAppThread(Snd , Clt[Ptr].con, Pg, Tstat,2).start(); 
           break;
        }
        else if ( Snd.substring(0,2).equals("OJ") || Snd.equals("OQ")  || 
                    Snd.substring(0,2).equals("OR")) {
           Clt[Ptr].SetProg("*");

           if  (Snd.substring(0,2).equals("OJ"))
               Snd = "OF"; 
System.out.println("exit check: "+Snd);
        }  
        else if ( Snd.length()>= 7) {
           if  (Snd.substring(0,3).equals("OOI")) {
              Clt[Ptr].InactivityAllowed = Integer.parseInt(Snd.substring(3,7));

              // This should be the first command.Following commands will be analysed in loop
              // If the programmer sends this alone by mistake, just send OF;

              if (Snd.length() > 7) {
                 Snd = Snd.substring(7,Snd.length());
                 continue;
               }
              else
                 Snd = "OF";
           }
        }  

        if  ( Clt[Ptr].OCFlag.equals("Y") ) {
               Clt[Ptr].OCFlag="N";
               if (  !Snd.substring(0,3).equals("DF "))
                   Clt[Ptr].CurPrg = 0; 
        }        

        Send_and_Close(Ptr,Snd,true);

        if ( Snd.equals("OQ")) {
           LogOut(Ptr);
           Lgout = true;
        }
        break;
     } 
     return Lgout;
 }                          
 /* ------------------------------  Action only from Cnt ------------------------------*/  
  private boolean Server_Action(int Cid,String Cmd,boolean Cls)
 {
      if  ( Cmd.equals("??") ) 
             Send_and_Close(Cid,Cmd,true);
      else if  ( Cmd.equals("??DNLOAD" )) 
             Send_File(Cid,Cmd,true);
      else if  ( Cmd.equals("??UPLOAD" )) 
             Save_File(Cid,Cmd,true);
      else if  ( Cmd.equals("??LOGOUT"))
             LogOut(Cid);
      else if  ( Cmd.equals("??ACTIVE") )
             Send_and_Close(Cid,"OF",true);

      return false;
 }
 /* ------------------------------  Send_To_Client ------------------------------*/ 
  private void Send_and_Close(int Ptr,String Snd,boolean Cl)   
  {
        Socket S = Clt[Ptr].Soc;
        String C = "000"+Integer.toString(Clt[Ptr].CurPrg); 
        String ToSnd="OA"+C.substring(C.length()-3,C.length())+Snd;
System.out.println(ToSnd); 
        try {       
           BufferedOutputStream Bout = new BufferedOutputStream(S.getOutputStream());
           PrintWriter Pout          = new PrintWriter(S.getOutputStream());
           Send_To_Client (Clt[Ptr].CltType,ToSnd,Bout,Pout);  
        }
        catch ( Exception e) {
           System.out.println(e+"Error in creating streams for sending ");
        }   

        if (Cl)
           Close_All(S);       
  }
 /* ------------------------------  Send_To_Client ------------------------------*/ 
  private void Send_To_Client(String CltType ,String Snd,BufferedOutputStream ackout,PrintWriter out)   
   {
    byte[] Bbuff = new byte[(int) Snd.length()*2+6]; 
 
    try {
       Bbuff = Snd.getBytes(Charset.forName("UTF-8"));
       int cnt = Bbuff.length;
       
       if (CltType.equals("B") ) {   
          if (Snd=="??")  {         
              out.println("HTTP/1.1 204 OK");
              out.println("Access-Control-Allow-Origin: http://127.0.0.1:6666");
              out.println("Access-Control-Allow-Methods: GET, POST, PUT");
          }
          else
               out.println("HTTP/1.1 200 OK");

          out.println("Server: JIHttp Server");
          out.println("HTTP/1.1 Connection: close");
          out.println("Date: " + new Date());
          out.println("Content-Type: text/html; charset=UTF-8");
          out.println("Content-Length: " + Integer.toString(cnt));
          out.println(); // blank line between headers and content, very important !
          out.flush(); // flush  output stream buffer
       }

       if ( !(Snd=="??") ) {
          ackout.write(Bbuff , 0, cnt );
          ackout.flush();     
          System.out.println("Sent To Clt "+Snd);
       }

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
//---------------------------------Flush Rest of client message------------------------- 
  private void Flush_Incoming (BufferedReader reqin) {
     String Urinal="";
     int k = 0;
	
     while (true) {
        try {
             //if (reqin.ready()) {
           Urinal = reqin.readLine();
           if (Urinal.length()==0) 
              break;
           //System.out.println("FLUSH-->"+Urinal);              
        }    
        catch (IOException e) 
         {
           String Err =e.getMessage().toString();
           System.out.println("Flush-->" + Err);       
         }
     }
     System.out.println("FLUSH-->"+Urinal);              
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
//---------------------------------Get The String between Get and HTTP------------------------- 
  private  String Get_Get ( String got) 
  {
      int s = -1 , e = -1 ;
      String Cut;
      
      s  = got.indexOf("GET");
      
      if ( s >= 0 ) {
         e   = got.indexOf("HTTP");
         Cut = got.substring(s+5 , e); 
         Flush_Incoming(reqin);
      }
      else   
         Cut = got;

      if (Cut.equals("favicon.ico ") )
         Cut = "*";
         
      System.out.println("GET CLEAN------> "+"*"+Cut+"*");
      return Cut;            
  }   
//------------------------------------------------------------------------------   
  private Connection connection(String db,String tns ,String user ,String password ) 
   {
      Connection Cn;

      try 
   	  {
   	   Class.forName("oracle.jdbc.driver.OracleDriver");
   	   Cn = DriverManager.getConnection("jdbc:"+db+":thin:@"+tns,user,password);
	   return(Cn);
      }  
      catch (Exception e) 
      {
       String Err =e.getMessage().toString()  + db+tns+user+password;
       Err=String.format(Err).replace('\n','0');
       //Str= "OE0"+String.format("%3s",Err.length()).replace(' ','0')+Err+"013From JIAppCnt      OK";
       Cn = null;
       System.out.println(Err);
       return(Cn);
      }
   }
/* ------------------------------  Load Script ------------------------------*/ 
  private String Load_Script () {
       String Lines , Tot , LinTot ="" ;
       File file   =     null; 
       BufferedReader Br=null;            
       int  Ln = 0;

       try 
         {
           file = new File("JIClient.JSC"); 
           Br = new BufferedReader(new FileReader(file));
         }
       catch (Exception e ) 
         {
          System.out.println("File opening error ");
          }
              
       while(true) {
          try  { 
             Lines = Br.readLine() ;

             if (Lines == null )  
                 break;
             LinTot = LinTot + Lines + "\r\n";

          }
          catch (IOException e ) 
          {
               System.out.println("SP Creation Error "+e);
          } 
       }
       
       return LinTot;
   }
//----------------------------------------------------------------------------   
  private void Close_All(Socket Sc) {
      try {       
         Sc.close();
         System.out.println("Socket closed");
      }
      catch ( Exception e) {
      }
  }
//----------------------------------- Send file  -----------   
  private void Send_File(int Ptr,String Snd,boolean Cl)   
 {
      Send_and_Close(Ptr,"Content_with_file_protocolofprnsrv",Cl)  ; 
 }
//----------------------------------- Send file  -----------   
  private void Save_File(int Ptr,String Snd,boolean Cl)   
 {
      //Write File  from SND 
      Send_and_Close(Ptr,"OF",Cl)  ; 
 }
 /* ------------------------------  Vacant_Client ------------------------------*/
  private int  Vacant_Client()  {
      int Nxt = -1;
      if (LastReg < MaxClt) {
          Nxt = ++LastReg;
          Active[Nxt] = 1;
      }
      else {
         for ( int ii=0 ; ii <= LastReg; ii++) {
            if ( Active[ii]==0) {
               Nxt = ii;
               Active[Nxt] = 1;
               break;
            }                     
         }                       
      }  
      return Nxt;
}     
 /* ------------------------------  LogOut ------------------------------*/
  private void  LogOut(int Ind)  {
    System.out.println("Client is Logging Out");     
    try {
       Clt[Ind].con.close();
       Clt[Ind].QueStatus = null;
       // release client     
       Active[Ind] = 0;
       Clt[Ind] = null;
    }    
    catch (SQLException e) 
    {
      int i=0;
    }   
    System.out.println("Client " + Ind + " Logged Out");
  }
 /*-------------------------- Class for thread executing on timer elapse ---------------------
   ----------------------------- Increments Inactivity of all clients ----------------------*/
  class WatchDog extends TimerTask 
  { 
    public void run() 
    {         
        for ( int ii=0; ii <= MaxClt; ii++) {
           if ( Active[ii] == 1) 
              Clt[ii].Inactivity++;     
        }
    } 
  }  
} // Top
 