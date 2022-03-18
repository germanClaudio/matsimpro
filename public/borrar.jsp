<%-- 
    Document   : borrar
    Created on : 31/08/2021, 14:06:11
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>

<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/estilo.css"/>
        <title>Web Application DB</title>
    </head>
    <%
        Connection con=null;
        Statement st=null;
        //ResultSet rs=null;
        
    %>
    <body>
        <%  
            String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
            String usuariodb = "cadcam1_german"; 
            String passdb = "12345";
            
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(urldb, usuariodb, passdb);
                
                st = con.createStatement();
                int count = st.executeUpdate("delete FROM usuarios where id_usuario='"+request.getParameter("id")+"';");
                //request.getRequestDispatcher("index.jsp").forward(request, response);                   
                                
                if(count >= 0){
                out.println("<!DOCTYPE html>");
                                            out.println("<html>");
                                            out.println("<head>");
                                            out.println("<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"images/FondoSplash_2.ico\"/>");
                                            out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
                                            out.println("<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU\" crossorigin=\"anonymous\">");
                                            out.println("<link href=\"https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\" rel=\"stylesheet\" integrity=\"sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN\" crossorigin=\"anonymous\">");
                                            out.println("<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css\">");
                                            out.println("<link rel=\"stylesheet\" href=\"css/estilo.css\"/>");
                                            //out.println("<meta http-equiv='refresh' content='5;URL=ensayos.jsp'>");//redirects after 5 seconds
                                            out.println("<title>Eliminar Usuario</title>");            
                                            out.println("</head>");
                                            out.println("<body>");
                                            out.println("<div class=\"container mt-5\">");
                                            out.println("<div class=\"alert alert-success\" role=\"alert\"> Usuario " + nombre + " Eliminado con Exito de la BD! <br>"
                                                    + " El usuario: " + nombre + " con los datos email: " + email + " y username: " + username + ", fue eliminado con éxito de la Base de Datos. </div>");
                                            out.println("<a href=\"index.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                            out.println("</did>");
                                            out.println("</body>");
                                            out.println("</html>");
                                            
                                        } else {
                                            out.println(" <div class=\"alert alert-danger\" role=\"alert\"> No se pudo eliminar el usuario " + nombre + " de la BD!  </div>");
                                        }
                    st.close();
                    con.close();
            } catch (SQLException e) {
                out.print("Error al eliminar registro de BD " + e);
            }
        %>
    </body>
</html>
