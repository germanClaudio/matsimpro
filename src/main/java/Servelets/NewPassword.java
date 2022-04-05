package Servelets;

import java.io.IOException;
import java.sql.*;
import java.sql.PreparedStatement;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import static java.lang.System.out;
import java.util.logging.Level;
import java.util.logging.Logger;
import utiles.connection;

/* @author Germán Montalbetti © <gmontalbetti@prodismo.com> */
@WebServlet(name = "NewPassword", urlPatterns = {"/NewPassword"})

public class NewPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)  //processRequest
			throws ServletException, IOException {
                //processRequest(request, response);       
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                
                HttpSession session = request.getSession();
		String newPassword = request.getParameter("password");
		String confPassword = request.getParameter("confPassword");
                
		RequestDispatcher dispatcher = null;
		if (newPassword != null && confPassword != null && newPassword.equals(confPassword)) {

			try {
                            Connection con = connection.conectar();
                            //Statement st = con.createStatement();
                            String sql = "UPDATE `usuarios` set `password`=" + newPassword + ",`passwordConf`=" + confPassword + " where email='" + (String) session.getAttribute("email") + "';";

                            PreparedStatement pst = con.prepareStatement(sql);
                            
				int rowCount = pst.executeUpdate();
				if (rowCount > 0) {
					request.setAttribute("status", "resetSuccess");
					dispatcher = request.getRequestDispatcher("login.jsp");
				} else {
					request.setAttribute("status", "resetFailed");
					dispatcher = request.getRequestDispatcher("login.jsp");
				}
				dispatcher.forward(request, response);
                                response.sendRedirect("login.jsp");
			
                        } catch (SQLException e) {
				out.print(e);
			} catch (ClassNotFoundException ex) {
                        Logger.getLogger(NewPassword.class.getName()).log(Level.SEVERE, null, ex);
                    }
		} else {
                    request.setAttribute("message","Las constraseñas deben ser iguales, intente otra vez!");
                    dispatcher=request.getRequestDispatcher("newPassword.jsp");
                    dispatcher.forward(request, response);
                }
	}
}
