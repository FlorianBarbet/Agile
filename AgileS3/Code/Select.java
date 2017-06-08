import java.sql.*;

public class Select
{
  public static void main(String args[]) throws Exception
  {
      Connection con=null;
      Statement stmt;
      
      Class.forName("org.postgresql.Driver");

      String url = "jdbc:postgresql://mon_ip:mon_port/ma_base";
      String nom = "change_it";
      String mdp = "change_it";
      con = DriverManager.getConnection(url,nom,mdp);
      stmt = con.createStatement();
      String query = "select * from personne";
      ResultSet rs = stmt.executeQuery(query);
          
      System.out.println("Liste des clients:");
      while (rs.next()) 
      {
              System.out.println(rs.getString(1));
      }
      con.close();
  } 
}
