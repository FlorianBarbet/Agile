package utilisateur;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
/**
 * Classe utilitaire
 * @author Florian BARBET
 *
 */
public class Mail {

	/**
	 * Envoyé un mail grace au bot :D
	 * @param content
	 * @param to
	 */
	public void sendMail(String content, String to){
		Properties props = new Properties();
		//props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", "smtps.univ-lille1.fr");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getDefaultInstance(props,
				new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("florian.barbet","Florian2*");
			}
		});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("florian.barbet@etudiant.univ-lille1.fr"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(to));
			message.setSubject("Activation de votre compte HENDEK");
			message.setContent(content,"text/html");

			Transport.send(message);

			System.out.println("--------------------Success");

		} catch (MessagingException e) {
			System.out.println("--------------------Fail, exception: " + e.getMessage());
			throw new RuntimeException(e);
		}
	}
	
	public void sendMailLivraison(String content, String to){
		Properties props = new Properties();
		//props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", "smtps.univ-lille1.fr");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getDefaultInstance(props,
				new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("florian.barbet","Florian2*");
			}
		});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("florian.barbet@etudiant.univ-lille1.fr"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(to));
			message.setSubject("Votre commande est bien partie !");
			message.setContent(content,"text/html");

			Transport.send(message);

			System.out.println("--------------------Success");

		} catch (MessagingException e) {
			System.out.println("--------------------Fail, exception: " + e.getMessage());
			throw new RuntimeException(e);
		}
	}

	/**
	 * Permet de concevoir le lien d'envoie
	 * @param login clé unique
	 * @param link notre lien d'envoie
	 * @return
	 */
	public boolean selectCheck(String login,ArrayList<String> link){
		String requete = "SELECT ";
		Connection con = null;
		boolean resultat=false;

		requete+="tok,droit,login FROM utilisateur WHERE ";
		requete+="login=?";

		try{
			Class.forName("org.postgresql.Driver");

			String url = "jdbc:postgresql://psqlserv/n2p1";
			String user = "barbetf";
			String mdpasse = "moi";
			con = DriverManager.getConnection(url,user,mdpasse);
			PreparedStatement ps = con.prepareStatement(requete+"");
			ps.setString(1, login);

			ResultSet rs = ps.executeQuery();

			if(rs.next()){
				resultat=true;
				link.add("tok");//1
				link.add(rs.getString("tok"));//2
				link.add("droit");//3
				link.add(rs.getString("droit"));//4
				link.add("login");//5
				link.add(rs.getString("login"));//6
			}

		}catch (Exception e) {

			System.out.println("*** FATAL ERROR FROM SELECTCHECK FROM MAIL"+e.getMessage()+" (1) ");
		}
		finally {	  
			try{
				con.close();	  
			}catch (Exception e) {
				System.out.println("*** FATAL ERROR FROM SELECTCHECK FROM MAIL"+e.getMessage()+" (2) ");
			}
		}

		return resultat;
	}

}
