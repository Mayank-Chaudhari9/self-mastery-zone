import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;
import java.net.Socket;

public class Client{
public static void main(String [] agrs) throws IOException{
ServerMultithreaded newServer = new ServerMultithreaded(9191);
new Thread(newServer).start();

try {
    Thread.sleep(15 * 1000);
} catch (InterruptedException e) {
    e.printStackTrace();
}
System.out.println("Stopping newServer");
newServer.stop();
}
}
