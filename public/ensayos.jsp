<%-- 
    Document   : ensayos
    Created on : 21/09/2021, 11:18:44
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import=" java.io.IOException"%>
<%@page import=" java.io.PrintWriter"%>
<%@page import=" java.sql.Connection"%>
<%@page import=" java.sql.ResultSet"%>
<%@page import=" java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.SQLException"%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Date"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
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
        <div class="container mt-3" style="background-color: #2233f4; color: white;">
            <h1 class="text-center">Ensayos Registrados <i class="fa fa-thermometer-half" aria-hidden="true"></i></h1>
            <h5>Conexión a Base Datos Remota</h5>
            <p>Fecha: <%= date %></p>
        </div>
        <div class="container mt-3">
            <nav class="navbar navbar-light" style="background-color: #e3f28d;">
                <a class="navbar-brand" style="margin-left: 15px;">Usuario</a>
                <form class="form-inline" action="logout.jsp">
                    <a href="datosUsuario.jsp" style="margin-right: 15px;"><i class="fa fa-user-circle-o" aria-hidden="true"></i>  <%= sesion.getAttribute("username")%></a>
                    <button class="btn btn-danger my-2 my-sm-0 ml-3" type="submit" style="margin-right: 15px;">Log out <i class="bi bi-box-arrow-left"></i></button>
                    <a href="main.jsp" class="btn btn-secondary" style="margin-right: 15px;"> Volver <i class="fa fa-arrow-circle-left" ></i></a>
                </form>
            </nav>
            <nav class="navbar navbar-light" style="background-color: #e3f28d;">
                <form class="form-inline">
                    <label style="margin-left: 15px;">Buscar por nombre de pieza : </label>
                    <input class="form1 form-inline" type="text" name="txtbuscar" placeholder="Buscar todos..." style="margin-right: 15px;">
                    <input class="btn btn-info btn-sm" type="submit" value="Buscar" style="margin-right: 15px;">
                </form>
            </nav>     
            
            <div class="row mt-3">
                <div class="col-sm">

                    <table class="table table-striped">
                        <thead "thead-dark" style="background-color: #e3f2fd;">
                            <tr>
                                <th scope="col" colspan="10" class="text-center" > <i class="fa fa-thermometer-half" aria-hidden="true"></i> Ensayos Registrados </th>
                                <!--<th scope="col">
                                    <a href="crearnuevoensayo.jsp"> <i class="bi bi-plus-circle" aria-hidden="true" ></i>  Agregar Ensayo</a>
                                </th>-->
                            </tr>
                            <tr>
                                <th scope="col" class="text-center">#Id Ensayo</th>
                                <th scope="col" class="text-center">#Id Pieza</th>
                                <th scope="col" class="text-center">Imagen Pieza</th>
                                <th scope="col" class="text-center">Nombre Pieza</th>
                                <th scope="col" class="text-center">Categoria Ensayo</th>
                                <th scope="col" class="text-center">Descripción</th>
                                <th scope="col" class="text-center">Estatus</th>
                                <th scope="col" class="text-center">Fecha</th>
                                <th scope="col" class="text-center">Ultima Modificación</th>
                                <th scope="col" style="width: 14%" class="text-center">Acciones</th>
                            </tr>

                        </thead>
                        <tbody>
                            
                            <%
                        String nombuscar = request.getParameter("txtbuscar");
                        
                        if(nombuscar!=null){%>
                               <jsp:include page="EnsayosRegistradosBuscar"/> 
                            <%
                                }else {
                            %>
                                <jsp:include page="EnsayosRegistrados"/>
                             <% }
                                    %>   
                            <%--    --%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
