import java.io.*;
import java.net.*;
import java.util.Date;
import java.util.Vector;
import java.text.*;
import java.util.Properties;
import java.sql.Connection;
import javax.swing.*;
//import java.awt.*;  

class  IOTMenu
  {
   IOTAwt Faw;
   IOTDB Fdb;
   Connection con;

   int Debug=0 , LastKey=0;
   JFrame MainFrm;
   String KeyStr,Stat="N";

   int Login()  {
        Fdb = new IOTDB();        
        Fdb.ReadParm();
        con = Fdb.connection();
        Faw=  new IOTAwt(con);
          
        JFrame LogFrm = Faw.Create_Frame("IOT Table Maintenance Login", 0,0,1000,600) ; 
        JPanel LogPan = Faw.Create_panel("SELECTIONS", 0,0,1000,600,LogFrm) ; 
        JPasswordField PASSWORD = Faw.Create_PassField("PASSWORD", 150,125,100,25,LogPan); 
        JTextField USERID = Faw.Create_TextField("USERID", 150,100,100,25,LogPan); 
        JTextField Message    = Faw.Create_TextField("MESSAGE", 150,175,600,25,LogPan); 
        JButton LOGIN = Faw.Create_Button("Login",150,250,100,25,LogPan);
        JButton EXIT = Faw.Create_Button("Exit",260,250,100,25,LogPan);         

        LogFrm.revalidate();
        LogFrm.repaint();
     
     String Msg ="OK";
     int Tb =0 , Rslt=0;

     String[] Dt;
     Dt = new String[3]; 
     Dt[0] = "S";
     Dt[1] = "S";
     Dt[2] = "S";

     String DATA[] = new String[3];
     USERID.grabFocus(); 
     int Go = 0;

     while ( true )  
     {                   
       KeyStr = Get_Input() ;
       try {
       if (KeyStr.substring(1,7).equals("USERID"))
       {
           if  ( LastKey == 10 )
                PASSWORD.grabFocus();  
       }  
       else if (KeyStr.substring(1,9).equals("PASSWORD"))  {
           if  ( LastKey == 10 )
                LOGIN.grabFocus();  
         }
        else if (KeyStr.substring(1,6).equals("Login")) 
         {
           DATA[0] = USERID.getText();
           DATA[1] = String.valueOf(PASSWORD.getPassword());
           Msg = "LOGIN(?,?,?) }";  
           Msg = Faw.Get(Msg, DATA,Dt, 3,2) ; 
           Message.setText(Msg);
           Stat = DATA[2];

           if ( ! (Msg.substring(0,3).equals("***") ) )
                 Go=1;
        }
       else if (KeyStr.substring(1,5).equals("Exit"))     
          break;
          
       if ( Go==1) 
           break;

       Faw.IndStr = "*";    
       }
       catch(Exception e) {}    
     } 

     LogFrm.dispose();

     if (Go==1)
        Go = MenuButs();     

      Faw  = null;
      Fdb   = null;
      return 0;
  }

   int MenuButs()  {          
        MainFrm = Faw.Create_Frame("IOT Table Maintenance", 0,0,1000,600) ; 
        JPanel MainPan = Faw.Create_panel("SELECTIONS", 0,0,1000,600,MainFrm) ; 
        JButton AGGBUT = Faw.Create_Button ("AGGREGATE",   300, 200, 100 , 25 , MainPan);
        JButton ASSBUT  = Faw.Create_Button ("ASSIGNED" ,     450, 200, 100 , 25 , MainPan);
        JButton DATBUT = Faw.Create_Button ("DATACODE",    600, 200, 100 , 25 , MainPan);
        JButton CLIBUT  = Faw.Create_Button ("CLIENTS", 375, 250, 100 , 25 , MainPan);
        JButton FIEBUT  = Faw.Create_Button ("FIELDS",    525, 250, 100 , 25 , MainPan);
        JButton USEBUT = null ;
        JButton EXIBUT = Faw.Create_Button ("EXIT",     525, 300, 100 , 25 , MainPan);

        if ( Stat.equals("A"))
            USEBUT  = Faw.Create_Button ("USER",    375, 300, 100 , 25 , MainPan);


        MainFrm.revalidate();
        MainFrm.repaint();

        while ( true )  {
             KeyStr = Get_Input() ;

             try {
                 if (KeyStr.substring(1,10).equals("AGGREGATE")) 
                     AGGREGATE();
                 else if (KeyStr.substring(1,9).equals("ASSIGNED"))     
                     ASSIGNED();
                 else if (KeyStr.substring(1,9).equals("DATACODE"))     
                     DATACODE();
                 else if (KeyStr.substring(1,8).equals("CLIENTS"))     
                     CLIENTS();
                 else if (KeyStr.substring(1,7).equals("FIELDS"))     
                     FIELDS();
                 else if (KeyStr.substring(1,5).equals("USER"))
                     USER();
                 else if (KeyStr.substring(1,5).equals("EXIT"))     
                     break;          
             }
             catch(Exception e) {}    
        }
     
         MainFrm.dispose();
         return 0;
   }

   void ASSIGNED()
   {    	   
     JFrame ASSINEDFrm = Faw.Create_Frame("ASSINED Table Maintenance", 0,0,1000,600) ; 
     JPanel ASSINEDPan = Faw.Create_panel("Add/Change/Update", 0,0,1000,600,ASSINEDFrm) ;
 
     JTextField CLNCOD = Faw.Create_TextField("CLNCOD", 150,100,100,25,ASSINEDPan); 
     JTextField DATCOD = Faw.Create_TextField("DATCOD", 150,125,100,25,ASSINEDPan); 
     JTextField ASSAGG = Faw.Create_TextField("ASSAGG", 150,150,300,25,ASSINEDPan); 
     JTextField Message    = Faw.Create_TextField("MESSAGE", 150,175,600,25,ASSINEDPan); 

     JButton Save = Faw.Create_Button("SAVE",150,250,100,25,ASSINEDPan);
     JButton Exit = Faw.Create_Button("EXIT",260,250,100,25,ASSINEDPan);         
       
     //Hide the main frame show ASSINED frame 
     Faw.SwitchFrames(MainFrm , ASSINEDFrm);     

     ASSINEDFrm.revalidate();
     ASSINEDFrm.repaint();

     String Msg ="OK";
     int Tb =0 , Rslt=0;

     String[] Dt;
     Dt = new String[3]; 
     Dt[0] = "S";
     Dt[1] = "S";
     Dt[2] = "S";

     String CLNASS[] = new String[3];
     CLNCOD.grabFocus(); 

     while ( true )  
     {                   
       KeyStr = Get_Input() ;
       try {
       if (KeyStr.substring(1,7).equals("CLNCOD"))
       {
           String Cl = CLNCOD.getText();
           CLNASS[0] = Cl;
           Msg = "GET_EDGCLN (?,?) }"; 
           Msg = Faw.Get(Msg, CLNASS,Dt, 2,1);  
                  
           if ( ! (Msg.equals("OK") ) )
                  Message.setText(Msg);
           else {
                  DATCOD.grabFocus();  
                  Message.setText(CLNASS[1]);
            }    
           CLNASS[0] = Cl;  
           CLNASS[1]="";
       }  
       else if (KeyStr.substring(1,7).equals("DATCOD"))  {
           String Ky = CLNASS[0];
           String DC = DATCOD.getText();
           CLNASS[0] = DC;

           Msg = "GET_DATCODE(?,?,?) }";  
           Msg = Faw.Get(Msg, CLNASS,Dt, 3,1) ; 

           if ( ! (Msg.equals("OK") ) ) {
                 Message.setText("Wrong data code");
                 CLNASS[0] = Ky;
                 CLNASS[1] = DC;
            }
           else {
                 Message.setText(CLNASS[1] );

                 CLNASS[0] = Ky;
                 CLNASS[1] = DC;

                 Msg = "GET_CLNASS(?,?,?) }";  
                 Msg = Faw.Get(Msg, CLNASS,Dt, 3,2) ; 
                 ASSAGG.setText(CLNASS[2]);         	  

                 if ( ! (Msg.equals("OK") ) )
                     Message.setText("New entry");
                else
                     Message.setText("Change");
           
                if  ( LastKey == 10 )
                    ASSAGG.grabFocus();
             }  
         }
       else if (KeyStr.substring(1,7).equals("ASSAGG"))  {
           String Ky = CLNASS[0];
           String Da = CLNASS[1];

           CLNASS[0] = ASSAGG.getText();

           Msg = "GET_AGGREG(?,?) }";  
           Msg = Faw.Get(Msg, CLNASS,Dt, 2,1) ; 

           if ( ! (Msg.equals("OK") ) )
                 Message.setText("Wrong aggregate code");
           else {
                 Message.setText(CLNASS[1] );
                  if  ( LastKey == 10 )
                       Save.grabFocus();
            }  
           CLNASS[0] = Ky;
           CLNASS[1] = Da ;
           CLNASS[2] = ASSAGG.getText();
         }
        else if (KeyStr.substring(1,5).equals("SAVE")) 
         {
           Msg = "WRITE_CLNASS(?,?,?) }";  
           Msg = Faw.Put(Msg, CLNASS,Dt, 3) ; 

           if ( ! (Msg.equals("OK") ) )
                 Message.setText(Msg);  
          else {
               Message.setText("Updated");  
               CLNCOD.setText("");
               DATCOD.setText("");
               ASSAGG.setText("");
               CLNASS[0]="";
               CLNASS[1]="";
               CLNASS[2]="";
               CLNCOD.grabFocus(); 
           }
        }
       else if (KeyStr.substring(1,5).equals("EXIT"))     
          break;
          
       Faw.IndStr = "*";    
       }
       catch(Exception e) {}    
     } 

     Faw.SwitchFrames(ASSINEDFrm,MainFrm);     

     ASSINEDFrm.dispose();
  }
//--------------------------------------AGGREGATE---------------------------------------------------------
  void AGGREGATE() 
   {   	
     JFrame AggFrm = Faw.Create_Frame("Aggregation Table Maintenance", 0,0,1000,600) ; 
     JPanel AGGREGATEPan = Faw.Create_panel("Add/Change/Update", 0,0,1000,600,AggFrm) ;
 
     JTextField CODE = Faw.Create_TextField("CODE", 150,100,100,25,AGGREGATEPan); 
     JTextField NAME = Faw.Create_TextField("NAME", 150,125,300,25,AGGREGATEPan); 
     JTextField Message    = Faw.Create_TextField("Message", 150,150,600,25,AGGREGATEPan); 

     JButton Save = Faw.Create_Button("SAVE",150,200,100,25,AGGREGATEPan);
     JButton Exit = Faw.Create_Button("EXIT",260,200,100,25,AGGREGATEPan);         
       
     //Hide the main frame show AGGREGATE frame 
     Faw.SwitchFrames(MainFrm , AggFrm);     

     AggFrm.revalidate();
     AggFrm.repaint();

     String Msg ="OK";
     int Tb =0 , Rslt=0;

     String[] Dt;
     Dt = new String[2]; 
     Dt[0] = "S";
     Dt[1] = "S";

     String DATA[] = new String[2];
     CODE.grabFocus(); 

     while ( true )  
     {                   
       KeyStr = Get_Input() ;
       try {
       if (KeyStr.substring(1,5).equals("CODE"))
       {
           DATA[0] = CODE.getText();
           Msg = "GET_AGGREG (?,?) }"; 
           Msg = Faw.Get(Msg, DATA,Dt, 2,1) ; 
           NAME.setText(DATA[1]);         	  
                  
           if ( ! (Msg.equals("OK") ) )
                 Message.setText("New Aggregate Code");
           else {
                 Message.setText("Change");
           }
           NAME.grabFocus();  
       }  
       else if (KeyStr.substring(1,5).equals("NAME"))  {
           DATA[1] = NAME.getText();

           if  ( LastKey == 10 )
                Save.grabFocus();  
         }
        else if (KeyStr.substring(1,5).equals("SAVE")) 
         {
           Msg = "WRITE_AGGREG(?,?) }";  
           Msg = Faw.Put(Msg, DATA,Dt, 2) ; 

           if ( ! (Msg.equals("OK") ) )
                 Message.setText(Msg);  
          else {
               Message.setText("Updated");  
               CODE.setText("");
               NAME.setText("");
               DATA[0]="";
               DATA[1]="";
               CODE.grabFocus();  
             }
         }
       else if (KeyStr.substring(1,5).equals("EXIT"))     
          break;
          
       Faw.IndStr = "*";    
       }
       catch(Exception e) {}    
     } 

     Faw.SwitchFrames(AggFrm,MainFrm);     
     AggFrm.dispose();
   }     
   
   //------------------------------------------------- DATACODE ----------------------------
   void DATACODE() 
   {    	   
     JFrame DATACODEFrm = Faw.Create_Frame("DATACODE Table Maintenance", 0,0,1000,600) ; 
     JPanel DATACODEPan = Faw.Create_panel("Add/Change/Update", 0,0,1000,600,DATACODEFrm) ;
 
     JTextField CODE = Faw.Create_TextField("CODE", 150,100,100,25,DATACODEPan); 
     JTextField NAME = Faw.Create_TextField("NAME", 150,125,300,25,DATACODEPan); 
     JTextField UNIT = Faw.Create_TextField("UNIT", 150,150,50,25,DATACODEPan); 
     JTextField Message    = Faw.Create_TextField("Message", 150,175,600,25,DATACODEPan); 

     JButton Save = Faw.Create_Button("SAVE",150,200,100,25,DATACODEPan);
     JButton Exit = Faw.Create_Button("EXIT",260,200,100,25,DATACODEPan);         
       
     //Hide the main frame show DATACODE frame 
     Faw.SwitchFrames(MainFrm , DATACODEFrm);     

     DATACODEFrm.revalidate();
     DATACODEFrm.repaint();

     String Msg ="OK";
     int Tb =0 , Rslt=0;

     String[] Dt;
     Dt = new String[3]; 
     Dt[0] = "S";
     Dt[1] = "S";
     Dt[2] = "S";

     String DATA[] = new String[3];
     CODE.grabFocus(); 

     while ( true )  
     {                   
       KeyStr = Get_Input() ;
       try {
           if (KeyStr.substring(1,5).equals("CODE"))
           {
               DATA[0] = CODE.getText();
               Msg = "GET_DATCODE(?,?,?) }"; 
               Msg = Faw.Get(Msg, DATA,Dt, 3,1);  

               NAME.setText(DATA[1]);         	  
               UNIT.setText(DATA[2]);
                  
               if ( ! (Msg.equals("OK") ) ) {
                    Message.setText("New Data Code");
                    System.out.println(Msg);
               }
               else {
                    Message.setText("Change"); 
               }
               NAME.grabFocus();
           }  
           else if (KeyStr.substring(1,5).equals("NAME"))  {
               DATA[1] = NAME.getText();

               if  ( LastKey == 10 )
                   UNIT.grabFocus();  
           }
           else if (KeyStr.substring(1,5).equals("UNIT"))  {
               DATA[2] = UNIT.getText();

               if  ( LastKey == 10 )
                    Save.grabFocus();  
           }
           else if (KeyStr.substring(1,5).equals("SAVE")) 
            {
               Msg = "WRITE_DATCOD(?,?,?) }";  
               Msg = Faw.Put(Msg, DATA,Dt, 3) ; 

               if ( ! (Msg.equals("OK") ) )
                    Message.setText(Msg);  
               else {
                   Message.setText("Updated");  
                   CODE.setText("");
                   NAME.setText("");
                   UNIT.setText("");
                   DATA[0]="";
                   DATA[1]="";
                   DATA[2]="";
                   CODE.grabFocus(); 
              }
           }
           else if (KeyStr.substring(1,5).equals("EXIT"))     
                break;
          
           Faw.IndStr = "*";    
         }
         catch(Exception e) {}    
     } 

     Faw.SwitchFrames(DATACODEFrm,MainFrm);     

     DATACODEFrm.dispose();
  }
      
   //------------------------------------------------- CLIENTS ----------------------------
   void CLIENTS() 
   {    	   

     JFrame LocFrm = Faw.Create_Frame("Client Table Maintenance", 0,0,1000,600) ; 
     JPanel LocPan = Faw.Create_panel("Add/Change/Update", 0,0,1000,600,LocFrm) ;
 
     JTextField CODE = Faw.Create_TextField("CODE", 150,100,100,25,LocPan); 
     JTextField NAME = Faw.Create_TextField("NAME", 150,125,300,25,LocPan); 
     JTextField Message    = Faw.Create_TextField("Message", 150,200,600,25,LocPan); 

     JButton Save = Faw.Create_Button("SAVE",150,250,100,25,LocPan);
     JButton Exit = Faw.Create_Button("EXIT",260,250,100,25,LocPan);         
       
     //Hide the main frame show Loc frame 
     Faw.SwitchFrames(MainFrm , LocFrm);     

     LocFrm.revalidate();
     LocFrm.repaint();

     String[] Dt;
     Dt = new String[2]; 
     Dt[0] = "S";
     Dt[1] = "S";

     String DATA[] = new String[2];
     String Msg;
     CODE.grabFocus(); 

     while ( true )  
     {                   
       KeyStr = Get_Input() ;
       try {
       if (KeyStr.substring(1,5).equals("CODE"))
       {
           DATA[0] = CODE.getText();
           Msg = "GET_EDGCLN(?,?) }"; 
           Msg = Faw.Get(Msg, DATA,Dt, 2,1) ; 
           NAME.setText(DATA[1]);         	  
                  
           if ( ! (Msg.equals("OK") ) )
                 Message.setText("New IOT Client");
           else {
                 Message.setText("Change");
           } 
           NAME.grabFocus(); 
       }  
       else if (KeyStr.substring(1,5).equals("NAME"))  {
           DATA[1] = NAME.getText();

           if  ( LastKey == 10 )
                Save.grabFocus();  
         }
        else if (KeyStr.substring(1,5).equals("SAVE")) 
         {
           Msg = "WRITE_EDGCLN(?,?) }";  
           Msg = Faw.Put(Msg, DATA,Dt, 2) ; 

           if ( ! (Msg.equals("OK") ) )
                 Message.setText(Msg);  
          else {
               Message.setText("Updated");  
               CODE.setText("");
               NAME.setText("");
               DATA[0]="";
               DATA[1]="";
               CODE.grabFocus(); 
          }
        }
       else if (KeyStr.substring(1,5).equals("EXIT"))     
          break;
          
       Faw.IndStr = "*";    
       }
       catch(Exception e) {}    
     } 

     Faw.SwitchFrames(LocFrm,MainFrm);     

     LocFrm.dispose();
  }
      
  //---------------------------------   FIELDS -------------------------------------------
   void FIELDS() 
   {   	
     JFrame FLDFrm = Faw.Create_Frame("FIELDS Table Maintenance", 0,0,1000,600) ; 
     JPanel FLDPan = Faw.Create_panel("Add/Change/Update", 0,0,1000,600,FLDFrm) ; 

     JTextField PACKET = Faw.Create_TextField("PACKET"  , 150,100,20,22,FLDPan); 
     JTextField CODE = Faw.Create_TextField("CODE"          , 150,125,100,22,FLDPan); 
     JTextField SEQ    = Faw.Create_TextField("SEQ"              , 150,150,20,22,FLDPan); 
     JTextField NAME= Faw.Create_TextField("NAME"          , 150,175,300,22,FLDPan); 
     JTextField LENGTH = Faw.Create_TextField("LENGTH", 150,200,30,22,FLDPan);
     JTextField Message = Faw.Create_TextField("Message"     , 150,250,600,25,FLDPan); 
 
     JButton Save = Faw.Create_Button("SAVE",150,300,100,25,FLDPan);
     JButton Exit = Faw.Create_Button("EXIT",260,300,100,25,FLDPan);

     Faw.SwitchFrames(MainFrm , FLDFrm);     
     FLDFrm.revalidate();
     FLDFrm.repaint();

     String[] Dt;
     Dt = new String[5]; 
     Dt[0] = "S";
     Dt[1] = "S";
     Dt[2] = "S";
     Dt[3] = "S";
     Dt[4] = "S";

     String DATA[] = new String[5];
     String Msg;
     PACKET.grabFocus();

     while ( true )  
     {                   
       KeyStr = Get_Input() ;
       try {
       if (KeyStr.substring(1,7).equals("PACKET"))
       {
           DATA[0] = PACKET.getText();
           Msg = "GET_PACKET(?,?) }"; 
           Msg = Faw.Get(Msg, DATA,Dt, 2,1) ; 
                  
           if ( ! (Msg.equals("OK") ) )
                 Message.setText(Msg);
           else {
                 Message.setText(DATA[1]);
                 DATA[1] = "";         	  
                 CODE.setText(DATA[1]);
                 CODE.grabFocus();
           }  
       }  
       else if (KeyStr.substring(1,5).equals("CODE"))
       {
           DATA[1] = CODE.getText();
           Msg = "GET_FIELDS(?,?,?,?,?) }"; 
           Msg = Faw.Get(Msg, DATA,Dt, 5,2)  ;
           SEQ.setText(DATA[2]);         	  
           NAME.setText(DATA[3]);         	  
           LENGTH.setText(DATA[4]);         	  
                  
           if ( ! (Msg.equals("OK") ) )
                 Message.setText("New Field");
           else {
                 Message.setText("Change");
            }  
            SEQ.grabFocus();
       }  
       else if (KeyStr.substring(1,4).equals("SEQ"))  {
           DATA[2] = SEQ.getText();

           if  ( LastKey == 10 )
                NAME.grabFocus();  
         }
       else if (KeyStr.substring(1,5).equals("NAME") ) {
           DATA[3] = NAME.getText();

           if  ( LastKey == 10 )
                LENGTH.grabFocus();  
         }
       else if (KeyStr.substring(1,7).equals("LENGTH") ) {
           DATA[4] = LENGTH.getText();

           if  ( LastKey == 10 )
                Save.grabFocus();  
         }
        else if (KeyStr.substring(1,5).equals("SAVE")) 
         {
           Msg = "WRITE_FIELDS(?,?,?,?,?) }";  
           Msg = Faw.Put(Msg, DATA,Dt, 5) ; 

           if ( ! (Msg.equals("OK") ) )
                 Message.setText(Msg);  
          else {
               Message.setText("Updated");  
               PACKET.setText("");
               CODE.setText("");
               SEQ.setText("");
               NAME.setText("");
               LENGTH.setText("");
               DATA[0]="";
               DATA[1]="";
               DATA[2]="";
               DATA[3]="";
               DATA[4]="";
               PACKET.grabFocus();
            }
        }
       else if (KeyStr.substring(1,5).equals("EXIT"))     
          break;
          
       Faw.IndStr = "*";    
       }
       catch(Exception e) {}    
     } 

     Faw.SwitchFrames(FLDFrm,MainFrm);     
     FLDFrm.dispose();   
  }     
   //------------------------------------------------- USER ----------------------------
   void USER() 
   {   	
     JFrame USRFrm = Faw.Create_Frame("FIELDS Table Maintenance", 0,0,1000,600) ; 
     JPanel USRPan = Faw.Create_panel("Add/Change/Update", 0,0,1000,600,USRFrm) ; 

     JTextField USER = Faw.Create_TextField("USER"  , 150,100,100,22,USRPan); 
     JTextField NAME= Faw.Create_TextField("NAME"          , 150,125,100,22,USRPan); 
     JTextField PASS = Faw.Create_TextField("PASS"              , 150,150,100,22,USRPan); 
     JTextField STAT= Faw.Create_TextField("STATUS"          , 150,175,20,22,USRPan); 
     JTextField Message = Faw.Create_TextField("Message"     , 150,250,600,25,USRPan); 
 
     JButton Save = Faw.Create_Button("SAVE",150,300,100,25,USRPan);
     JButton Exit = Faw.Create_Button("EXIT",260,300,100,25,USRPan);

     Faw.SwitchFrames(MainFrm , USRFrm);     
     USRFrm.revalidate();
     USRFrm.repaint();

     String[] Dt;
     Dt = new String[4]; 
     Dt[0] = "S";
     Dt[1] = "S";
     Dt[2] = "S";
     Dt[3] = "S";

     String DATA[] = new String[4];
     String Msg;
     USER.grabFocus();

     while ( true )  
     {                   
       KeyStr = Get_Input() ;

       try {
       if (KeyStr.substring(1,5).equals("USER"))
       {
           DATA[0] = USER.getText();
           Msg = "GET_USER(?,?,?,?) }"; 
           Msg = Faw.Get(Msg, DATA,Dt, 4,1) ; 
                  
           if ( ! (Msg.equals("OK") ) )
                 Message.setText("New User");
           else {
                 NAME.setText(DATA[1]);         	  
                 PASS.setText(DATA[2]);         	  
                 STAT.setText(DATA[3]);         	  
           }  
           NAME.grabFocus();
       }  
       else if (KeyStr.substring(1,5).equals("NAME"))
       {
           DATA[1] = NAME.getText();
           if  ( LastKey == 10 )
               PASS.grabFocus();
       }  
       else if (KeyStr.substring(1,5).equals("PASS"))  {
           DATA[2] = PASS.getText();

           if  ( LastKey == 10 )
                STAT.grabFocus();  
         }
       else if (KeyStr.substring(1,5).equals("STAT"))  {
           DATA[3] = STAT.getText();

           if ( DATA[3].equals("A") || DATA[3].equals("N")) 
              {
                 if  ( LastKey == 10 )
                      Save.grabFocus();
              }
           else 
                 Message.setText("Status should be either A (admin) or N (normal)");  
       }
        else if (KeyStr.substring(1,5).equals("SAVE")) 
         {
           Msg = "WRITE_USER(?,?,?,?) }";  
           Msg = Faw.Put(Msg, DATA,Dt, 4) ; 

           if ( ! (Msg.equals("OK") ) )
                 Message.setText(Msg);  
          else {
               Message.setText("Updated");  
               USER.setText("");
               NAME.setText("");
               PASS.setText("");
               STAT.setText("");
               DATA[0]="";
               DATA[1]="";
               DATA[2]="";
               DATA[3]="";
               USER.grabFocus();
             }
          }
       else if (KeyStr.substring(1,5).equals("EXIT"))     
          break;
                
       Faw.IndStr = "*";
       }
       catch(Exception e) {}    
     } 

     Faw.SwitchFrames(USRFrm,MainFrm);     
     USRFrm.dispose();   
  }     
  //--------------------------------------------------------------------------------------
  String Get_Input ()
  {
    String KeyWord; 
    
    Faw.Set_IndStr("*"); 
    Faw.Set_Inx(0); 
    
    while (true) {           
       KeyWord = Faw.Get_IndStr();                             
       LastKey = Faw.Get_Inx();           

       for ( long xx=1; xx < 10000000 ; xx++);

       //System.out.println("inside Get"+LastKey + KeyWord);           

       if (! ( KeyWord.equals("*") && LastKey == 0 ) )
             break;
    }

    KeyWord = KeyWord+ "............";
    return KeyWord;
  }
}
