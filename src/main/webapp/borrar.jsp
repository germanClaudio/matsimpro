<%-- 
    Document   : borrar
    Created on : 31/08/2021, 14:06:11
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utiles.connection"%>
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
        <link rel="stylesheet" href="css/estiloIndex.css"/>
        <title>Eliminar Usuario</title>
    </head>
    <body>
        <%  
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            
            try {
                Connection con = connection.conectar();
                Statement st = con.createStatement();
                String sql = "select * FROM usuarios where id_usuario='"+request.getParameter("id")+"';";
                ResultSet rs = st.executeQuery(sql);
            
                while (rs.next()){
                    out.println("<div class=\"container mt-5\">"
                              + "<svg xmlns=\"http://www.w3.org/2000/svg\" style=\"display: none;\">" 
                              + "<symbol id=\"exclamation-triangle-fill\" fill=\"currentColor\" viewBox=\"0 0 16 16\">"
                              + "<path d=\"M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z\"/>"
                              + "</symbol>"
                              + "</svg>"
                              + "<div class=\"alert alert-danger d-flex align-items-center\" role=\"alert\">"
                              + "<svg class=\"bi flex-shrink-0 me-2\" width=\"24\" height=\"24\" role=\"img\" aria-label=\"Danger:\"><use xlink:href=\"#exclamation-triangle-fill\"/></svg>"
                              + "<div>"
                              + " Esta seguro de querer eliminar el Usuario Id#: <b>" + rs.getInt(1) + "</b><br>Nombre:<b> " + nombre + "</b><br>Username: <b>" + username + "</b><br>Em@il: <b>" + email +" </b>...?"
                              + " <br>Esto hará que elimine el usuario de la BBDD definitivamente!!! <b>Esta acción no se puede deshacer!!</b><br></div>"
                              + " </div>"        
                              + " <div class=\"d-grid gap-2 col-6 mx-auto\">"
                              + " <a href=\"index.jsp?\" class=\"btn btn-primary\"> <i class=\"fa fa-ban\" aria-hidden=\"true\" ></i> No, Cancelar </a>"
                              + " <a href=\"borrarUsuario.jsp?id_usuario=" + rs.getInt(1) + "&nombre_usuario=" + rs.getString("nombre_usuario") + "&username=" + rs.getString("username") + "\" class=\"btn btn-danger\"> <i class=\"fa fa-trash\" aria-hidden=\"true\" ></i> Si, Eliminar </a>"
                              + " </div>");
                }
                
                con.close();
            } catch (SQLException e) {
                out.print("Error al eliminar registro de BD " + e);
            }
        %>
    </body>
</html>
