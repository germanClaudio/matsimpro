<%-- 
    Document   : piezas
    Created on : 14/09/2021, 12:41:03
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
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs5/dt-1.11.3/b-2.0.1/fh-3.2.0/r-2.2.9/datatables.min.css"/>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs5/dt-1.11.3/b-2.0.1/fh-3.2.0/r-2.2.9/datatables.min.js"></script>



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
            <h1 class="text-center">Datos Piezas Registradas <i class="bi bi-gear-wide-connected" aria-hidden="true"></i></h1>
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
                    <label style="margin-left: 15px;">Buscar pieza : </label>
                    <input class="form1 form-inline" type="text" name="txtbuscar" placeholder="Buscar todas..." style="margin-right: 15px;">
                    <input class="btn btn-info btn-sm" type="submit" value="Buscar" style="margin-right: 15px;">
                </form>
            </nav>             
                    
            <div class="row mt-3">
                <div class="col-sm">
                <%--     
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                              <li class="page-item"><a class="page-link" href="#pre">Previa</a></li>
                              <li class="page-item"><a class="page-link" href="/page1">1</a></li>
                              <li class="page-item"><a class="page-link" href="/page2">2</a></li>
                              <li class="page-item"><a class="page-link" href="/page3">3</a></li>
                              <li class="page-item"><a class="page-link" href="/pagesig">Siguiente</a></li>
                            </ul>
                        </nav>--%>
                    <table class="table table-striped" id="table_id">
                        <thead "thead-dark" style="background-color: #e3f2fd;">
                            <tr>
                                <th scope="col" colspan="7" class="text-center" > <i class="bi bi-gear-wide-connected" aria-hidden="true"></i> Piezas Registradas </th>
                                <th scope="col" colspan="2" class="text-center">
                                    <a href="crearnuevapieza.jsp" class="btn btn-success"> <i class="bi bi-plus-circle" aria-hidden="true"></i>  Agregar Nueva Pieza</a>
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

