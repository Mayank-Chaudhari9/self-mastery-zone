import java.net.*;
import java.io.*;
import java.util.*;


class Server
{
  public static void main(String[] args) throws Exception
  {
    ServerSocket ssoc = new ServerSocket(5555);
    try
    {
      while(true)
      {
        Socket soc = ssoc.accept();
        try
        {
          DataOutputStream dout = new DataOutputStream(soc.getOutputStream());

          String greeting = "Hello From server";

          dout.writeUTF(greeting);
          dout.flush();
          dout.close();
        }
        finally
        {
          soc.close();
        }
      }

    }
    finally
    {
      //soc.close();
      ssoc.close();
    }

  }
}
