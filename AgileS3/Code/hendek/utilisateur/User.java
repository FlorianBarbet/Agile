package hendek.utilisateur;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class User {

	private HashMap<String,String> mdp;//1
	private HashMap<String,String> nom;//2
	private HashMap<String,String> prenom;//3
	private HashMap<String,String> address;//4
	private HashMap<String,String> mail;//5
	private HashMap<String,Date> dateins;//6
	private HashMap<String,String> tel;//7
	private HashMap<String,Integer> droit;//8
	private HashMap<String,String> tok;//9

	private static User singleton = null;

	public static User getInstance(){
		if(singleton==null){
			singleton=new User();
		}
		return singleton;
	}

	private User(){
		mdp=new HashMap<>();nom=new HashMap<>();
		prenom=new HashMap<>();address=new HashMap<>();
		mail=new HashMap<>();dateins=new HashMap<>();
		tel=new HashMap<>();droit=new HashMap<>();
		tok=new HashMap<>();Connection con = null;
		try{

			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://217.182.171.28:5432/hendek";
			String nom = "hendek";
			String mdp = "hendek";
			con = DriverManager.getConnection(url,nom,mdp);

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			String query = "select * from utilisateur";
			ResultSet rs = stmt.executeQuery(query);

			while(rs.next()){
				this.mdp.put(rs.getString("login"),rs.getString("mdp"));
				this.nom.put(rs.getString("login"),rs.getString("nom"));
				prenom.put(rs.getString("login"),rs.getString("prenom"));
				address.put(rs.getString("login"),rs.getString("address"));
				mail.put(rs.getString("login"),rs.getString("mail"));

				dateins.put(rs.getString("login"),rs.getDate("dateins"));
				tel.put(rs.getString("login"),rs.getString("tel"));
				droit.put(rs.getString("login"),rs.getInt("droit"));
				tok.put(rs.getString("login"),rs.getString("tok"));
			}



		}catch (Exception e) {
			System.out.println("[ERRORuser]"+e.getMessage()+"");
		}finally{	  
			try{
				con.close();
			}catch(Exception e){
				System.out.println("[ERRORclose]"+e.getMessage()+"");
			}
		}

	}



	public String toString4console(){
		@SuppressWarnings("resource")
		Scanner sc = new Scanner(System.in);
		String login="-1",password="-1";
		String ret="";
		int i=0;

		while(signIn(login,password)==null&&i<5){
			System.out.println("Login : ");
			login=sc.nextLine();
			System.out.println("Mot de passe : ");
			password=sc.nextLine();
			i++;
		}

		if(i>=5)System.out.println("Fin des essais");
		else{
			ret+="Login : "+login+"\n";
			ret+="Nom : "+getNom(login)+"  Prenom : "+getPrenom(login)+"\n";
			ret+="Adresse : "+getAddress(login)+"\n";
			ret+="Mail : "+getMail(login)+"\n";
			ret+="tel : "+getTel(login)+"\n";
			ret+="droit : "+getDroit(login)+"\n";
			ret+="token : "+getToken(login)+"\n";
			ret+="date inscription : "+getInscription(login)+"\n";

		}

		return ret;
	}

	public Me signIn(String pseudo,String password){
		Me ret=null;
		for(String key:mdp.keySet())
			if(pseudo.equals(key)&&password.equals(mdp.get(key))){
				
				
				ret=new Me(key,password);
			
			
			}

		return ret;				
	}

	public boolean inscription(String login,String password,String mail,String address){
		boolean ret=true;
		Connection con=null;
		for(String key:mdp.keySet()){
			if(login.equals(key))
				ret=false;
		}
		if(ret){
			try{

				Class.forName("org.postgresql.Driver");
				String url = "jdbc:postgresql://localhost/psqlserv";
				String nom = "hendek";
				String mdp = "hendek";
				con = DriverManager.getConnection(url,nom,mdp);

				String query = "INSERT INTO utilisateur";
				query+="(login,mdp,mail,address) VALUES(?,?,?,?);";

				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1,login);
				ps.setString(2,password);
				ps.setString(3,mail);
				ps.setString(4,address);
				ps.executeUpdate();

				singleton=new User();

			}catch (Exception e) {
				System.out.println("[ERRORinsc]"+e.getMessage()+"");
			}finally{	  
				try{
					con.close();
				}catch(Exception e){
					System.out.println("[ERRORclose2]"+e.getMessage()+"");
				}
			}
		}

		return ret;
	}


	public String getLog(String login){
		for(String key:mdp.keySet())
			if(key.equals(login))
				return mdp.get(key);
		return null;
	}

	public String getNom(String login){
		for(String key:nom.keySet())
			if(key.equals(login))
				return nom.get(key);
		return null;
	}

	public String getPrenom(String login){
		for(String key:prenom.keySet())
			if(key.equals(login))
				return prenom.get(key);
		return null;
	}

	public String getAddress(String login){
		for(String key:address.keySet())
			if(key.equals(login))
				return address.get(key);
		return null;
	}

	public String getMail(String login){
		for(String key:mail.keySet())
			if(key.equals(login))
				return mail.get(key);
		return null;
	}

	public Date getInscription(String login){
		for(String key:dateins.keySet())
			if(key.equals(login))
				return dateins.get(key);
		return null;
	}

	public String getTel(String login){
		for(String key:tel.keySet())
			if(key.equals(login))
				return tel.get(key);
		return null;
	}

	public int getDroit(String login){
		for(String key:droit.keySet())
			if(key.equals(login))
				return droit.get(key);
		return 0;
	}

	public String getToken(String login){
		for(String key:tok.keySet())
			if(key.equals(login))
				return tok.get(key);
		return null;
	}

	public Map<String,String> getAllLogin(){return mdp;	}//1
	public Map<String,String> getAllName(){return nom;}//2
	public Map<String,String> getAllPrenom(){return prenom;}//3
	public Map<String,String> getAllAddress(){return address;}//4
	public Map<String,String> getAllMail(){return mail;}//5
	public Map<String,Date> getAllInscr(){return dateins;}//6
	public Map<String,String> getAllPhone(){return tel;}//7
	public Map<String,Integer> getAllDroit(){return droit;}//8
	public Map<String,String> getAllToken(){return tok;}//9

}
