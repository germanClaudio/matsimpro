<%-- 
    Document   : piezas
    Created on : 14/09/2021, 12:41:03
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@ page import="utiles.FormatoFecha"%>
<%@ page import="com.mysql.cj.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="utiles.connection"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/estiloPiezas.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs5/dt-1.11.3/b-2.0.1/fh-3.2.0/r-2.2.9/datatables.min.css"/>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs5/dt-1.11.3/b-2.0.1/fh-3.2.0/r-2.2.9/datatables.min.js"></script>
        <title>Web Application DB</title>
    </head>
    <%
         HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
        String fecha = FormatoFecha.formaFecha();
        int totalParts = 0;
        try {
            Connection con = connection.conectar();
            Statement st = con.createStatement();
            String sql = "SELECT count(*) FROM piezas;";
            ResultSet rs= st.executeQuery(sql);
            if(rs.next()){
                totalParts = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("error db" + e);
        }
    %>

    <body>
        <div class="container my-5 mx-auto" id="containerGeneral">
            <div class="container my-3 mx-auto card encabezado" id="containerSubPannel">
                <h1 class="text-center my-3">Datos Piezas Registradas <i class="bi bi-gear-wide-connected" aria-hidden="true"></i></h1>
                <h5>Conexión a Base Datos Remota</h5>
                <p>Fecha: <%= fecha %></p>
            </div>    
            <div class="container my-3 mx-auto" id="containerPanel">
                <nav class="navbar navbar-light" id="navBarUser">
                    <a class="navbar-brand" id="navbarBrand">Usuario</a>
                    <form class="form-inline" action="logout.jsp">
                        <a href="datosUsuario.jsp"> <i class="fa fa-user-circle-o" aria-hidden="true"></i>  <%= sesion.getAttribute("username")%></a>
                        <button class="btn btn-danger" type="submit">Log out <i class="bi bi-box-arrow-left"></i></button>
                        <a href="main.jsp" class="btn btn-secondary" title="Volver"> Volver <i class="fa fa-arrow-circle-left" ></i></a>
                    </form>
                </nav>
                <nav class="navbar navbar-light" id="navBarSearch">
                    <form class="form-inline">
                        <div class="buscar"> 
                            <label>Buscar pieza : </label>
                            <input class="form1 form-inline my-2" type="text" name="txtbuscar" placeholder="Buscar todas...">
                            <input class="btn btn-info btn-sm ms-2" type="submit" value="Buscar">
                        </div>
                    </form>
                </nav>             

                <div class="row" id="containerTable">
                    <div class="col-sm-12">
                        <div class="table-responsive">
                            <table class="table table-striped dataTable no-footer dtr-inline" role="grid">
                                <caption>Piezas Registradas: <b><%=totalParts%></b></caption>
                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col" colspan="7" class="text-center" > <i class="bi bi-gear-wide-connected" aria-hidden="true"></i> Piezas Registradas </th>
                                        <th scope="col" colspan="2" class="text-center">
                                            <a href="crearnuevapieza.jsp" class="btn btn-success" title="Nueva Pieza"> <i class="bi bi-plus-circle" aria-hidden="true"></i> Agregar</a>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th scope="col" class="text-center">#Id</th>
                                        <th scope="col" class="text-center">Nombre</th>
                                        <th scope="col" class="text-center">Material</th>
                                        <th scope="col" class="text-center">Espesor (mm)</th>
                                        <th scope="col" class="text-center">Número</th>
                                        <th scope="col" class="text-center">Imagen</th>
                                        <th scope="col" class="text-center">Descripción</th>
                                        <th scope="col" class="text-center">Ultima Modificación</th>
                                        <th scope="col" class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                String nombuscar = request.getParameter("txtbuscar");
                                if(nombuscar!=null){%>
                                    <jsp:include page="PiezasRegistradasBuscar"/>
                                    <%
                                            }else {
                                    %>
                                    <jsp:include page="PiezasRegistradas"/>
                                    <% }
                                    %> 
                                    <%--   <jsp:include page="PiezasRegistradas"/> --%>
                                </tbody>
                            </table>
                        </div>    
                    </div>
                </div>
            </div>      
            <p class="footer" style="color: #000">Developed by Germán Montalbetti ©2021</p>
        </div>
    </body>
    <script type="text/javascript">
        $(document).ready(function() {
        $('#table_id').DataTable( {
        "processing": true,
        "serverSide": true,
        "ajax": "scripts/server_processing.php"
    } );
} );
    </script>  
</html>

