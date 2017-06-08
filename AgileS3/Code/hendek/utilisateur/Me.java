package hendek.utilisateur;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Me {
	
	private String login;
	private String mdp;//1
	private String nom;//2
	private String prenom;//3
	private String address;//4
	private String mail;//5
	private Date dateins;//6
	private String tel;//7
	private Integer droit;//8
	private String tok;//9
	
	protected Me(String login,String password){
		this.login=login;
		this.mdp=password;
		Connection con=null;
		try{

			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://217.182.171.28:5432/hendek";
			String nom = "hendek";
			String mdp = "hendek";
			con = DriverManager.getConnection(url,nom,mdp);

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			String query = "select * from utilisateur where login="+login+"AND mdp="+password;
			ResultSet rs = stmt.executeQuery(query);

			if(rs.next()){
				this.nom=rs.getString("nom");
				prenom=rs.getString("prenom");
				address=rs.getString("address");
				mail=rs.getString("mail");

				dateins=rs.getDate("dateins");
				tel=rs.getString("tel");
				droit=rs.getInt("droit");
				tok=rs.getString("tok");
			}



		}catch (Exception e) {
			System.out.println("[ERRORme]"+e.getMessage()+"");
		}finally{	  
			try{
				con.close();
			}catch(Exception e){
				System.out.println("[ERRORclose]"+e.getMessage()+"");
			}
		}
	}
	
	public void majMDP(String newPass){
			Connection con=null;
			try{

			    Class.forName("org.postgresql.Driver");
				String url = "jdbc:postgresql://217.182.171.28:5432/hendek";
				String nom = "hendek";
				String mdp = "hendek";
				con = DriverManager.getConnection(url,nom,mdp);

				Statement stmt = con.createStatement();
				stmt = con.createStatement();
				String query ;

				query= "UPDATE article SET ";
				query+="mdp="+newPass+" WHERE login="+login+";";
				
				stmt.executeUpdate(query);
				this.mdp=newPass;
				
			}catch (Exception e) {
				System.out.println("[ERROR]"+e.getMessage()+"");
			}finally{	  
				try{
					con.close();
				}catch(Exception e){
					System.out.println("[ERROR]"+e.getMessage()+"");
				}
		
		}
	}
	
	public String toString(){
		String ret="";
		ret+="Login : "+login+"\n";
		ret+="Nom : "+nom+"  Prenom : "+prenom+"\n";
		ret+="Adresse : "+address+"\n";
		ret+="Mail : "+mail+"\n";
		ret+="tel : "+tel+"\n";
		ret+="droit : "+droit+"\n";
		ret+="token : "+tok+"\n";
		ret+="date inscription : "+dateins+"\n";
		
		return ret;
	}


}
