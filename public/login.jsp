<%-- 
    Document   : login
    Created on : 31/08/2021, 14:28:01
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="java.util.Properties"%>
<%@page import="utiles.Encriptar"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
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
        <link rel="stylesheet" href="css/estilo.css"/>
        <title>Login MatSimPro Web </title>
    </head>
    <%
        Date date = new Date();
    %>

    <body>
    <div class="container mt-5" style="background-color: #858585;" id="containerLogin">
            <center> <img src="images/User.png" class="rounded float" id="imagenLogin" alt=""/></center>    
        <div class="container mt-5" style="background-color: #858585;">
            <h4><center>Login Usuarios</center></h4>
            <h4><center>MatSimPro Web App</center></h4>
            <h6>Conexión a Base Datos Remota Prodismo</h6>
            <p>Fecha: <%=date%></p>
        </div>
            
        <div class="container mt-3" id="form1">
            <div class="row">
                <div class="col-sm">
                    <form method="post" action="login.jsp">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Usuario">
                            <label for="usuario">Usuario</label>
                        </div>
                        <div class="form-floating" id="formGroup">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                            <label for="password">Password</label>
                        </div>
                        <button type="submit" class="btn btn-primary" id="botonLogin" name="login">Login</button>
                        <h4> </h4>
                    </form>
                    <h6> <center>Developed by Germán Montalbetti ©2021</center> </h6>
                    <%
                        Connection con=null;
                        Statement st=null;
                        ResultSet rs=null;
                        //Encriptar enc=new Encriptar();
                        
                        String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
                        String usuariodb = "cadcam1_german"; 
                        String passdb = "12345";
                        
                        if(request.getParameter("login")!=null){
                            String user = request.getParameter("usuario");
                            String password = request.getParameter("password");
                            HttpSession sesion = request.getSession();
                            
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con = DriverManager.getConnection(urldb, usuariodb, passdb);
                                
                                st = con.createStatement();
                                rs= st.executeQuery("SELECT * FROM usuarios where username='" + user + "' and password='" + password + "'; "); //enc.getMD5(
                                    while(rs.next()){
                                        sesion.setAttribute("login", "1");
                                        sesion.setAttribute("username", rs.getString("username"));
                                        sesion.setAttribute("id", rs.getString("id_usuario"));
                                        sesion.setAttribute("estatus", rs.getString("estatus"));
                                        sesion.setAttribute("tipo_nivel", rs.getString("tipo_nivel"));
                                        //response.sendRedirect("index.jsp");
                                        response.sendRedirect("main.jsp");
                                    }
                                    out.print(" <div class=\"alert alert-danger\" role=\"alert\"> <b>Usuario no válido o Password Incorrecto!</b>  </div>");
                            } catch (SQLException e) {
                            
                                out.print(" <div class=\"alert alert-danger\" role=\"alert\"> No se conectó a la base de datos!  </div>");
                                System.out.println("error db" + e);
                            }
                        }
                    %>
                </div>
            </div>
        </div>
      </div>       
    </body>
    
</html>

