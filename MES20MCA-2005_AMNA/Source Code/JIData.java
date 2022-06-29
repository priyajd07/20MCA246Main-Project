import java.util.ArrayList;
import java.util.List;
import java.awt.Rectangle;

public class JIData 
  {
   //-----------------------       GRID   -----------------------------------
   ArrayList<ArrayList<Object>> Book   = new ArrayList<ArrayList<Object>>();
   ArrayList<Object>            Page ;
   ArrayList<String>            Linedata;
 //---get date----------------------------------------------------------------
   public String GetStr (int x, int y)
      {
      return (String) Book.get(x).get(y); 
   } 
 //---get pos and data pointer----------------------------------------------------------------
   public int GetNum (int x, int y)
      {
      return (int) Book.get(x).get(y); 
   } 

 //---get rectangle----------------------------------------------------------------
   public Rectangle GetRect (int x, int y)
      {
      return (Rectangle) Book.get(x).get(y); 
   } 
 //---get size of page size----------------------------------------------------------------
   public int GetSize(int x)
     {
       return Book.get(x).size();
   } 
 //---get size of book in pagese----------------------------------------------------------------
   public int GetSize()
     {
       return Book.size();
   } 
 //-------------------------------------add a page-----------------------------------------

   public void add ()
    {
       Page   = new ArrayList<Object>();        
       Book.add(Page);
  }

 //-------------------------------------add Data-----------------------------------------
   public void add (String Data)
    {
       Page.add(Data);
   }

 //-------------------------------------add a Var pointer / data pointer-----------------------------------------
   public void add (int Num)
    {
       Page.add(Num);
   }
 //-------------------------------------add a rectangle-----------------------------------------
   public void add (int Xaxs,int Yaxs,int Wide,int Ywid)
    {
      Page.add(new Rectangle(Xaxs,Yaxs,Wide,Ywid));
   }
//----------------------------------- Changing page to page of page----------------------------
  public  void  Page_of_page(int BegPage ,  int FinPage, int PgDiscount, String VrWpTyp[])
  {   
   int PgVPtr=0 ;
   String PgData="";

   
   for (int Pg = BegPage-1 ; Pg < FinPage ; Pg++) {    	
       for (int line=0; line<Book.get(Pg).size(); line=line+4) {
          PgData = (String)Book.get(Pg).get(line);
          PgVPtr = (int)Book.get(Pg).get(line+2);


          if (VrWpTyp[PgVPtr].equals("P"))
             Book.get(Pg).set(line, PgData + " of " + Integer.toString(FinPage-PgDiscount));
             
     }
   }
  } 
//----------------------------------- get number of lines in processed data----------------------------
  public int  Get_Count(int StPage , int Count)
  {   
   int Cnt=0 ;
   
   
   for (int Pg = StPage ; Pg < StPage + Count  ; Pg++) {    	
       Cnt = Cnt + Book.get(Pg).size()/4 ;
   }  
   
   return Cnt;
   
  } 
  
 //------------------------------------------get line receied from server----------------------------------------------------------------
   public String GetPline (int x)
      {
      return Linedata.get(x); 
   } 
 //-------------------------------------add Data-----------------------------------------
   public void addpline (String fullline)
    {
       Linedata.add(fullline);
   }
//---get Count of Lines----------------------------------------------------------------
   public int GetLineSize()
     {
       return Linedata.size();
   } 
//----------------------------------- Changing page to page of page----------------------------
  public void  Lines()
  {   
    Linedata = new ArrayList<String>();
 }      
}

