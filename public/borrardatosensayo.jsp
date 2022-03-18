<%-- 
    Document   : borrardatosensayo
    Created on : 07/10/2021, 08:20:46
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
        <title>Eliminar Ensayo y Datos </title>
    </head>
    <%
        Connection con=null;
        Statement st=null;
        ResultSet rs=null;
        int id_pieza = Integer.parseInt(request.getParameter("id_pieza"));
        int id_ensayo = Integer.parseInt(request.getParameter("id_ensayo"));
        String nombre_pieza = request.getParameter("nombre_pieza");
    %>
    <body>
        <%  
            String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
            String usuariodb = "cadcam1_german"; 
            String passdb = "12345";
            
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(urldb, usuariodb, passdb);
                st = con.createStatement();
                
                rs = st.executeQuery("select * FROM ensayos where id_ensayo='"+ id_ensayo + "'");
                
                while(rs.next()){
                    st.executeUpdate("delete FROM alargamiento where id_ensayo='"+ id_ensayo + "'");
                    st.executeUpdate("delete FROM resistencia where id_ensayo='"+ id_ensayo + "'");
                    st.executeUpdate("delete FROM datos_n_r where id_ensayo='"+ id_ensayo + "'");
                    st.executeUpdate("delete FROM archivos_sim where id_ensayo='"+ id_ensayo + "'");
                    st.executeUpdate("delete FROM ensayos where id_ensayo='"+ id_ensayo + "'");
                    
                            out.print("<div class=\"container mt-5\"> "

                                            + " <div class=\"alert alert-danger\" role=\"alert\"> <b> Se ha eliminado el ensayo de la pieza: " + nombre_pieza + "<br> </b>"
                                            + " y todos los datos asociados a este ensayo!!!<br><br></div>"

                                            + " <div class=\"d-grid gap-2 col-6 mx-auto\">"
                                            + " <a href=\"ensayos.jsp\" class=\"btn btn-success\"> <i class=\"bi bi-gear-wide-connected\" aria-hidden=\"true\" ></i> Aceptar </a>"

                                            + " </div>"
                                    + "</div>"
                                );
                }
                con.close();
            }
            catch(SQLException e){
                //out.print("Error al tratar de eliminar registro de BD " + e);
            }
        %>

    </body>
</html>


