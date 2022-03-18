<%-- 
    Document   : datosUsuario
    Created on : 31/08/2021, 15:37:39
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>

<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utiles.Encriptar"%>
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
        <link rel="stylesheet" href="css/estilo.css"/>
        <title>Modificar Password Usuario</title>
    </head>
    <%
        Date date = new Date();
    %>    
    <body>
        <div class="container mt-5" style="background-color: #53f2fd;">
            <h1>Datos de Usuarios - Modificar Password</h1>
            <h5>Conexion a Base Datos Remota</h5>
            <p>Fecha: <%= date %></p>
        </div>

        <%
        HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
            Connection con=null;
            Statement st=null;
            ResultSet rs=null;
            
            String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
            String usuariodb = "cadcam1_german"; 
            String passdb = "12345";
        
            String username = request.getParameter("username");

        %>

        <div class="container mt-3">
            <div class="row">
                <div class="col-sm">
                    <form action="datosUsuario.jsp" method="post">
                        <div class="form-group" id="form1">
                            <label >Usuario</label>
                            <input type="text" class="form-control" name="usuariod" value="<%= sesion.getAttribute("username")%>" disabled>
                            <input type="hidden" class="form-control" name="usuario" value="<%= sesion.getAttribute("username")%>">
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
                    <%
                        if(request.getParameter("guardar")!=null){
                            String usuario = request.getParameter("usuario");
                            String password1 = request.getParameter("password1");
                            String password2 = request.getParameter("password2");
                            //Encriptar enc=new Encriptar();
                           
                            if(password1.equals(password2)){
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    con = DriverManager.getConnection(urldb, usuariodb, passdb);
                                    st = con.createStatement();
                                    st.executeUpdate("update usuarios set username='" + usuario + "',password='" + password1 + "' where id_usuario='" + sesion.getAttribute("id") + "';");
                                    sesion.setAttribute("usuario", usuario);
                                    response.sendRedirect("main.jsp");

                                } catch (SQLException e) {
                                    out.print(e);
                                }
                            }
                            else {
                                out.print("<div class=\"container mt-5\">"
                                + " <div class=\"alert alert-danger\" role=\"alert\"> Passwords No coinciden!  </div>");
                            }
                        }
                    %>

                </div>
            </div>
        </div>                
    </body>
</html>
