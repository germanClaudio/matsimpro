<%-- 
    Document   : retrievefile
    Created on : 21/09/2021, 12:58:40
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
        try{
        
            String driverName = "com.mysql.cj.jdbc.Driver";
            String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
            String usuariodb = "cadcam1_german";
            String passdb = "12345";
        
            File file = null;
            //ServletOutputStream sos = null;
        
            //int id_pieza = Integer.parseInt(request.getParameter("id_pieza"));
            int id_ensayo = Integer.parseInt(request.getParameter("id_ensayo"));
            
            Connection con = null;
            Class.forName(driverName);
            con = DriverManager.getConnection(urldb, usuariodb, passdb);
            Statement st = con.createStatement();
            PreparedStatement pre1 = con.prepareStatement("select norma_material from `ensayos` where id_ensayo ='" + id_ensayo + "'");

            ResultSet rs1 = pre1.executeQuery();
            
                while(rs1.next()){

                    Blob blob = rs1.getBlob(1);
                    BufferedInputStream is = new BufferedInputStream(blob.getBinaryStream());
                    FileOutputStream fos = new FileOutputStream(file);
                    byte[] buffer = new byte[4096];
                    int r=0;
                    
                    while((r = is.read(buffer))!=-1){
                        fos.write(buffer, 0, r);
                    }
                    fos.flush();
                    fos.close();
                    is.close();
                    blob.free();
                    
                }
                st.close();
            
        }catch (Exception e){
              out.println(e.getMessage());
             }
    %>
</body>
</html>

