import java.net.*;
import java.io.*;
import java.util.Scanner;
import java.util.Vector;

public class MarketClient implements Runnable
{  private Socket socket              = null;
   private Thread thread              = null;
   private BufferedReader  console   = null;
   private DataOutputStream streamOut = null;
   private MarketClientThread client    = null;
   private static final String itemsInfo = "items.txt";
   private static final String saleInfo = "sales.txt";
   private String chatName;
   private int itemIndex = 0;
   private int saleTime = 30;
   private int qtotal = -1;
   private int breaker = 0;
   
   private boolean onSale = false;
   Vector<Item> items = new Vector<Item>();
		Item item1 = new Item("Flower", 6, 2);
		Item item2 = new Item("Sugar", 3, 1);
		Item item3 = new Item("Potato", 7, 1);
		Item item4 = new Item("Oil", 15, 2);
		
		

   
   public MarketClient(String serverName, int serverPort, String name)
   {
		items.add(item1);
		items.add(item2);
		items.add(item3);
		items.add(item4);
	   
	  System.out.println("Establishing connection. Please wait ...");

	  this.chatName = name;
      try{
		 socket = new Socket(serverName, serverPort);
         System.out.println("Connected: " + socket);
         start();
      }
      catch(UnknownHostException uhe){
		  System.out.println("Host unknown: " + uhe.getMessage());
	  }
      catch(IOException ioe){
		  System.out.println("Unexpected exception: " + ioe.getMessage());
	  }
   }

   public void run()
   {
	   while (thread != null){
		 try {
			if (chatName.equals("BUYER")){
				System.out.println("Press 1 to List Items");
				System.out.println("Press 2 to Buy Item");
				System.out.println("Press 3 to Exit");
			}
			
			if (chatName.equals("SELLER")){
				System.out.println("Press 1 to Sell Item");
				System.out.println("Press 2 to Specify Selling Period (default 30 seconds)");
				System.out.println("Press 3 to Exit");
			}
			String message = chatName + " > " + console.readLine();
			String[] tokens = message.split(" > ");
			
			// Seller Function 1
			if(tokens[0].equals("SELLER") && tokens[1].equals("1")){
		   onSale = true;
		   do{
			   streamOut.flush();
			   streamOut.writeUTF(message);
			   streamOut.flush();
			
				qtotal = 0;
				for (int i = 0; i < items.size(); i++){
					qtotal = qtotal + items.get(i).getQuantity();
				}
				if (qtotal == 0){
					break;
				}
				long timeout = System.currentTimeMillis() + (saleTime * 1000);
				while(items.get(itemIndex).getQuantity() != 0 && System.currentTimeMillis() < timeout){
					try{
						Thread.sleep(6000);		 
					} catch (InterruptedException ie){
								   ie.printStackTrace();
					}
					
					
					
				}
				
				
				
			try (Scanner scanner = new Scanner(new File(itemsInfo))) {
						while (scanner.hasNextLine()) {
							String[] info = scanner.nextLine().split(",");
							itemIndex =  Integer.parseInt(info[0]);
							items.get(itemIndex).setQuantity(Integer.parseInt(info[1]));
						}
					}
					catch (FileNotFoundException e) {
						e.printStackTrace();
					}
			itemIndex++;
			
			if(itemIndex == items.size()){
				itemIndex = 0;
			}

			try(PrintWriter writer = new PrintWriter(new File(itemsInfo))){
					writer.println(itemIndex + "," + items.get(itemIndex).getQuantity());
				} catch (IOException e) {
					e.printStackTrace();
				}
			
		   }while(qtotal > 0);
		   streamOut.flush();
		   
		   
		   
	   }
	   if(tokens[0].equals("SELLER") && tokens[1].equals("2")){
			Scanner scannerChoice = new Scanner(System.in);
		   // insert timer here.
		   int choice = 0;
			do{
			System.out.println("Enter number between 5 and 60");
			if(scannerChoice.hasNextInt()){
				choice = scannerChoice.nextInt();
			}
			
			
		}while(choice < 5 || choice > 60);
		try(PrintWriter writer = new PrintWriter(new File(saleInfo))){
					writer.println(choice);
				} catch (IOException e) {
					e.printStackTrace();
				}
	   }
			
		else{
			streamOut.writeUTF(message);
            streamOut.flush();
			
		}
			
         }
         catch(IOException ioe)
         {  System.out.println("Sending error: " + ioe.getMessage());
            stop();
         }
      }
   }

   public void handle(String msg)
   {
	   
	   if (msg.equals("3"))
      {  System.out.println("Good bye. Press RETURN to exit ...");
         stop();
      }
      else
         System.out.println(msg);
   }

   public void start() throws IOException
   {
	  
	  console = new BufferedReader(new InputStreamReader(System.in));

      streamOut = new DataOutputStream(socket.getOutputStream());
      if (thread == null)
      {  client = new MarketClientThread(this, socket);
         thread = new Thread(this);
         thread.start();
      }
   }

   public void stop()
   {
      try
      {  if (console   != null)  console.close();
         if (streamOut != null)  streamOut.close();
         if (socket    != null)  socket.close();
      }
      catch(IOException ioe)
      {
		  System.out.println("Error closing ...");

      }
      client.close();
      thread = null;
   }


   public static void main(String args[])
   {  MarketClient client = null;
	  Scanner scannerChoice = new Scanner(System.in);
	   int choice = 0;
	   
		do{
			System.out.println("Enter 1 to join as Seller, 2 to join as Buyer");
			if(scannerChoice.hasNextInt()){
				choice = scannerChoice.nextInt();
			}
			
		}while(choice < 1 || choice > 2);
			
		if (choice == 1){
			choice = 0;
			System.out.println("Press 1 to Join Market.");
			System.out.println("Press 2 to Leave Market.");
			do{
				if(scannerChoice.hasNextInt()){
					choice = scannerChoice.nextInt();
				}
			}while(choice < 1 || choice > 2);
			if(choice == 1){
				client = new MarketClient("localhost", 80, "SELLER");
			}
			if (choice == 2){
				System.out.println("Exiting Marketplace...");
			}
			
		}
		if (choice == 2){
			choice = 0;
			System.out.println("Press 1 to Join Market.");
			System.out.println("Press 2 to Leave Market.");
			do{
				if(scannerChoice.hasNextInt()){
					choice = scannerChoice.nextInt();
				}
			}while(choice < 1 || choice > 2);
			if(choice == 1){
				client = new MarketClient("localhost", 80, "BUYER");
			}
			if (choice == 2){
				System.out.println("Exiting Marketplace...");
			}
			
		}
		
   }
}
