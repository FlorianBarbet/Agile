package business;

public class Person {
	private final int id;
	private final String first_name;
	private final String last_name;
	private String mail;
	private String password;
	private String default_adress;
	private String phone;

	public Person(int id, String first_name, String last_name, String mail, String password, String default_adress,
			String phone) {
		this.id = id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.mail = mail;
		this.password = password;
		this.default_adress = default_adress;
		this.phone = phone;
	}

	public Person(Person person) {
		this.id = person.id;
		this.first_name = person.first_name;
		this.last_name = person.last_name;
		this.mail = person.mail;
		this.password = person.password;
		this.default_adress = person.default_adress;
		this.phone = person.phone;
	}

	public String getDefaultAdress() {
		return default_adress;
	}

	public void setDefaultAdress(String default_adress) {
		this.default_adress = default_adress;
	}

	public String getFirstName() {
		return first_name;
	}

	public String getLastName() {
		return last_name;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String old_password, String new_password) throws Exception {
		if (this.password.equals(old_password)) {
			this.password = new_password;
		} else {
			throw new Exception("Mot de passe incorrect !");
		}
	}

	public int getId() {
		return id;
	}
}
