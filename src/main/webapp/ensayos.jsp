<%-- 
    Document   : ensayos
    Created on : 21/09/2021, 11:18:44
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="utiles.FormatoFecha"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@ page import="utiles.connection"%>
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
        <link rel="stylesheet" href="css/estiloPiezas.css"/>
        <title>Web Application DB</title>
    </head>
    <%
         HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
        String fecha = FormatoFecha.formaFecha();
        int totalEnsayos = 0;
        try {
            Connection con = connection.conectar();
            Statement st = con.createStatement();
            String sql = "SELECT count(*) FROM ensayos";
            ResultSet rs= st.executeQuery(sql);
            if(rs.next()){
                totalEnsayos = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("error db" + e);
        }
    %>
    <body>
        <div class="container m-5 mx-auto" id="containerGeneral">
            <div class="container my-3 py-4" id="containerSubPannel">
                <h1 class="text-center">Ensayos Registrados <i class="fa fa-thermometer-half" aria-hidden="true"></i></h1>
                <h5>Conexión a Base Datos Remota</h5>
                <p>Fecha: <%= fecha %></p>
            </div>
            <div class="container my-3 mx-auto" id="containerPanel">
                <nav class="navbar navbar-light" id="navBarUser">
                    <a class="navbar-brand" id="navbarBrand">Usuario</a>
                    <form class="form-inline" action="logout.jsp">
                        <a class="me-5" href="datosUsuario.jsp"><i class="fa fa-user-circle-o" aria-hidden="true"></i>  <%= sesion.getAttribute("username")%></a>
                        <button class="btn btn-danger my-2 mx-5" type="submit">Log out <i class="bi bi-box-arrow-left"></i></button>
                        <a href="main.jsp" class="btn btn-secondary ms-5" title="Volver"> Volver <i class="fa fa-arrow-circle-left" ></i></a>
                    </form>
                </nav>
                <nav class="navbar navbar-light" id="navBarSearch">
                    <form class="form-inline">
                        <div class="buscar">
                            <label>Buscar por nombre de pieza : </label>
                            <input class="form1 form-inline me-1" type="text" name="txtbuscar" placeholder="Buscar todos...">
                            <input class="btn btn-info btn-sm" type="submit" value="Buscar">
                        </div>
                    </form>
                </nav>     
                <br><br>
                <div class="row" id="containerTable">
                    <div class="col-sm-12">
                        <div class="table-responsive">
                            <table class="table table-striped dataTable no-footer dtr-inline" role="grid">
                                <caption>Ensayos Registrados: <b><%=totalEnsayos%></b></caption>
                                <thead class="thead-dark">
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
                                        <th scope="col" class="text-center">Categoría Ensayo</th>
                                        <th scope="col" class="text-center">Descripción</th>
                                        <th scope="col" class="text-center">Estatus</th>
                                        <th scope="col" class="text-center">Fecha</th>
                                        <th scope="col" class="text-center">Última Modificación</th>
                                        <th scope="col" class="text-center">Acciones</th>
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
            </div>
                                <p class="footer" style="color: #000">Developed by Germán Montalbetti ©2021</p>
        </div>                      
    </body>
</html>