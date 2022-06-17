import java.awt.*;
import java.awt.event.*;
import java.util.Date;
import java.util.Vector;
import java.text.*;
import javax.swing.*;
import javax.swing.border.* ;
import javax.swing.event.*;
import javax.swing.tree.*;
import javax.swing.text.AbstractDocument;
import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.DocumentFilter;
import java.io.* ;
import java.net.*;
import java.sql.Connection;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class IOTAwt  
{
   String IndStr  = "*"; 
   Connection con;

   int KeyInx=0;
   private Dimension screenSize  = Toolkit.getDefaultToolkit().getScreenSize();

   IOTAwt (   Connection Xcon)
   {
        this.con =  Xcon;
        System.out.println("In Constructor Awt");
   }

   public synchronized  void Set_IndStr( String set)  {
   	  IndStr   = set; 
   }   

   public synchronized   String Get_IndStr()  {
      return IndStr;
   }   
      
   public synchronized  int Get_Inx()  {
      return KeyInx;
   }   

   public synchronized  void Set_Inx(int Ky)  {
       KeyInx = Ky;
   } 
//-------------  Get record
//-- data pointed by the array and return pointer
  public String Get(String Proc, String[] Data,String[] Dt , int Fl ,int Ky)  
     {      
        String Str = "";
        // Array received as parm is all string                  
System.out.println("Before read try");

        try {
           String call = "{ ? = call " + Proc;
           CallableStatement cstmt = con.prepareCall(call);                         
           cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);

System.out.println(Dt[0]+"key " + Data[0]);

           for (int ii = 0 ; ii < Fl ; ii++)
            {
                 if ( ii < Ky ) {
                     //if (Dt[ii].equals("S")) 
                         cstmt.setString(ii+2,Data[ii]);
System.out.println( "After set key  " + Data[0] );
                     //else{
                     //    K = Integer.parseInt(Data[ii]);
                     //    cstmt.setInt(ii+2,K);
                     //}
                  }
                 else {
                     //if (Dt[ii].equals("S")) 
                      cstmt.registerOutParameter(ii+2, java.sql.Types.VARCHAR);
                     //else
                      //cstmt.registerOutParameter(ii+2, oracle.sql.NUMBER);
                     //  cstmt.registerOutParameter(1, Types.DECIMAL);
                 }
            }

System.out.println( "before exec  " );
            cstmt.execute();
System.out.println( "after exec  " );

            Str = cstmt.getString(1);  
 
            for (int ii = Ky ; ii < Fl ; ii++)
            {
                 //if (Dt[ii].equals("S")) 
                    Data[ii] = cstmt.getString(ii+2);  
                 //else
                 //   K = cstmt.getBigDecimal(ii+2);
                 //K = cstmt.getNumber(ii+2);
                 //   Data[ii] = Integer.toString(K); 
            }
             System.out.println(Str + " " + Data[0] + Data[1]);

         }
         catch ( Exception e) { 
             System.out.println(e.getMessage());
         }
        return Str;
   }   

         //   callableStatement.registerOutParameter(3, Types.DECIMAL);
         //   callableStatement.registerOutParameter(4, java.sql.Types.DATE);
         //   number float
         //   number Int
         //    BigDecimal salary = callableStatement.getBigDecimal(3);
         //   Timestamp createdDate = callableStatement.getTimestamp(4);
        //cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.VARCHAR);
        //cstmt.registerOutParameter(1, oracle.jdbc.Types.DECIMAL);

