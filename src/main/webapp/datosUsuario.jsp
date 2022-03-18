<%-- 
    Document   : datosUsuario
    Created on : 31/08/2021, 15:37:39
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utiles.Encriptar"%>
<%@page import="utiles.connection"%>
<%@page import="utiles.FormatoFecha"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/estiloNuevaPieza.css"/>
        <title>Modificar Password Usuario</title>
    </head>
    <%
           HttpSession sesion = request.getSession();
                if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                   response.sendRedirect("login.jsp");
                }
                String fecha = FormatoFecha.formaFecha();
                Object username = session.getAttribute("username");
                String hidden="";
                
                if(request.getParameter("guardar")!=null){
                    String usuario = request.getParameter("usuario");
                    String password1 = request.getParameter("password1");
                    String password2 = request.getParameter("password2");
                    //Encriptar enc=new Encriptar();
                           
                    if(password1.equals(password2) && (password1!=null || password2!=null)){
                        try {
                            Connection con = connection.conectar();
                            String sql = "update usuarios set username='" + usuario + "',password='" + password1 + "' where id_usuario='" + sesion.getAttribute("id") + "';";
                            Statement st = con.createStatement();
                            int count = st.executeUpdate(sql);
                            sesion.setAttribute("usuario", usuario);

                            if(count > 0){
                                out.println("<div class=\"container mt-5\">"
                                          + "<div class=\"alert alert-success\" role=\"alert\"> Datos modificados con éxito en la BD! <br>"
                                          + " El Password del usuario: <b>" + usuario + "</b><br>Fue modificado con éxito!!</div>"
                                          + "<a href=\"main.jsp\" class=\"btn btn-secondary\" id=\"form1\">Cerrar <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                          + "</did>");
                                hidden="hidden";
                            }
                            //response.sendRedirect("main.jsp");
                        } catch (SQLException e) {
                            out.print(e);
                        }
                    }
                    else {
                        out.print("<div class=\"container mt-5\">"
                                + "<svg xmlns=\"http://www.w3.org/2000/svg\" style=\"display: none;\">"
                                + "<symbol id=\"exclamation-triangle-fill\" fill=\"currentColor\" viewBox=\"0 0 16 16\">"
                                + "<path d=\"M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z\"/>"
                                + "</symbol>"
                                + "</svg>"
                                + "<div class=\"alert alert-danger d-flex align-items-center\" role=\"alert\">"
                                + "<svg class=\"bi flex-shrink-0 me-2\" width=\"20\" height=\"20\" role=\"img\" aria-label=\"Danger:\"><use xlink:href=\"#exclamation-triangle-fill\"/></svg>"
                                + "Passwords No coinciden!!"
                                + "</div>"
                                + "<a href=\"datosUsuario.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                + "</div>");
                        hidden="hidden";
                    }
                }
    %>
    <body>
        <div class="container mt-5" id="containerGeneral" <%=hidden%>>
            <header>
                <h1>Datos de Usuarios - Modificar Password</h1>
                <h5>Conexión a Base Datos Remota</h5>
                <p>Fecha: <%= fecha %></p>
            </header>

            <div class="container">
                <div class="row">
                    <div class="col-sm">
                        <form action="datosUsuario.jsp" method="post">
                            <div class="form-group" id="form1">
                                <label >Usuario</label>
                                <input type="text" class="form-control" name="usuariod" value="<%= username %>" disabled>
                                <%--<input type="text" class="form-control" name="usuariod" value="<%= sesion.getAttribute("username")%>" disabled>--%>
                                <input type="hidden" class="form-control" name="usuario" value="<%= username %>">
                            </div>
                            <div class="form-group" id="form1">
                                <label >Password</label>
                                <input type="password" class="form-control" name="password1" placeholder="Password" required>
                            </div>
                            <div class="form-group" id="form1">
                                <label >Repita su Password</label>
                                <input type="password" class="form-control" name="password2" placeholder="Repita su password" required>
                            </div>
                            <button type="submit" name="guardar" class="btn btn-info" id="form1">Guardar <i class="fa fa-floppy-o" aria-hidden="true"></i> </button>
                            <a href="main.jsp" class="btn btn-danger" id="form1"> Cancelar <i class="fa fa-ban"></i></a>
                        </form>
                    </div>
                </div>
            </div>
        </div>            
    </body>
</html>
