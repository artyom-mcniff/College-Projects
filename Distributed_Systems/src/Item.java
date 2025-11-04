import java.io.*;
public class Item implements Serializable{
	
	private String name;
	private double price;
	private int qty;
	
	public Item(String name, double price, int qty) {
		this.name = name;
		this.price = price;
		this.qty = qty;
	}
	
	public String getName() {
		return this.name;
	}
	
	public double getPrice() {
		return this.price;
	}
	
	public int getQuantity(){
		return this.qty;
	}
	
	
	public void setQuantity(int newQty){
		this.qty = newQty;
	}
	
	
	
	public String toString() {
		return this.name+" "+this.price+" "+this.qty;
	}
}
