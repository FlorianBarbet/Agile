package business;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

public class Order {
	private final int ID;
	private int person;
	private String recipient;
	private String address;
	private int status;
	private Date date;
	private Map<Integer, Integer> references_quantity = new HashMap<Integer, Integer>();

	// Passer une commande

	public Order(int person, Map<Integer, Integer> references_quantity) {
		this.ID = -1;
		this.person = person;
		this.references_quantity = references_quantity;
		this.status = 0;
		this.date = new Date(new java.util.Date().getTime());
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	// Afficher une commande depuis la BDD

	public Order(int id, int person, String recipient, String address, int status, Date date,
			Map<Integer, Integer> references_quantity) {
		this.ID = id;
		this.person = person;
		this.recipient = recipient;
		this.address = address;
		this.status = status;
		this.date = date;
		this.references_quantity = references_quantity;
	}

	public int getId() {
		return ID;
	}

	public int getPerson() {
		return person;
	}

	public int getStatus() {
		return status;
	}

	public String getStatusToString() {
		switch (status) {
		case -3:
			return "Annule";
		case -2:
			return "Erreur de livraison";
		case -1:
			return "Erreur de stock";
		case 0:
			return "En attente";
		case 1:
			return "En cours de preparation";
		case 2:
			return "Expidie";
		case 3:
			return "Livre";
		}
		return null;
	}

	public String getAddress() {
		return address;
	}

	public String getRecipient() {
		return recipient;
	}

	public Map<Integer, Integer> getReferencesQuantity() {
		return references_quantity;
	}

	public Date getDate() {
		return date;
	}

	@Override
	public String toString() {
		String temp = "Commande : " + getId() + "\nClient : " + getPerson() + "\nStatus : "
				+ getStatusToString() + "\nAddresse : " + getAddress() + "\nDestinataire : " + getRecipient()
				+ "\nContenu de la commande :";
		for (Integer reference : references_quantity.keySet()) {
			Article article = Bridge.getArticle(reference);
			temp += "\n   Article " + article.getName() + " :\n" + this.references_quantity.get(reference).toString();
		}
		return temp;
	}

	public String toHTML() {
		String temp = "NOT WRITEN YET...";
		return temp;
	}
}
