package Servelets;

import java.io.IOException;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

/* @author Germán Montalbetti © <gmontalbetti@prodismo.com> */

@WebServlet(name = "ValidateOtp", urlPatterns = {"/ValidateOtp"})

public class ValidateOtp extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  //change service for processRequest
	{
		int value = Integer.parseInt(request.getParameter("otp"));
		HttpSession session = request.getSession();
		int internalOtp = (Integer)session.getAttribute("otp"); //(int)session.getAttribute("otp");
		
		RequestDispatcher dispatcher = null;
		
		if (value==internalOtp) {
                    request.setAttribute("email", request.getParameter("email"));
                    request.setAttribute("status", "success");
                    dispatcher=request.getRequestDispatcher("newPassword.jsp");
                    dispatcher.forward(request, response);
			
		} else {
                    request.setAttribute("message","OTP incorrecto, intente otra vez!");
                    dispatcher=request.getRequestDispatcher("EnterOtp.jsp");
                    dispatcher.forward(request, response);
                }
	}
}
