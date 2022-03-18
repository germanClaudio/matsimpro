<%-- 
    Document   : borrarDatosEnsayoConfirm
    Created on : 07/10/2021, 08:29:49
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
        <title>Eliminar Ensayo</title>
    </head>
    <%
        Connection con=null;
        Statement st=null;
        ResultSet rs=null;
        int id_ensayo = Integer.parseInt(request.getParameter("id_ensayo"));
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
            
                while (rs.next()){
                    out.print("<div class=\"container mt-5\"> "
                            
                                + " <div class=\"alert alert-danger\" role=\"alert\"> <b> Esta seguro de querer eliminar el ensayo Id#: " + rs.getInt(1) + " - Categoría: " + rs.getString("ensayo_categoria") + " - De la pieza nombre: " + rs.getString("nombre_pieza") + " ??</b>"
                                + " <br>Esto hará que borre todos los datos del ensayo asosiados a este!!!<br><br></div>"
                                
                                + " <div class=\"d-grid gap-2 col-6 mx-auto\">"
                                + " <a href=\"ensayos.jsp?id_pieza=" + rs.getInt(1) + "&nombre_pieza=" + rs.getString("nombre_pieza") + "\" class=\"btn btn-warning\"> <i class=\"bi bi-gear-wide-connected\" aria-hidden=\"true\" ></i> No, Cancelar  </a>"
                                + " <a href=\"borrardatosensayo.jsp?id_ensayo=" + rs.getInt(1) + "&id_pieza=" + rs.getInt(2) + "&nombre_pieza=" + rs.getString("nombre_pieza") + "\" class=\"btn btn-danger\"> <i class=\"fa fa-trash\" aria-hidden=\"true\" ></i> Si, Eliminar </a>"
                                
                                + " </div>"
                            + " </div>"
                    );
                }
            }
            catch(SQLException e){
                out.print("Error al tratar de eliminar registro de BD " + e);
            }
        %>

    </body>
</html>
