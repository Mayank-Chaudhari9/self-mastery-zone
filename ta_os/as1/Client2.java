import java.io.*;
import java.net.*;
import java.util.*;


class Client2
{
  public static void main(String[] args) throws IOException
  {
      Socket csoc = new Socket("localhost",5555);
      try
      {
        DataInputStream din = new DataInputStream(csoc.getInputStream());
        String msg=din.readUTF();
        System.out.println(msg);
        din.close();
      }
      finally
        {

          csoc.close();
        }
  }

}
