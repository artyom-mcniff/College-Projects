import java.net.*;
import java.io.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.UnknownHostException;
import java.net.Socket;
import java.net.InetAddress;
import java.util.Vector;
import java.util.Scanner;

public class MarketServer implements Runnable
{  
   
   // Array of clients	
   private MarketServerThread clients[] = new MarketServerThread[50];
   private ServerSocket server = null;
   private Thread       thread = null;
   private int clientCount = 0;
   private int itemIndex = 0;
   private int saleTime = 30;
   private int qtotal = 0;
   private boolean onSale = false;
   private static final String itemsInfo = "items.txt";
   private static final String saleInfo = "sales.txt";
   Vector<Item> items = new Vector<Item>();
		Item item1 = new Item("Flower", 6, 2);
		Item item2 = new Item("Sugar", 3, 1);
		Item item3 = new Item("Potato", 7, 1);
		Item item4 = new Item("Oil", 15, 2);
		
		
   

   public MarketServer(int port)
   {
		items.add(item1);
		items.add(item2);
		items.add(item3);
		items.add(item4);
	   
	   
	   
	  try {

		 System.out.println("Binding to port " + port + ", please wait  ...");
         server = new ServerSocket(port);
         System.out.println("Server started: " + server.getInetAddress());
		 start();

         
      }
      catch(IOException ioe)
      {
		  System.out.println("Can not bind to port " + port + ": " + ioe.getMessage());

      }
   }

   public void run()
   {
	  while (thread != null)
      {
		 try{

			System.out.println("Waiting for a client ...");
            addThread(server.accept());

			int pause = (int)(Math.random()*3000);
			Thread.sleep(pause);

         }
         catch(IOException ioe){
			System.out.println("Server accept error: " + ioe);
			stop();
         }
         catch (InterruptedException e){
		 	System.out.println(e);
		 }
      }
   }

  public void start()
    {
		if (thread == null) {
		  thread = new Thread(this);
          thread.start();
       }
    }

   public void stop(){
	   thread = null;

   }

   private int findClient(int ID)
   {
	   for (int i = 0; i < clientCount; i++)
         if (clients[i].getID() == ID)
            return i;
      return -1;
   }

   public synchronized void broadcast(int ID, String input)
   {
	   String[] tokens = input.split(" > ");
	   
	   if(tokens[0].equals("BUYER") && tokens[1].equals("1")){
		   if (!onSale){
			for (int i = 0; i < clientCount; i++){
				if(clients[i].getID() == ID){
					clients[i].send("There are no items on sale!");
				}  
		   }
		   }
		   
		   if (onSale){
			items.get(itemIndex).toString();
		   }
	   }
		   
	   
	   if(tokens[0].equals("BUYER") && tokens[1].equals("2")){
		   if (!onSale){
				for (int i = 0; i < clientCount; i++){
					if(clients[i].getID() == ID){
						clients[i].send("There are no items on sale!");
					}  
				} 
		   }
		   else if (items.get(itemIndex).getQuantity() == 0){
			   for (int i = 0; i < clientCount; i++){
				if(clients[i].getID() == ID){
					clients[i].send("Item sold out!");
				}  
		   }
		   }
		   else{
			   for (int i = 0; i < clientCount; i++){
				   if(clients[i].getID() == ID){
					   clients[i].send("You have bought: " + items.get(itemIndex).getName());
					   
				   }
					else{
						clients[i].send(ID + " has bought: " + items.get(itemIndex).getName());
					}
            	 // sends messages to clients
		   
			}
			try(PrintWriter writer = new PrintWriter(new File(itemsInfo))){
					writer.println(itemIndex + "," + items.get(itemIndex).getQuantity());
				} catch (IOException e) {
					e.printStackTrace();
				}
					try (Scanner scanner = new Scanner(new File(itemsInfo))) {
						while (scanner.hasNextLine()) {
							String[] info = scanner.nextLine().split(",");
							itemIndex =  Integer.parseInt(info[0]);
						}
					}
					catch (FileNotFoundException e) {
						e.printStackTrace();
					}
				
				
				items.get(itemIndex).setQuantity(items.get(itemIndex).getQuantity() - 1);
				try(PrintWriter writer = new PrintWriter(new File(itemsInfo))){
					writer.println(itemIndex + "," + items.get(itemIndex).getQuantity());
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				
				// Send to client the quantity lost
			   
		   }
		   
		   
		   
	   }
	   
	   if(tokens[0].equals("SELLER") && tokens[1].equals("1")){
		   onSale = true;
		   try (Scanner scanner = new Scanner(new File(itemsInfo))) {
						while (scanner.hasNextLine()) {
							String[] info = scanner.nextLine().split(",");
							itemIndex =  Integer.parseInt(info[0]);
						}
					}
					catch (FileNotFoundException e) {
						e.printStackTrace();
					}
			for (int i = 0; i < clientCount; i++){
					if(clients[i].getID() != ID){
						clients[i].send(ID + " has put " + items.get(itemIndex).getName() + " on sale for " + saleTime + " seconds");
						clients[i].send("Amount left: " + items.get(itemIndex).getQuantity());
					}
					
				}			
		   
		   
		   
	   }
	   
	   if(tokens[0].equals("SELLER") && tokens[1].equals("2")){
		   
			try (Scanner scanner = new Scanner(new File(saleInfo))) {
						while (scanner.hasNextLine()) {
							String info = scanner.nextLine();
							saleTime =  Integer.parseInt(info);
						}
					}
					catch (FileNotFoundException e) {
						e.printStackTrace();
					}
		   
	   }
	   
	   
	   
	   
	   if (tokens[1].equals("3")){
		  clients[findClient(ID)].send("Exiting");
          remove(ID);
       }
	   
	   else{
		   notifyAll();
	   }
	   
       
   }
   public synchronized void remove(int ID)
   {
	  int pos = findClient(ID);
      if (pos >= 0){
		 MarketServerThread toTerminate = clients[pos];
         System.out.println("Removing client thread " + ID + " at " + pos);

         if (pos < clientCount-1)
            for (int i = pos+1; i < clientCount; i++)
               clients[i-1] = clients[i];
         clientCount--;

         try{
			 toTerminate.close();
	     }
         catch(IOException ioe)
         {
			 System.out.println("Error closing thread: " + ioe);
		 }
		 toTerminate = null;
		 System.out.println("Client " + pos + " removed");
		 notifyAll();
      }
   }

   private void addThread(Socket socket)
   {
	  if (clientCount < clients.length){

		 System.out.println("Client accepted: " + socket);
         clients[clientCount] = new MarketServerThread(this, socket);
         try{
			clients[clientCount].open();
            clients[clientCount].start();
            clientCount++;
         }
         catch(IOException ioe){
			 System.out.println("Error opening thread: " + ioe);
		  }
	  }
      else
         System.out.println("Client refused: maximum " + clients.length + " reached.");
   }


   public static void main(String args[]) {
	   MarketServer server = null;
	   // get items
		
	   
	   
      if (args.length != 1)
         System.out.println("Usage: java MarketServer port");
      else
         server = new MarketServer(Integer.parseInt(args[0]));
   }

}