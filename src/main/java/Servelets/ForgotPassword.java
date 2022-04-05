package Servelets;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import static java.lang.System.out;
import javax.mail.internet.AddressException;

/* @author Germán Montalbetti © <gmontalbetti@prodismo.com> */
@WebServlet(name = "ForgotPassword", urlPatterns = {"/ForgotPassword"})

public class ForgotPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        
        RequestDispatcher dispatcher = null;
        int otpvalue = 0;
        HttpSession sesion = request.getSession();

        //System.out.println(System.getProperty("java.home"));
        if ( email != null ) { //email.equals("") ||
            //sending otp
            Random rand = new Random();
            otpvalue = rand.nextInt(1255650);
            String host = "smtp.gmail.com", //mail.gmail.com
                    //change accordingly
                    port = "465",
                    //uname = "MatSimPro",
                    passW = "tiketeros2022$",
                    passwordApp = "bujbdxhlrxqrncfw",
                    from = "germontalbetti@gmail.com";
            
            // Get the session object
            Properties props = System.getProperties();//new Properties();
            props.put("mail.smtp.user", email);
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port); //465
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.debug", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.socketFactory.port", port); //465
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.fallback", "false");
            props.setProperty("mail.smtp.ssl.trust", host);

            Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, passwordApp);// Put your email & appPassword
                }
            });
            
            session.setDebug(true);
            // compose message
                MimeMessage message = new MimeMessage(session);
                String textEmail = "Your OTP # is: " + otpvalue + "\n\n" +
                    "Este mensaje fue enviado automaticamente por la App MatSimPro para resetear su Password.\n" +
                    "Si Usted no solicitó este cambio, desestime este mensaje e ingrese a la App con el Password fijado anteriormente por Usted.\n\n" +
                    "Muchas gracias por utilizar nuestros servicios.\n" + 
                    "--------------------------------------------------\n" +
                    "El Equipo de MatSimPro"    ;
                try {
                    message.setSubject("MatSimPro-OTP");
                    message.setFrom(new InternetAddress(from));// direccion de donde sale el email
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); // dirección donde enviar el email
                    message.setText(textEmail);
                    
                    //send message
                    Transport.send(message);
                    System.out.println("message sent successfully");
                    
                    Transport transport = session.getTransport("smtps");
                    transport.connect(host, Integer.valueOf(port), email, passW);
                    transport.sendMessage(message, message.getAllRecipients());
                    transport.close();

                } catch (AddressException e) {
                    System.out.print(e);
                    
                } catch (MessagingException e) {
                    System.out.print(e);
                    
                }

            request.getRequestDispatcher("EnterOtp.jsp").forward(request, response);
            dispatcher = (RequestDispatcher) request.getRequestDispatcher("EnterOtp.jsp");
            request.setAttribute("message", "OTP fue enviado correctamente a su casilla de email.");
            sesion.setAttribute("otp", otpvalue);
            sesion.setAttribute("email", email);
            dispatcher.forward(request, response);
            request.setAttribute("status", "success");

        } else {
            out.print("<svg xmlns=\"http://www.w3.org/2000/svg\" style=\"display: none;\">"
                    + "<symbol id=\"exclamation-triangle-fill\" fill=\"currentColor\" viewBox=\"0 0 16 16\">"
                    + "<path d=\"M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z\"/>"
                    + "</symbol>"
                    + "</svg>"
                    + "<div class=\"alert alert-danger d-flex align-items-center\" role=\"alert\">"
                    + "<svg class=\"bi flex-shrink-0 me-2\" width=\"20\" height=\"20\" role=\"img\" aria-label=\"Danger:\"><use xlink:href=\"#exclamation-triangle-fill\"/></svg>"
                    + "<div>"
                    + "No message sent!!!!!!! "
                    + "</div>");
        }
    }
}
