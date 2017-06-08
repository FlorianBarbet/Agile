package business;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Cart {
	Map<Integer, Integer> references_quantity;
	double shipping_fee = 0.0;

	public Cart() {
		references_quantity = new HashMap<Integer, Integer>();
	}
	
	public Map<Integer, Integer> getReferencesQuantity() {
		return references_quantity;
	}

	public double getShipping_fee() {
		return shipping_fee;
	}

	public void setShipping_fee(double shipping_fee) {
		this.shipping_fee = shipping_fee;
	}

	public ArrayList<Integer> getAllReferences() {
		ArrayList<Integer> references = new ArrayList<Integer>();
		for (Integer reference : references_quantity.keySet()) {
			references.add(reference);
		}
		return references;
	}

	public ArrayList<Article> getAllArticles() {
		ArrayList<Article> articles = new ArrayList<Article>();
		for (Integer reference : references_quantity.keySet()) {
			articles.add(Bridge.getArticle(reference));
		}
		return articles;
	}

	public void put(int reference, int quantity) {
		if (Bridge.containsArticle(reference, quantity)) {
			references_quantity.put(reference, quantity);
		}
	}

	public void remove(int reference) {
		references_quantity.remove(reference);
	}

	public double getTotalCount() {
		int count = 0;
		for (Integer reference : references_quantity.keySet()) {
			count += references_quantity.get(reference);
		}
		return count;
	}

	public double getTotalPrice() {
		double price = shipping_fee;
		for (Integer reference : references_quantity.keySet()) {
			Article article = Bridge.getArticle(reference);
			if (article != null) {
				price += article.getPrice() * references_quantity.get(reference) * (1 - article.getDiscount());
			}
		}
		return price;
	}

	public double getTotalDiscount() {
		double discount = 0.0;
		for (Integer reference : references_quantity.keySet()) {
			Article article = Bridge.getArticle(reference);
			if (article != null) {
				discount += article.getPrice() * references_quantity.get(reference) * article.getDiscount();
			}
		}
		return discount;
	}
	
	public void resetCart(){
		references_quantity.clear();
		shipping_fee = 0.0;
	}

	@Override
	public String toString() {
		String temp = "Contenu du panier :";
		for (Integer reference : references_quantity.keySet()) {
			Article article = Bridge.getArticle(reference);
			temp += "\n   Article " + article.getName() + " :\n" + this.references_quantity.get(reference).toString();
		}
		return temp;
	}

	public String toHTML() {
		String temp = "<tr><th>Libelle</th><th>Quantite</th><th>Aperçu</th>";
		for (Integer reference : references_quantity.keySet()) {
			Article article = Bridge.getArticle(reference);
			temp += "<tr><td>" + article.getName() + "</td><td>" + article.getReference() + "</td><td><img src=\""
					+ article.getImageURL()
					+ "\" class=\"img-responsive img-thumbnail\" style=\"width:10%; height:auto ; display:inline-block ; float:right \" alt=\""
					+ article.getName() + "\" /></td></tr>\n";

		}
		temp += "<tr><td>Remises :</td><td>" + this.getTotalDiscount() + " </td><td>euros TTC</td></tr>\n";
		temp += "<tr><td>Montant a payé :</td><td>" + this.getTotalPrice() + " </td><td>euros TTC</td></tr>\n";
		return temp;
	}
}
