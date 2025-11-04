Run the following command to compile the files:
javac -classpath . Item.java MarketClient.java MarketClientThread.java MarketServer.java MarketServerThread.java

Run the following command to run the server:
java -classpath . MarketServer 80

Run the following command to run the client:
java -classpath . MarketClient