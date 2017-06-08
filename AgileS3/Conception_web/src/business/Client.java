package business;

import java.sql.Date;

public class Client extends Person {
	private String credit_card_number;
	private Date credit_card_date;
	private Cart cart;
	private Order order;

	public Client(Person person, String credit_card_number, Date credit_card_date) {
		super(person);
		this.credit_card_number = credit_card_number;
		this.credit_card_date = credit_card_date;
		this.cart = new Cart();
	}

	public String getCreditCardNumber() {
		return credit_card_number;
	}

	public Date getCreditCardDate() {
		return credit_card_date;
	}

	public Boolean isCreditCardValid() {
		return credit_card_date.before(new java.util.Date());
	}

	public void setCreditCard(String credit_card_number, Date credit_card_date) {
		this.credit_card_number = credit_card_number;
		this.credit_card_date = credit_card_date;
	}

	public Cart getCart() {
		return cart;
	}

	public void placeOrder() {
		order = new Order(getId(), getCart().getReferencesQuantity());
		order.setRecipient(getFirstName() + " " + getLastName());
		if (getDefaultAdress() != null)
			order.setAddress(getDefaultAdress());
	}

	public void confirmOrder() {

	}
}
