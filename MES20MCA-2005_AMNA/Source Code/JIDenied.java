class JIDenied {
 /* ------------------------------  Get and validate ------------------------------*/ 
  String Tot;

  JIDenied () {
       Tot = "HTTP/1.1 404. Not Logged In. access denied";
       Tot = Tot + "Server: JIHttp server"+"\r\n";
       Tot = Tot + "Connection: Close"+"\r\n";
       Tot = Tot + "Content-Type: text/html"+"\r\n";
       Tot = Tot +"\r\n";
     }
   String Denied () {
      return Tot;
   }  
}     

