<%-- 
    Document   : retrieve
    Created on : 16/09/2021, 07:45:48
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page language="java"%>
<%@ page session="true"%>
<%@ page import="com.mysql.cj.jdbc.Driver"%>
    
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    <%
        HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
            
    %>
    
    <%
        
        try {
            String driverName = "com.mysql.cj.jdbc.Driver";
            String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
            String usuariodb = "cadcam1_german";
            String passdb = "12345";

            byte[] img = null;
            ServletOutputStream sos = null;

            int id_pieza = Integer.parseInt(request.getParameter("id_pieza"));

            Connection con = null;
            Class.forName(driverName);
            con = DriverManager.getConnection(urldb, usuariodb, passdb);
            //Statement st = con.createStatement();
            PreparedStatement pre1 = con.prepareStatement("select imagen_pieza from `piezas` where id_pieza ='" + id_pieza + "'");

            ResultSet rs1 = pre1.executeQuery();

//                while(rs1.next()){
//
//                    img = rs1.getBytes("imagen_pieza");
//                    response.setContentType("image/png, image/jpg, image/gif");

//                    sos = response.getOutputStream();
//                    sos.write(img);
//                }
                
              while(rs1.next()){  
                  byte[] bin = rs1.getBytes("imagen_pieza");
                  if (bin==null){
                  out.println("NO EXISTE LA IMAGEN");
                    }else{
                  //InputStream inStream = bin.getBinaryStream();
                  InputStream inStream = rs1.getBinaryStream("imagen_pieza");
                  int size = (int)bin.length;
                  byte[] buffer = new byte[size];
                  response.setContentType("image/png, image/jpg, image/gif");
                  response.setContentLength(size);
                  ServletOutputStream ouputStream = response.getOutputStream();
                  int length = -1;
                  while ((length = inStream.read(buffer)) != -1)
                  {
                      ouputStream.write(buffer, 0, length);
                  }
 
                  ouputStream.flush();
                  ouputStream.close();
               }
          }
            
            rs1.close();
            con.close();  
        
        } catch (SQLException e){
                out.println(e.getMessage());
        }

    %>
</body>
</html>