/*---Delete record from memory and update file-------------
  public String Delete(int Fl )  
     {    
      int Rc;  
      
      if ( Bt[Fl].RecNum != 0 )  { 
         String data[] = new String[Bt[Fl].FieldCnt];
         Rc = Put(Fl , data, Bt[Fl].RecNum ,  0 ) ;  
      }
      else
         Rc = 0;
         
      return Rc;       
   }   
*/
//  --- Insert record 
//   This has to come from calling routing in Proc
//        Func = "WRITE_EDDAT(?,?,?,?) }";
//  Data will have field values , Dt will have field types , Fl field count
//  all array substript are string
//  -----------------------------------------------------------------------------------------
  public String Put(String Proc, String[] Data,String[] Dt , int Fl)  
     {      
        String Str = "";
        int K = 0;
                  
        try {
        String call = "{ ? = call " + Proc;
        CallableStatement cstmt = con.prepareCall(call);                         
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.VARCHAR);

        for (int ii = 0 ; ii < Fl ; ii++)
         {
              if (Dt[ii].equals("S")) {
                  cstmt.setString(ii+2,Data[ii]);
              }
              else {
                  // This check is not to send non numeric in numeric field. 
                  // both are send as string
                  try
                      {
                         K = Integer.parseInt(Data[ii]);
                         cstmt.setString(ii+2,Data[ii]);
                       }
                   catch ( Exception e)
                   { }
              }
         }

         //System.out.println(ii + "In private put. record " + "A" +Full+Tmp);
         cstmt.execute();

         Str = cstmt.getString(1);  
         }
         catch ( Exception e) {}
         return  Str;
  }
//---Create Frame---------------------------------------------------------------
   public JFrame Create_Frame(String Title, int x,int y,int w,int h)  
     {      
      double yy = screenSize.getHeight();
      double xx = screenSize.getWidth();
      
      
      int yyy = (int)yy;
      yyy = ((yyy-h)/2);
      int xxx = (int)xx;
      xxx =((xxx-w)/2);
        
      if(x+y!=0) 
        {
         xxx =x;
         yyy =y;
        }
      
      JFrame FrameArr = new JFrame();
      FrameArr.setLayout(null);
      FrameArr.setVisible(true);
      FrameArr.setBounds(xxx,yyy,w,h);
      FrameArr.setResizable(false);
      FrameArr.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
      FrameArr.setTitle(Title);
      return FrameArr; 

   }
//---Create Panel---------------------------------------------------------------   
   public JPanel Create_panel(String Title,int x,int y,int w,int h,JFrame Frm)  
     {

      JPanel PanelArr = new JPanel(); 
      PanelArr.setLayout(null);
      PanelArr.setVisible(true);
      PanelArr.setBounds(x,y,w,h);

        
      JLabel PanLabel = new JLabel();
      //PanLabel.setLocation(x,Ystr);
  	  double wwid=PanelArr.getSize().getWidth();//Text.length()*30;

      int wid = (int)wwid;
      PanLabel.setSize(wid,50);      
      PanLabel.setHorizontalAlignment(SwingConstants.CENTER);

      PanLabel.setText(Title);
      PanelArr.add(PanLabel);
      Frm.add(PanelArr);
      return PanelArr; 
  }  

//---Create Button--------------------------------------------------------------   
   public JButton Create_Button (String ButName , int x,int y,int w,int h,JPanel AddTo)
     {

   	  JButton But= new JButton();
   	  But.setHorizontalAlignment(SwingConstants.CENTER);
   	  But.setBounds(x,y,w,h);
      But.setVisible(true);
      But.addActionListener(new ProgramEvents());
      But.addKeyListener(new ProgramEvents());

      But.putClientProperty("Ind","B"+ButName);

      Border raisedBorder = BorderFactory.createRaisedBevelBorder();
      But.setBorder(raisedBorder);
      AddTo.add(But);
      But.setText(ButName);
      return But;      
      
   }  
//-------------------CreateTextField-------------------------------- 
   public JTextField  Create_TextField (String Title,int x,int y,int w,int h,JPanel AddTo)
     {
      int wid = Title.length()*10;
      JTextField TextArr = new JTextField();
      TextArr.setBounds(x,y,w,h);
      TextArr.setLayout(null);      

  	  TextArr.addKeyListener(new ProgramEvents());
  	  TextArr.setFocusTraversalPolicyProvider(false);

      TextArr.putClientProperty("Ind","T"+Title);

      AddTo.add(TextArr );
      TextArr .setVisible(true);       
      JLabel TLabel = new JLabel();
      TLabel.setSize(wid,h);      
      TLabel.setLocation(x-wid,y);  
      TLabel.setText(Title);    
      AddTo.add(TLabel);
      AddTo.revalidate();
      return TextArr; 
  }             
