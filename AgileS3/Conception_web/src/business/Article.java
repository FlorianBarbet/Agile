package business;

public class Article {
	private final int REFERENCE;
	private String name;
	private String description;
	private String image_url;
	private String brand;
	private String category;
	private double price;
	private double discount;
	private int quantity;

	public Article(String name, String description, String image_url, String brand, String category, double price,
			double discount, int quantity) {
		this.REFERENCE = -1;
		this.name = name;
		this.description = description;
		this.image_url = image_url;
		this.brand = brand;
		this.category = category;
		this.price = price;
		this.discount = discount;
		this.quantity = quantity;
	}

	public Article(int reference, String name, String description, String image_url, String brand, String category,
			double price, double discount, int quantity) {
		this.REFERENCE = reference;
		this.name = name;
		this.description = description;
		this.image_url = image_url;
		this.brand = brand;
		this.category = category;
		this.price = price;
		this.discount = discount;
		this.quantity = quantity;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageURL() {
		return image_url;
	}

	public void setImageURL(String image_url) {
		this.image_url = image_url;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		if (discount > 0 && discount < 1) {
			this.discount = discount;
		}
	}

	public double getDiscountedPrice() {
		return price * (1 - discount);
	}

	public int getReference() {
		return REFERENCE;
	}

	public String getName() {
		return name;
	}

	public String getBrand() {
		return brand;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		String temp = "Reference : " + this.REFERENCE;
		temp += "\nNom : " + this.name;
		temp += "\nDescription : " + this.description;
		temp += "\nURL de l'image : " + this.image_url;
		temp += "\nMarque : " + this.brand;
		temp += "\nCategorie : " + this.category;
		temp += "\nPrix : " + this.price;
		temp += "\nRemise : " + this.discount;
		System.out.println(temp);
		return temp;
	}

	public String toHTML() {
		String temp = "NOT WRITEN YET...";
		return temp;
	}
}
