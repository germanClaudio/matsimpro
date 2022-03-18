<%-- 
    Document   : main
    Created on : 13/09/2021, 14:12:23
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>

<%@page import="java.util.Properties"%>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/estilo.css"/>
        <title>Panel Principal</title>
    </head>

    <%
          String hidden = "";
          String oculto = "";
          HttpSession sesion = request.getSession();
             if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                 response.sendRedirect("login.jsp");
             }
             if( sesion.getAttribute("estatus").equals("Inactivo") && sesion.getAttribute("login").equals("1")){
                 hidden = "hidden";
             } else if( sesion.getAttribute("estatus").equals("Activo") && sesion.getAttribute("tipo_nivel").equals("Procesista")){
                 hidden = "";
                 oculto = "hidden";
             } else {
                 hidden = "";
                 oculto = "";
             }
         Date date = new Date();
    %>

    <body>
        <div class="container mt-5">
            <div class="container" style="background-color: #758575; width: 900px;" id="containerPanel">
                <center> <img src="images/FondoSplash_2.png" class="rounded float" id="imagenLogin" alt=""/></center>    
                    <div class="container mt-5" style="background-color: #858585;">
                        <h3><center>Panel General MatSimPro Web App</center></h3>
                        <h6>Conexión a Base Datos Remota Prodismo</h6>
                        <p>Fecha: <%= date %></p>
                    </div>

                    <nav class="navbar navbar-light" style="background-color: #131255;">
                        <a class="navbar-brand" style="color: white; margin-left: 15px;">Usuario: <%=sesion.getAttribute("tipo_nivel")%>  <%=sesion.getAttribute("estatus")%></a> 
                        <form class="form-inline" action="logout.jsp">
                            <a href="datosUsuario.jsp" style="margin-right: 15px;" <%=hidden%>><i class="fa fa-user-circle" aria-hidden="true"></i>  <%=sesion.getAttribute("username")%></a>
                            <button class="btn btn-danger my-2 my-sm-0 ml-3" type="submit" style="margin-right: 15px;">Log out <i class="bi bi-box-arrow-left"></i></button>
                        </form>
                    </nav>
                            
                <div class="row row-cols-1 row-cols-md-3 g-4" style="margin-right: 25px;" <%=hidden%>>
                    <div class="col" >
                        <div class="card h-80" style="width: 15rem; margin: 40px;" >
                            <center><img src="images/stamping_parts1.jpg" alt="" width="175px" height="130px" id="form1"></center>

                            <div class="card-body">
                                <h5 class="card-title">Cargar Piezas y Ensayos</h5>
                                <p class="card-text">Aquí se podrán cargar piezas del proyecto y agregar ensayos a las mismas.</p>
                                <a href="piezas.jsp" class="btn btn-primary" id="botonLogin">Cargar Piezas y Ensayos</a>
                            </div>
                        </div>
                    </div>    

                    <div class="col" >
                        <div class="card h-80" style="width: 15rem; margin: 40px;">
                            <center><img src="images/User_80x80.png" alt="" width="150px" height="150px" id="form1"></center>

                            <div class="card-body">
                                <h5 class="card-title">Datos de Usuarios</h5>
                                <p class="card-text">Aquí se podrán cargar, eliminar y/o modificar datos de Usuarios.</p>
                                <a href="index.jsp" class="btn btn-primary" id="botonLogin" <%=oculto%>>Usuarios</a>
                            </div>
                        </div>
                    </div>    

                    <div class="col">    
                        <div class="card h-80" style="width: 15rem; margin: 40px;">
                            <center><img src="images/Enayos.jpg" alt="" width="150px" height="125px" id="form1"></center>

                            <div class="card-body">
                                <h5 class="card-title">Carga Datos de Ensayos</h5>
                                <p class="card-text">Aquí se podrán cargar los Datos de los Ensayos de piezas del proyecto.</p>
                                <a href="ensayos.jsp" class="btn btn-primary" id="botonLogin">Cargar Datos Ensayos</a>
                            </div>
                        </div>
                    </div>

                <%--<div class="col">    
                        <div class="card h-80" style="width: 15rem; margin: 40px;">
                            <center><img src="images/EnayosGestion.jpg" alt="" width="150px" height="125px" id="form1"></center>

                            <div class="card-body">
                                <h5 class="card-title">Gestionar Ensayos</h5>
                                <p class="card-text">Aquí se podrá gestionar los Datos de Ensayos cargados.</p>
                                <a href="" class="btn btn-primary" id="botonLogin">Gestionar Ensayos</a>
                            </div>
                        </div>
                    </div>--%>    

                    <div class="col">    
                        <div class="card h-80" style="width: 15rem; margin: 40px; margin-bottom: 15px;">
                            <center><img src="images/Info.png" alt="" width="150px" height="125px" id="form1"></center>

                            <div class="card-body">
                                <h5 class="card-title">Informacion</h5>
                                <p class="card-text">Aquí se podrá ver la información del sitio.</p>
                                <a href="infositio.jsp" class="btn btn-primary" id="botonLogin">Información</a>
                            </div>
                        </div>
                    </div>

                </div>
                            <p> <center>Developed by Germán Montalbetti ©2021 </center></p>            
            </div>        
        
      </div>       
    </body>
</html>
