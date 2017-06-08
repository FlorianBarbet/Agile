package business;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Bridge {
	private static String db_url = "jdbc:postgresql://psqlserv/n2p1";
	// private static String db_username = "dujardir";
	private static String db_username = "barbetf";
	private static String db_password = "moi";

	private static ResultSet executeQuery(String query) throws Exception {
		System.out.println(query);
		Connection connection = null;
		try {
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection(db_url, db_username, db_password);
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);
			return rs;
		} catch (Exception ex) {
			ex.printStackTrace();
			connection.close();
			throw new Exception(
					"Une erreur est survenu lors de l'execution d'une requette sur la BDD... (" + query + ")");
		} finally {
			connection.close();
		}
	}

	private static void executeUpdate(String query) throws Exception {
		System.out.println(query);
		Connection connection = null;
		try {
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection(db_url, db_username, db_password);
			Statement statement = connection.createStatement();
			statement.executeUpdate(query);
		} catch (Exception ex) {
			ex.printStackTrace();
			connection.close();
			throw new Exception(
					"Une erreur est survenu lors de l'execution d'une requette sur la BDD... (" + query + ")");
		} finally {
			connection.close();
		}
	}

	@SuppressWarnings("unused")
	private static void setDataBase(String url, String username, String password) {
		Connection connection = null;
		try {
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection(url, username, password);
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM person WHERE id=1;");
			if (rs.next()) {
				if (rs.getString("last_name").equals("admin")) {
					db_url = url;
					db_username = username;
					db_password = password;
					System.out.println("BDD change avec succes !");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				connection.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	// Person ########## ########## ########## ########## ########## ##########
	// ########## ########## ########## ##########

	/**
	 * @return Client ou Admin correspondant a l'ID, null si non trouve.
	 * @param id
	 *            ID
	 */
	protected static Person getPerson(int id) {
		try {
			String query = "SELECT * FROM person WHERE id=" + id + ";";
			ResultSet rs = executeQuery(query);

			if (rs.next()) {
				if (rs.getBoolean("is_admin")) {
					return new Admin(new Person(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"),
							rs.getString("mail"), rs.getString("password"), rs.getString("default_adress"),
							rs.getString("phone")));
				} else {
					return new Client(
							new Person(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"),
									rs.getString("mail"), rs.getString("password"), rs.getString("default_adress"),
									rs.getString("phone")),
							rs.getString("credit_card_number"), rs.getDate("credit_card_date"));
				}
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return null;
	}

	/**
	 * @return Client ou Admin correspondant au Mail si le Mot de passe est
	 *         correct, null si non trouve ou Mot de passe incorrect.
	 * @param mail
	 *            Mail
	 * @param password
	 *            Mot de passe
	 */
	public static Person getPerson(String mail, String password) {
		try {
			String query = "SELECT * FROM person WHERE mail=" + mail + ";";
			ResultSet rs = executeQuery(query);

			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					if (rs.getBoolean("is_admin")) {
						return new Admin(new Person(rs.getInt("id"), rs.getString("first_name"),
								rs.getString("last_name"), rs.getString("mail"), rs.getString("password"),
								rs.getString("default_adress"), rs.getString("phone")));
					} else {
						return new Client(
								new Person(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"),
										rs.getString("mail"), rs.getString("password"), rs.getString("default_adress"),
										rs.getString("phone")),
								rs.getString("credit_card_number"), rs.getDate("credit_card_date"));
					}
				}
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return null;
	}

	/**
	 * @return ArrayList contenant toutes les Clients et Admins correspondant au
	 *         filtre
	 * @param filter
	 *            Filtre ecrit en SQL
	 */
	protected static List<Person> getAllPersonsFILTERED(String filter) {
		ArrayList<Person> persons = new ArrayList<>();
		try {

			String query = "SELECT * FROM person";
			if (filter != null) {
				query += filter;
			}
			query += ";";
			ResultSet rs = executeQuery(query);

			while (rs.next()) {
				if (rs.getBoolean("is_admin")) {
					persons.add(new Admin(new Person(rs.getInt("id"), rs.getString("first_name"),
							rs.getString("last_name"), rs.getString("mail"), rs.getString("password"),
							rs.getString("default_adress"), rs.getString("phone"))));
				} else {
					persons.add(new Client(
							new Person(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"),
									rs.getString("mail"), rs.getString("password"), rs.getString("default_adress"),
									rs.getString("phone")),
							rs.getString("credit_card_number"), rs.getDate("credit_card_date")));
				}
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return persons;
	}

	/**
	 * @param id
	 *            ID de la Person a modifier
	 * @param column
	 *            Collone a modifier
	 * @param new_value
	 *            Nouvelle valeur
	 */
	public static void updatePerson(int id, String column, String new_value) {
		try {
			String query = "UPDATE person SET " + column + " = " + new_value + " WHERE id = " + id + ";";
			executeUpdate(query);
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	/**
	 * @return client Client a ajouter
	 */
	public static void addClient(Client client) {
		try {
			int code = (int) Math.random() * 100000000;
			String query = "INSERT INTO unchecked(first_name, last_name, mail, password, code) VALUES ("
					+ client.getFirstName() + ", " + client.getLastName() + ", " + client.getMail() + ", "
					+ client.getPassword() + ", " + code + ", " + new Date(new java.util.Date().getTime()) + ");";
			executeUpdate(query);
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	/**
	 * @param mail
	 *            Mail du client a ajouter
	 * @param code
	 *            Code de validation
	 */
	public static void verifyClient(String mail, int code) {
		try {
			String query = "SELECT * FROM unchecked WHERE mail=" + mail + ";";
			ResultSet rs = executeQuery(query);
			if (rs.next()) {
				if (rs.getString("code").equals(code)) {
					query = "INSERT INTO person(first_name, last_name, mail, password) VALUES ("
							+ rs.getString("first_name") + ", " + rs.getString("last_name") + ", "
							+ rs.getString("mail") + ", " + rs.getString("password") + ");";
					executeUpdate(query);

					query = "DELETE FROM unchecked WHERE mail=" + mail + ";";
					executeUpdate(query);
				}
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	/**
	 * @param mail
	 *            Mail du client a ajouter
	 * @param code
	 *            Code de validation
	 */
	public static void addAdmin(Admin admin) {
		try {
			String query = "INSERT INTO person(is_admin, first_name, last_name, mail, password) VALUES (TRUE, "
					+ admin.getFirstName() + ", " + admin.getLastName() + ", " + admin.getMail() + ", "
					+ admin.getPassword() + ");";
			executeUpdate(query);
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	/**
	 * @param id
	 *            ID � supprimer
	 */
	protected static void removePerson(int id) {
		try {
			String query = "DELETE FROM person WHERE id=" + id + ";";
			executeUpdate(query);
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	// Article ########## ########## ########## ########## ########## ##########
	// ########## ########## ########## ##########

	/**
	 * @return Article correspondant a la Reference, null si non trouve.
	 * @param reference
	 *            Reference
	 */
	public static Article getArticle(int reference) {
		try {
			String query = "SELECT * FROM article WHERE reference=" + reference + ";";
			ResultSet rs = executeQuery(query);

			if (rs.next()) {
				return new Article(rs.getInt("reference"), rs.getString("name"), rs.getString("description"),
						rs.getString("image_url"), rs.getString("brand"), rs.getString("category"),
						rs.getDouble("price"), rs.getDouble("discount"), rs.getInt("quantity"));
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return null;
	}

	public static boolean containsArticle(int reference, int quantity) {
		try {
			String query = "SELECT * FROM article WHERE reference=" + reference + ";";
			ResultSet rs = executeQuery(query);

			if (rs.next()) {
				if (rs.getInt("quantity") >= quantity) {
					return true;
				}
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return false;
	}

	/**
	 * @return ArrayList contenant tout les Articles retournes par la recherche
	 * @param keyword
	 *            Mot cle entre par l'utilisateur
	 * @param searchByName
	 *            Retourne les articles ou le nom correspond
	 * @param searchByBrand
	 *            Retourne les articles ou la marque correspond
	 * @param searchByCategory
	 *            Retourne les articles ou la categorie correspond
	 */
	public static List<Article> searchArticles(String keyword, boolean searchByName, boolean searchByBrand,
			boolean searchByCategory, String sortedBy) {
		if (searchByName == false && searchByBrand == false && searchByCategory == false) {
			return null;
		}
		String filter = " WHERE";
		/*
		 * if (searchByName) { filter += " name LIKE '%" + keyword + "%'"; } if
		 * (searchByName && searchByBrand) { filter += " OR"; } if
		 * (searchByBrand) { filter += " brand LIKE '%" + keyword + "%'"; } if
		 * ((searchByName || searchByBrand) && searchByCategory) { filter +=
		 * " OR"; } if (searchByCategory) { filter += " category LIKE '%" +
		 * keyword + "%'"; }
		 */

		searchByBrand = false;
		if (searchByName) {
			filter += " LOWER(libelle) LIKE LOWER('%" + keyword + "%')";
		}
		if (searchByName && searchByCategory) {
			filter += " OR";
		}
		if (searchByCategory) {
			filter += " LOWER(category) LIKE LOWER('%" + keyword + "%')";
		}

		if (sortedBy != null) {
			filter += " ORDER BY " + sortedBy;
		}

		return getAllArticlesFILTERED(filter);
	}

	/**
	 * @return ArrayList contenant tout les Articles
	 */
	public static List<Article> getAllArticles() {
		return getAllArticlesFILTERED(null);
	}

	/**
	 * @return ArrayList contenant tout les Articles tries
	 * @param column
	 *            Collone
	 */
	public static List<Article> getAllArticlesSortedBy(String column) {
		return getAllArticlesFILTERED(" ORDER BY " + column);
	}

	/**
	 * @return ArrayList contenant tout les Articles correspondant au filtre
	 * @param filter
	 *            Filtre ecrit en SQL
	 */
	public static List<Article> getAllArticlesFILTERED(String filter) {
		ArrayList<Article> articles = new ArrayList<>();
		try {
			String query = "SELECT * FROM article";
			if (filter != null) {
				query += filter;
			}
			query += ";";
			ResultSet rs = executeQuery(query);
			while (rs.next()) {
				/*
				 * articles.add(new Article(rs.getInt("reference"),
				 * rs.getString("name"), rs.getString("description"),
				 * rs.getString("image_url"), rs.getString("brand"),
				 * rs.getString("category"), rs.getDouble("price"),
				 * rs.getDouble("discount"), rs.getInt("quantity")));
				 */
				articles.add(new Article(rs.getInt("idart"), rs.getString("libelle"), rs.getString("description"),
						rs.getString("image"), "", rs.getString("category"), rs.getDouble("prix"),
						rs.getDouble("discount"), rs.getInt("stock")));
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return articles;
	}

	/**
	 * @return article Article a ajouter
	 */
	public static void addArticle(Article article) {
		try {
			String query = "INSERT INTO brand(name) VALUES (" + article.getBrand() + ");";
			executeUpdate(query);

			query = "INSERT INTO category(name) VALUES (" + article.getCategory() + ");";
			executeUpdate(query);

			query = "INSERT INTO article(name, description, image_url, brand, category, price, discount, quantity) VALUES ("
					+ article.getName() + ", " + article.getDescription() + ", " + article.getImageURL()
					+ article.getBrand() + ", " + article.getCategory() + ", " + article.getPrice()
					+ article.getDiscount() + ", " + article.getQuantity() + ");";
			executeUpdate(query);
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	/**
	 * @param reference
	 *            Reference de l'Article a modifier
	 * @param column
	 *            Collone a modifier
	 * @param new_value
	 *            Nouvelle valeur
	 */
	public static void updateArticle(int reference, String column, String new_value) {
		try {
			String query = "UPDATE article SET " + column + " = " + new_value + " WHERE reference = " + reference + ";";
			executeQuery(query);
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	/**
	 * @param reference
	 *            Reference de l'Article a modifier
	 * @param difference
	 *            Quantite a ajouter ou retirer
	 */
	public static void updateArticleQuantity(int reference, int difference) {
		try {
			String query = "SELECT * FROM article WHERE reference=" + reference + ";";
			ResultSet rs = executeQuery(query);

			if (rs.next()) {
				updateArticle(reference, "quantity", Integer.valueOf(rs.getInt("quantity") + difference).toString());
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	// Brand and Category ########## ########## ########## ########## ##########
	// ########## ########## ########## ########## ##########

	/**
	 * @param name
	 *            Nom de la marque
	 */
	public static void addBrand(String name) {
		try {
			String query = "INSERT INTO brand(name) VALUES (" + name + ");";
			executeUpdate(query);
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	/**
	 * @return ArrayList contenant toutes les marques
	 */
	protected static List<String> getAllBrands() {
		ArrayList<String> brands = new ArrayList<>();
		try {
			String query = "SELECT * FROM brand;";
			ResultSet rs = executeQuery(query);

			while (rs.next()) {
				brands.add(rs.getString("name"));
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return brands;
	}

	/**
	 * @param name
	 *            Nom de la categorie
	 */
	public static void addCategory(String name) {
		try {
			String query = "INSERT INTO category(name) VALUES (" + name + ");";
			executeUpdate(query);
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	/**
	 * @return ArrayList contenant toutes les categories
	 */
	protected static List<String> getAllCategories() {
		ArrayList<String> categories = new ArrayList<>();
		try {
			String query = "SELECT * FROM brand;";
			ResultSet rs = executeQuery(query);

			while (rs.next()) {
				categories.add(rs.getString("name"));
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return categories;
	}

	// Order ########## ########## ########## ########## ########## ##########
	// ########## ########## ########## ##########

	/**
	 * @return Order correspondant a l'ID, null si non trouve
	 */
	public static Order getOrder(int id) {
		try {
			Map<Integer, Integer> references_quantity = new HashMap<Integer, Integer>();
			String query = "SELECT * FROM xline WHERE id=" + id + ";";
			ResultSet rs = executeQuery(query);

			while (rs.next()) {
				references_quantity.put(rs.getInt("reference"), rs.getInt("quantity"));
			}

			query = "SELECT * FROM order WHERE id=" + id + ";";
			rs = executeQuery(query);
			if (rs.next()) {
				return new Order(rs.getInt("id"), rs.getInt("client"), rs.getString("recipient"),
						rs.getString("address"), rs.getInt("status"), rs.getDate("xdate"), references_quantity);
			}

		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return null;
	}

	/**
	 * @return Liste des Orders
	 */
	public static ArrayList<Order> getAllOrders() {
		ArrayList<Order> orders = new ArrayList<Order>();

		try {
			String query = "SELECT id FROM order;";
			ResultSet rs = executeQuery(query);

			ArrayList<Integer> ids = new ArrayList<Integer>();

			while (rs.next()) {
				ids.add(rs.getInt("id"));
			}

			for (int id : ids) {
				Map<Integer, Integer> references_quantity = new HashMap<Integer, Integer>();
				query = "SELECT * FROM xline WHERE id=" + id + ";";
				rs = executeQuery(query);

				while (rs.next()) {
					references_quantity.put(rs.getInt("reference"), rs.getInt("quantity"));
				}

				query = "SELECT * FROM order WHERE id=" + id + ";";
				rs = executeQuery(query);
				if (rs.next()) {
					orders.add(new Order(rs.getInt("id"), rs.getInt("client"), rs.getString("recipient"),
							rs.getString("address"), rs.getInt("status"), rs.getDate("xdate"), references_quantity));
				}
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
		return orders;
	}

	/**
	 * @param Order
	 *            Commande a ajouter
	 */
	public static void addOrder(Order order) {
		try {
			String query = "INSERT INTO xorder(person, recipient, address, status, xdate) VALUES (" + order.getPerson()
					+ ", " + order.getRecipient() + ", " + order.getAddress() + ", " + order.getStatus() + ", "
					+ order.getDate() + ");";
			executeUpdate(query);

			query = "SELECT * FROM xorder WHERE id=(SELECT MAX(id) FROM xorder;);";
			ResultSet rs = executeQuery(query);

			int id = 0;

			if (rs.next()) {
				id = rs.getInt("id");
			}

			for (int reference : order.getReferencesQuantity().keySet()) {
				int quantity = order.getReferencesQuantity().get(reference);
				query = "INSERT INTO xline(id, reference, quantity) VALUES (" + id + ", " + reference + ", " + quantity
						+ ");";
				executeUpdate(query);
				updateArticleQuantity(reference, quantity * -1);
			}
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}

	/**
	 * @param id
	 *            ID de l'Order a modifier
	 * @param column
	 *            Collone a modifier
	 * @param new_value
	 *            Nouvelle valeur
	 */
	public static void updateOrder(int id, String column, String new_value) {
		try {
			String query = "UPDATE xorder SET " + column + " = " + new_value + " WHERE id = " + id + ";";
			executeQuery(query);
		} catch (Exception ex) {
			System.out.println("<h1>Erreur : " + ex.getMessage() + "</h1>");
		}
	}
}