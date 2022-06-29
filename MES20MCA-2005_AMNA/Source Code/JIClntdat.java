import java.io.* ;
import java.net.*;
import java.sql.Connection;
import java.util.concurrent.ArrayBlockingQueue;

class JIClntdat {
   Socket Soc;
   String IP ,PORT , SEQ, USR, PWD, DBIP,DBPORT,CltType="B",OCFlag="N";
   String Future[] = new String[20] , PrgArr[] = new String[20];
   int CurPrg =-1 , Inactivity=0, InactivityAllowed=0;
   boolean KickOut = false;
   Connection con = null;      
   ArrayBlockingQueue<String> QueStatus;

   JIClntdat() {
      for ( int ii=0; ii<20 ; ii++)                     
          PrgArr[ii]="*";
   }
   public void SetProg(String Prog) {
      PrgArr[CurPrg] = Prog;
   }

   public String GetProg() {
      return PrgArr[CurPrg];
   }

   /* ------------------------------  Add Program ------------------------------*/ 
   public int PrgAdd (String Snd) {
      int Hit=-1;

      for ( int ii=1; ii<20 ; ii++) {                    
         if ( PrgArr[ii].length()==0  || PrgArr[ii].equals("*")  ) {
            Hit = ii;
            break;
         }
      }

      if ( Hit > -1 ) {
         CurPrg = Hit;
         SetProg(Snd);         
      }
      return Hit;
   }
}