//-------------------Create Password--------------------------------  
   public JPasswordField  Create_PassField (String Title,int x,int y,int w,int h,JPanel AddTo)
     {
      int wid = Title.length()*10;
      JPasswordField PassArr = new JPasswordField();
      PassArr.setEchoChar('*');
      PassArr.setBounds(x,y,w,h);
      PassArr.setLayout(null);      
      PassArr.addKeyListener(new ProgramEvents());
      PassArr.setFocusTraversalPolicyProvider(false);
      PassArr.putClientProperty("Ind","P"+Title);

      AddTo.add(PassArr );
      PassArr .setVisible(true);       
      JLabel TLabel = new JLabel();
      TLabel.setSize(wid,h);      
      TLabel.setLocation(x-wid,y);  
      TLabel.setText(Title);    
      AddTo.add(TLabel);
      AddTo.revalidate();
      return PassArr; 
  }             

//------------------------------Switch------------------------------
  public void SwitchFrames(JFrame FrameOff,JFrame FrameOn)
   {
     FrameOn.setVisible(true);
     FrameOff.setVisible(false);
   }
//------------------------------Number Format Check------------------------------
  int Frmt_Chk_Num (String Str) {
     int ptr = 0;
     
     if (Str.length() > 0) {
	 	try {
          	 ptr = Integer.parseInt(Str.substring(0, 3));
		} catch (Exception er) {
//    	      Show_Error("Number Format Error" , "Number Check" , "OK");
    	      return -1;             
	    }
		
	 }
	 return ptr;
  }
//------------------------------Date Format Check------------------------------
  String Frmt_Chk_Date (String Str) {
      int ArPos , ptr;

      ptr = Integer.parseInt(Str.substring(0, 3));

      String DateString = Str;
		   				      	
      	 int Cnt = 0 , Lng=DateString.length();
      	 String RetStr = "",DD ="", MM="" , RR="", Single="",Digits="0123456789";
      	 
      	 //  Day
      	 while ( Cnt < Lng && DD.length() < 2) {
      	 	Single = DateString.substring(Cnt,Cnt+1);
      	 	if (Digits.indexOf(Single) > -1) {
      	 	   DD = DD + Single;
      	 	   Cnt = Cnt + 1;
      	    }
      	    else
      	       break;		 
      	 } 	
      	
      	 //   Gap 1
      	 while ( Cnt < Lng ) {
      	 	Single = DateString.substring(Cnt,Cnt+1);

      	 	if (Digits.indexOf(Single) < 0) 
      	 	   Cnt = Cnt + 1;
      	    else
      	       break;		 
      	 } 	
      	 
     	 
         //  Month
      	 while ( Cnt < Lng && MM.length() < 2 ) {
      	 	Single = DateString.substring(Cnt,Cnt+1);
      	 	if (Digits.indexOf(Single) > -1) {
      	 	   MM = MM + Single;
      	 	   Cnt = Cnt + 1;
      	    }
      	    else
      	       break;		 
      	 } 	
      	
      	 // Gap 2
      	 while ( Cnt < Lng ) {
      	 	Single = DateString.substring(Cnt,Cnt+1);
      	 	if (Digits.indexOf(Single) < 0) 
      	 	   Cnt = Cnt + 1;
      	    else
      	       break;		 
      	 } 	
         
         //  Year
      	 while ( Cnt < Lng ) {
      	 	Single = DateString.substring(Cnt,Cnt+1);
      	 	if (Digits.indexOf(Single) > -1) {
      	 	   RR = RR + Single;
      	 	   Cnt = Cnt + 1;
      	    }
      	    else
      	       break;		 
      	 } 	
      	 
      	 if ( DD.length() > 2 )
      	    return "*";
      	    
      	 if ( DD.length() == 1 )
      	    RetStr = "0" + DD + "/";
      	 else
      	    RetStr = DD + "/";
      	    
      	 if ( MM.length() > 2 )
      	    return "*";
      	    
      	 if ( MM.length() == 1 )
      	    RetStr = RetStr + "0" + MM+ "/";
      	 else
      	    RetStr = RetStr + MM+ "/";
      	             	    
      	 if ( !(RR.length() == 2  || RR.length()==4)) {
      	 	int Mn = "JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC".indexOf(DateString.substring(3,6));
      	    
      	    if ( Mn > -1 ) { 
      	        Mn = (Mn/3) + 1;
      	        
      	        RR = DateString.substring(7,9);
      	        
      	        if ( Mn < 10 ) 
      	           RetStr = DateString.substring(0,2) + "/0" + Integer.toString(Mn) + "/";
      	        else             
      	           RetStr = DateString.substring(0,2) + "/" + Integer.toString(Mn) + "/";
      	     
      	    }    
      	    else     
         	    return "*";
      	 } 

  	  RetStr = RetStr + RR;
	  return RetStr; 
 }     
