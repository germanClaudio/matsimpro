<%-- 
    Document   : index
    Created on : 30/08/2021, 09:06:01
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Date"%>
<%@ page import="com.mysql.cj.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="utiles.connection"%>
<%@ page import="utiles.FormatoFecha"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <link rel="stylesheet" href="css/estiloIndex.css"/>
        <title>Web Application DB</title>
    </head>
    <%
         HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
        String fecha = FormatoFecha.formaFecha();
        
        int totalUsers = 0;
        try {
            Connection con = connection.conectar();
            Statement st = con.createStatement();
            String sql = "SELECT count(*) FROM usuarios";
            ResultSet rs= st.executeQuery(sql);
            if(rs.next()){
                totalUsers = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("error db" + e);
        }
    %>
    <body>
        <div class="container mx-auto my-5" id="containerGeneral">
            <div class="container m-3 mx-auto" id="containerSubPannel">
                <h1>Datos Usuarios Registrados <i class="fa fa-user-circle" aria-hidden="true"></i></h1>
                <h5>Conexión a Base Datos Remota</h5>
                <p>Fecha: <%= fecha %></p>
            </div>
            <div class="container m-3 mx-auto" id="containerPanel">
                <nav class="navbar navbar-light mx-auto" id="navBarUser">
                    <a class="navbar-brand" id="navbarBrand">Usuario</a>
                    <form class="form-inline" action="logout.jsp">
                        <a href="datosUsuario.jsp"><i class="fa fa-user-circle" aria-hidden="true"></i>  <%= sesion.getAttribute("username")%></a>
                        <button class="btn btn-danger" type="submit"> Log out <i class="bi bi-box-arrow-left"></i></button>
                        <a href="main.jsp" class="btn btn-secondary" title="Volver"> Volver <i class="fa fa-arrow-circle-left"></i></a>
                    </form>
                </nav>
                <div class="row" id="containerTable">
                    <div class="col-sm-12">
                        <div class="table-responsive">
                            <table class="table table-striped dataTable no-footer dtr-inline details-control" id="tableID" role="grid">
                                <caption>Usuarios Registrados: <b><%=totalUsers%></b></caption>
                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col" colspan="7" class="text-center"> <i class="fa fa-user-circle-o" aria-hidden="true"></i> Usuarios </th>
                                        <th scope="col" colspan="1">
                                            <a href="crear.jsp" class="btn btn-success" title="Nuevo Usuario"> <i class="fa fa-user-plus" aria-hidden="true"></i> New </a>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th scope="col" class="text-center">#Id</th>
                                        <th scope="col" class="text-center">Nombre</th>
                                        <th scope="col" class="text-center">Em@il</th>
                                        <th scope="col" class="text-center">User Name</th>
                                        <th scope="col" class="text-center">Tipo Nivel</th>
                                        <th scope="col" class="text-center">Estatus</th>
                                        <th scope="col" class="text-center">Registrado por</th>
                                        <th scope="col" class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%--                           --%>
                                    <jsp:include page="Usuarios"/>
                                    <%--                           --%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                                <footer><p class="footer" style="color: #000">Developed by Germán Montalbetti ©2021</p></footer>    
    </body>
</html>