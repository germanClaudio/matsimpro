<%-- 
    Document   : infositio
    Created on : 14/09/2021, 10:42:42
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="utiles.FormatoFecha"%>
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
        <link rel="stylesheet" href="css/estiloInfo.css"/>

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
        String fecha = FormatoFecha.formaFecha();
    %>
    <body>
        <div class="container mt-5" id="containerGeneral">
            <div class="container mt-3" id="containerSubPannel">
                <h1 class="text-center">Información del Sitio</h1>
                <h4>Mat Sim Pro 1.0 webVersion - Conexión a Base Datos Remota</h4>
                <p>Fecha: <%= fecha %></p>
            </div>
            <div class="container mt-3" id="containerPanel">
                <nav class="navbar navbar-light" id="navBarUser">
                    <a class="navbar-brand" id="navbarBrand">Usuario</a>
                    <form class="form-inline" action="logout.jsp">
                        <a href="datosUsuario.jsp"><i class="fa fa-user-circle" aria-hidden="true"></i>  <%= sesion.getAttribute("username")%></a>
                        <button class="btn btn-danger" type="submit">Log out <i class="bi bi-box-arrow-left"></i></button>
                        <a title="Volver" href="main.jsp" class="btn btn-secondary"> Volver <i class="fa fa-arrow-circle-left" ></i></a>
                    </form>
                </nav>
            </div>            
            <!-- Slideshow container -->
            <div class="slideshow-container">

                <!-- Full-width images with number and caption text -->
                <div class="mySlides fade">
                    <div class="numbertext">1 / 3</div>
                    <img src="images/Autoform1.jpg" style="width:100%">
                    <div class="text">MatSimPro 1.0 - Web version <br>Registro de Materiales y Ensayos de Simulación</div>
                </div>

                <div class="mySlides fade">
                    <div class="numbertext">2 / 3</div>
                    <img src="images/Autoform2.jpg" style="width:100%">
                    <div class="text">MatSimPro 1.0 <br>Diseño de entorno y código fuente realizado por <br>Germán C. Montalbetti para Prodismo S.R.L.</div>
                </div>

                <div class="mySlides fade">
                    <div class="numbertext">3 / 3</div>
                    <img src="images/Autoform3.jpg" style="width:100%">
                    <div class="text">MatSimPro 1.0 <br>Base de Datos Registro <br>Materiales de Simulación y pruebas en simulador <br>Developed by Germán C. Montalbetti ©2021
                    </div>
                </div>
                <!-- Next and previous buttons 
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>-->
            </div>
            <br>
                <!-- The dots/circles -->
                <div style="text-align:center">
                    <span class="dot" onclick="currentSlide(1)"></span>
                    <span class="dot" onclick="currentSlide(2)"></span>
                    <span class="dot" onclick="currentSlide(3)"></span>
                </div> 
                <div class="containerPanel">
                    <p class="footer">Developed by Germán Montalbetti ©2021</p>
                </div>
            
        </div>              
    </body>
    <script type="text/javascript">
                var slideIndex = 0;
                showSlides();

                function showSlides() {
                  var i;
                  var slides = document.getElementsByClassName("mySlides");
                  var dots = document.getElementsByClassName("dot");
                  for (i = 0; i < slides.length; i++) {
                    slides[i].style.display = "none";  
                  }
                  slideIndex++;
                  if (slideIndex > slides.length) {slideIndex = 1;}    
                  for (i = 0; i < dots.length; i++) {
                    dots[i].className = dots[i].className.replace(" active", "");
                  }
                  slides[slideIndex-1].style.display = "block";  
                  dots[slideIndex-1].className += " active";
                  setTimeout(showSlides, 6000); // Change image every 6 seconds
                }
    </script>
</html>
