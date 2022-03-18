<%-- 
    Document   : infositio
    Created on : 14/09/2021, 10:42:42
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>

<%@page import="java.util.Date"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/estilo.css"/>

        <!-- Compiled and minified Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
        <!-- Minified JS library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!-- Compiled and minified Bootstrap JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

        <title>Web Application DB</title>
    </head>

    <%
         HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
        Date date = new Date();
    %>

    <body>
        <div class="container" style="background-color: #758075; width: 90%;" id="containerInfo">
            <div class="container" style="background-color: #23325d; width: 90%; margin-top: 30px; padding: 25px; color: #ffffff;">
                <h1 class="text-center">Información del Sitio</h1>
                <h4>Mat Sim Pro 1.0 webVersion - Conexión a Base Datos Remota</h4>
                <p>Fecha: <%= date %></p>
            </div>

            <div class="container mt-5">
                <nav class="navbar navbar-light" style="background-color: #e3a25d; width: 95%;">
                    <a class="navbar-brand" style="margin-left: 10px;">Usuario</a>
                    <form class="form-inline" action="logout.jsp">
                        <a href="datosUsuario.jsp" style="margin-left: 15px;"><i class="fa fa-user-circle" aria-hidden="true"></i>  <%= sesion.getAttribute("username")%></a>

                        <button class="btn btn-danger my-2 my-sm-0 ml-3" type="submit" style="margin-right: 15px;">Log out <i class="bi bi-box-arrow-left"></i></button>
                        <a href="main.jsp" class="btn btn-secondary" style="margin-right: 15px;"> Volver <i class="fa fa-arrow-circle-left" ></i></a>

                    </form>
                </nav>
            </div>            

            <div id="myCarouselCustom" class="carousel slide" data-ride="carousel" width: 90%;>
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarouselCustom" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarouselCustom" data-slide-to="1"></li>
                    <li data-target="#myCarouselCustom" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="images/Autoform2.jpg" width="400px" height="400px" alt="">
                        <div class="carousel-caption" style="color: #000000">
                            <h3>MatSimPro 1.0 - Web version</h3>
                            <p>Registro de Materiales y Ensayos de Simulación</p>
                            <p>Developed by Germán C. Montalbetti ©</p>
                        </div>
                    </div>

                    <div class="item">
                        <img src="images/Autoform3.jpg" width="500px" height="500px" alt="">
                        <div class="carousel-caption" style="color: #0000ff">
                            <h3 >MatSimPro 1.0</h3>
                            <p>Web version</p>
                            <p>Diseño de entorno y código fuente realizado por</p>
                            <p>Germán C. Montalbetti para Prodismo S.R.L.</p>
                        </div>
                    </div>

                    <div class="item">
                        <img src="images/Autoform1.jpg" width="500px" height="500px" alt="">
                        <div class="carousel-caption" style="color: #0000ff">
                            <h3>MatSimPro 1.0</h3>
                            <p>Base de Datos Registro</p>
                            <p>Materiales de Simulación y pruebas en simulador</p>
                            <p>Developed by Germán C. Montalbetti ©</p>
                        </div>
                    </div>
                </div>

                <!-- Controls -->
                <a class="left carousel-control" href="#myCarousel" data-slide="prev" id="prevBtn">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                    <span class="sr-only">Previo</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" data-slide="next" id="nextBtn">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                    <span class="sr-only">Siguiente</span>
                </a>
            </div>
            <!-- Custom Controls -->
            <a href="javascript:void(0);" id="prevBtn">Previo</a>
            <a href="javascript:void(0);" id="nextBtn">Siguiente</a>        
        </div>              
    </body>

    <script type="text/javascript">
        $('#myCarouselCustom').carousel({
        interval: 4000,
        pause:false,
        wrap:true
        });
        // Go to the previous item
        $("#prevBtn").click(function(){
        $("#myCarouselCustom").carousel("prev");
        });
        // Go to the previous item
        $("#nextBtn").click(function(){
            $("#myCarouselCustom").carousel("next");
        });
    </script>

</html>
