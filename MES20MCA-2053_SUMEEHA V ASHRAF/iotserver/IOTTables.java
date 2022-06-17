public class IOTTables {
   public  static void main(String args[]) throws Exception
     {     	
      try
        {   
           IOTMenu MainMenu = new IOTMenu();
           int Rt = MainMenu.Login();
       } 
      catch(Exception e)
        {
         System.out.println(e.toString()+"Error ");               
      }
   }
}

