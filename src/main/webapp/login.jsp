<%-- 
    Document   : login
    Created on : 31/08/2021, 14:28:01
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Properties"%>
<%@page import="utiles.Encriptar"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utiles.connection"%>
<%@page import="utiles.FormatoFecha"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="css/estiloLogin.css"/>
        <title>Login MatSimPro Web</title>
        <script src="https://kit.fontawesome.com/618299664c.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    </head>
    <%
        String fecha = FormatoFecha.formaFecha();
    %>
    <body>
        <div class="container my-5 mx-auto" id="containerLogin">
            <img src="images/User.png" class="rounded float" id="imagenLogin" alt=""/>    
            <div class="container my-5 mx-auto">
                <h4>Login Usuarios</h4>
                <h3>MatSimPro Web App</h3>
                <h6>Conexión a Base Datos Remota Prodismo</h6>
                <p>Fecha: <%=fecha%></p>
            </div>
            <div class="container my-3 mx-auto" id="form1">
                <div class="row">
                    <div class="col-12">
                        <form method="post" action="login.jsp">
                            <div class="form-floating my-3 mx-auto">
                                <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Usuario o Em@il">
                                <label for="usuario">Usuario o Em@il</label>
                            </div>
                            
                            <div class="form-floating my-3 mx-auto input-group">
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                                <label for="password">Password</label>
                                <button class="input-group-text"><a href="#" onclick="togglePassword();"><i class="fa-solid fa-eye-slash icon" id="eyeIcon"></i></a></button>
                            </div>
                            
                            <div class="form-group">
                                <a href="forgotPassword.jsp">Forgot password?</a>
                            </div>
                            
                            <button type="submit" class="btn btn-primary" id="botonLogin" name="login" data-bs-toggle="modal" data-bs-target="#staticBackdrop">Login</button>
                        </form>
                        <h6>Developed by Germán Montalbetti ©2021</h6>
                        <%
                            //Encriptar enc=new Encriptar();
                            if(request.getParameter("login")!=null){
                                String user = request.getParameter("usuario");
                                String email = request.getParameter("usuario");
                                String password = request.getParameter("password");
                                HttpSession sesion = request.getSession();

                                try {
                                    Connection con = connection.conectar();
                                    Statement st = con.createStatement();
                                    String sql = "SELECT * FROM usuarios where username='" + user + "' OR email='" + email + "' and password='" + password + "'; ";
                                    ResultSet rs= st.executeQuery(sql); //enc.getMD5(
                                        while(rs.next()){
                                            sesion.setAttribute("login", "1");
                                            sesion.setAttribute("username", rs.getString("username"));
                                            sesion.setAttribute("id", rs.getString("id_usuario"));
                                            sesion.setAttribute("estatus", rs.getString("estatus"));
                                            sesion.setAttribute("tipo_nivel", rs.getString("tipo_nivel"));
                                            response.sendRedirect("main.jsp");
                                        }
                                        out.print("<svg xmlns=\"http://www.w3.org/2000/svg\" style=\"display: none;\">"
                                                + "<symbol id=\"exclamation-triangle-fill\" fill=\"currentColor\" viewBox=\"0 0 16 16\">"
                                                + "<path d=\"M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z\"/>"
                                                + "</symbol>"
                                                + "</svg>"
                                                + "<div class=\"alert alert-danger d-flex align-items-center\" role=\"alert\">"
                                                + "<svg class=\"bi flex-shrink-0 me-2\" width=\"20\" height=\"20\" role=\"img\" aria-label=\"Danger:\"><use xlink:href=\"#exclamation-triangle-fill\"/></svg>"
                                                + "<div>"
                                                + "Usuario no válido o Password Incorrecto!"
                                                + "</div>");                                                
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
                    
    <script type="text/javascript">
        function togglePassword(){
            var tipo = document.getElementById("password");
            
            if (tipo.type == "password"){
                tipo.type = "text";
                $('.icon').removeClass('fa-solid fa-eye-slash');
                $('.icon').addClass('fa-solid fa-eye');
                
            }else{
                tipo.type = "password";
                $('.icon').removeClass('fa-solid fa-eye');
                $('.icon').addClass('fa-solid fa-eye-slash');
            }
        };    
    </script>
    </body>
</html>