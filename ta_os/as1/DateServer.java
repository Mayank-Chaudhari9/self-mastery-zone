import java.io.*;
import java.net.*;
import java.util.*;

class DateServer
{
  public static void main(String[] args) throws IOException
  {
      ServerSocket listner = new ServerSocket(9000);
      try
      {
        while(true)
        {
          Socket socket = listner.accept();
          try
          {
            PrintWriter out = new PrintWriter(socket.getOutputStream(),true);
            out.println(new Date().toString());
          }
          finally
          {
            socket.close();
          }
        }
      }
      finally
      {
        listner.close();
      }
  }

}
