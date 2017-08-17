import java.net.*;
import java.io.*;
import java.util.*;


class Client
{
  public static void main(String[] args) throws IOException
  {
    String ip="127.0.0.1";
    Socket soc =new Socket(ip,9000);
    BufferedReader input = new BufferedReader(new InputStreamReader(soc.getInputStream()));
    String ans = input.readLine();
    System.out.println(ans);
    System.exit(0);
  }
}