//-----------------------------------------------End Formula manipulation ---------------------------------------
private class ProgramEvents implements  KeyListener,ActionListener{

//---ActionPerformed------------------------------------------------------------
   public void actionPerformed(ActionEvent e) 
     {      
         String Str;
         int    Ky;
         
  	     try  	       
  	       {
  	        String act;

  	        act = e.getSource().getClass().toString();

//System.out.println("action "+act);

  	        if(act.equals("class javax.swing.JButton") )	
  	          {
                 JButton btn = (JButton) e.getSource();
                 Str         = btn.getClientProperty("Ind").toString();
                 Set_IndStr( Str ) ; 
                 Set_Inx(10) ;
//System.out.println(Get_IndStr());               
  	         }
  	      }   
         catch(Exception er)
           {
  	        System.out.println("actionPerformed Button Error ");
  	       }

     } 
//---keyPressed-----------------------------------------------------------------
   public void keyPressed(KeyEvent e) 
     {
   	  String Str ="";
   	  int    Ky  = 0;
   	  

      String act = e.getSource().getClass().toString();
      Ky = e.getKeyCode();
      Set_Inx(Ky); 
  	        

//System.out.println("Pressed"+act+KeyInx);

      if (act.equals("class javax.swing.JButton")) 	{  	          	     
         JButton btn = (JButton) e.getSource();
   	     Str      = btn.getClientProperty("Ind").toString();
         Set_IndStr( Str);  
//System.out.println(KeyInx+IndStr);
      }   

  
      if (act.equals("class javax.swing.JTextField") && KeyInx == 10) {	                     
         JTextField Tf = (JTextField) e.getSource();
 	     Str      = Tf.getClientProperty("Ind").toString();
 	     Set_IndStr( Str)  ;
         Set_Inx(10);
//System.out.println("K"+KeyInx+IndStr);
       }          

      if (act.equals("class javax.swing.JPasswordField") && KeyInx == 10) {	                     
         JPasswordField Pw = (JPasswordField) e.getSource();
 	     Str      = Pw.getClientProperty("Ind").toString();
 	     Set_IndStr( Str)  ;
         Set_Inx(10);
//System.out.println("K"+KeyInx+IndStr);
       }          


  }

//---keyReleased----------------------------------------------------------------
   public void keyReleased(KeyEvent e) 
     {
     }
//---keyTyped-------------------------------------------------------------------
   public void keyTyped(KeyEvent e) 
   {  
    } 
//---valueChanged---------------------------------------------------------------
   public void valueChanged(TreeSelectionEvent event) 
     {
     }
     
 } //-------  End Of Event Class     

//-------------------------------------------------------Event class End ------------------------------------
}
     