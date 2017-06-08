package hendek.article;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class Article {

		private HashMap<Integer,String> desc;
		private HashMap<Integer,String> lib;
		private HashMap<Integer,Double> prix;
		private HashMap<Integer,String> img;
		private HashMap<Integer,String> vendeur;
		private HashMap<Integer,Integer> stock;
		
		
		private int nbArticle=0;
		private static Article singleton=null;
		
		public static Article getInstance(){
			if(singleton==null){
				singleton=new Article();
			}
			return singleton;
		}
		
		
		private Article(){
			prix = new HashMap<>();
			desc = new HashMap<>();
			lib = new HashMap<>();
			img = new HashMap<>();
			vendeur = new HashMap<>();
			stock=new HashMap<>();
			
			Connection con=null;
			
			try{

			    Class.forName("org.postgresql.Driver");
				String url = "jdbc:postgresql://217.182.171.28:5432/hendek";
				String nom = "hendek";
				String mdp = "hendek";
				con = DriverManager.getConnection(url,nom,mdp);

				Statement stmt = con.createStatement();
				stmt = con.createStatement();

				String query = "select * from article";
				ResultSet rs = stmt.executeQuery(query);
				
				while(rs.next()){
					desc.put(rs.getInt("idart"),rs.getString("description"));
					lib.put(rs.getInt("idart"),rs.getString("libelle"));
					prix.put(rs.getInt("idart"),rs.getDouble("prix"));
					img.put(rs.getInt("idart"),rs.getString("image"));
					stock.put(rs.getInt("idart"), rs.getInt("stock"));
					nbArticle++;
				}
				
				rs=stmt.executeQuery("select * from infoart");
				while(rs.next())
					vendeur.put(rs.getInt("idart"), rs.getString("entreprise"));
				
				
				
			}catch (Exception e) {
				System.out.println("[ERROR]"+e.getMessage()+"");
			}finally{	  
				try{
					con.close();
				}catch(Exception e){
					System.out.println("[ERRORclose]"+e.getMessage()+"");
				}
			}
		}
		
		public String toString(){
			String ret="Nombre d'articles : "+nbArticle+"\n--->\n";
			
			for(int key:lib.keySet()){
				
				ret+="Article "+key+" :\n";
				ret+=lib.get(key)+"\nprix : "+prix.get(key)+" €\n";
				ret+="Description : "+desc.get(key)+"\nVendu par : "+vendeur.get(key);
				ret+="\nAperçu : "+img.get(key)+" ";
				ret+="\n------------------------------------------\n";
			}
			
			
			return ret;
			
		}
		
		public void rmArticle(int id){
			
			Connection con=null;
			
			
			try{

			    Class.forName("org.postgresql.Driver");
				String url = "jdbc:postgresql://217.182.171.28:5432/hendek";
				String nom = "hendek";
				String mdp = "hendek";
				con = DriverManager.getConnection(url,nom,mdp);
				Statement stmt = con.createStatement();
				stmt = con.createStatement();
				String query = "DELETE FROM article WHERE idart="+id+";";
				stmt.executeUpdate(query);
				singleton=new Article();
				
			}catch (Exception e) {
				System.out.println("[ERROR2]"+e.getMessage()+"");
			}finally{	  
				try{
					con.close();
				}catch(Exception e){
					System.out.println("[ERRORclose2]"+e.getMessage()+"");
				}
			}
			
		}
		
		public void addArticle(String libelle,Double price,String descr,
				String image,String entreprise,int stock){
			
			Connection con=null;
			int idart=0;
			
			try{

			    Class.forName("org.postgresql.Driver");
				String url = "jdbc:postgresql://217.182.171.28:5432/hendek";
				String nom = "hendek";
				String mdp = "hendek";
				con = DriverManager.getConnection(url,nom,mdp);

				String query = "INSERT INTO article";
				query+="(libelle,description,prix,image) VALUES(?,?,?,?,?);";
				
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1, libelle);
				ps.setString(2, descr);
				ps.setDouble(3, price);
				ps.setString(4, image);
				ps.setInt(5, stock);
				ps.executeUpdate();

				
				
				singleton=new Article();
				
					
				ps = con.prepareStatement("INSERT INTO infoart VALUES (?,?);");
				ps.setInt(0, idart);
				ps.setString(2,entreprise);
				ps.executeUpdate();
				
				vendeur.put(idart,entreprise);
				nbArticle++;
				
			}catch (Exception e) {
				System.out.println("[ERROR2]"+e.getMessage()+"");
			}finally{	  
				try{
					con.close();
				}catch(Exception e){
					System.out.println("[ERRORclose2]"+e.getMessage()+"");
				}
			}
			
		}
		
		public void miseAJour(){
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
				
				
				for(int key:lib.keySet()){
				
				query= "UPDATE article SET ";
				query+="libelle="+lib.get(key)+",description="+desc.get(key)+",stock="+stock.get(key)+",prix="+prix.get(key)+",image="+img.get(key)+" WHERE idart="+key+";";
				
				stmt.executeUpdate(query);
				}
				
				singleton=new Article();
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
		
		
		public void setStock(int id,int modif){
			for(Integer key:stock.keySet())
				if(key==id){
					stock.replace(key, stock.get(key), modif);
					miseAJour();
				}
		}
		
		
		
		public int getStock(int id){
			for(Integer key:stock.keySet())
				if(key==id)
					return stock.get(key);
			return 0;
		}
		
		public String getVendeur(int id){
			for(Integer key:vendeur.keySet())
				if(key==id)
					return vendeur.get(key);
			return null;
		}
		
		public void setImage(int id,String modif){
			for(Integer key:img.keySet())
				if(key==id){
					img.replace(key, img.get(key), modif);
					miseAJour();
				}
		}
		
		public String getImage(int id){
			for(Integer key:img.keySet())
				if(key==id)
					return img.get(key);
			return null;
		}
		
		public void setPrix(int id,double modif){
			for(Integer key:prix.keySet())
				if(key==id){
					prix.replace(key, prix.get(key), modif);
					miseAJour();	
				}
		}
		
		public Double getPrix(int id){
			for(Integer key:prix.keySet())
				if(key==id)
					return prix.get(key);
			return null;
		}
		
		public void setLibelle(int id,String modif){
			for(Integer key:lib.keySet())
				if(key==id){
					lib.replace(key, lib.get(key), modif);
					miseAJour();	
				}
		}
		
		public String getLibelle(int id){
			for(Integer key:lib.keySet())
				if(key==id)
					return lib.get(key);
			return null;
		}
		

		public void setDescription(int id,String modif){
			for(Integer key:desc.keySet())
				if(key==id){
					desc.replace(key, desc.get(key), modif);
					miseAJour();	
				}
		}
		
		public String getDescription(int id){
			for(Integer key:desc.keySet())
				if(key==id)
					return desc.get(key);
			return null;
		}
		
		public int getNbArticle(){
			return nbArticle;
		}
		
		public Map<Integer,Integer> getAllStock(){
			return stock;
		}
		
		public Map<Integer,String> getAllVendeur(){
			return vendeur;
		}
		
		public Map<Integer,String> getAllImage(){
			return img;
		}
		
		public Map<Integer,Double> getAllPrix(){
			return prix;
		}
		
		public Map<Integer,String> getAllDescription(){
			return desc;
		}
		
		public Map<Integer,String> getAllLibelle(){
			return lib;
		}
		
		
		
}
