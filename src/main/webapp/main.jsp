<%-- 
    Document   : main
    Created on : 13/09/2021, 14:12:23
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utiles.FormatoFecha"%>
<%@page import="utiles.connection"%>
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
        <link rel="stylesheet" href="css/estiloMain.css"/>
        <title>Panel Principal</title>
    </head>

    <%
      String hidden = "";
      String oculto = "";
      String ocultoProv = "";
      HttpSession sesion = request.getSession();
        if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
            response.sendRedirect("login.jsp");
        }
        if( sesion.getAttribute("estatus").equals("Inactivo") && sesion.getAttribute("login").equals("1")){
            hidden = "hidden";
        } else if( sesion.getAttribute("estatus").equals("Activo") && sesion.getAttribute("tipo_nivel").equals("Procesista") || sesion.getAttribute("tipo_nivel").equals("Usuario")){
            hidden = "";
            oculto = "hidden";
        }  else if( sesion.getAttribute("estatus").equals("Activo") && sesion.getAttribute("tipo_nivel").equals("Proveedor") || sesion.getAttribute("tipo_nivel").equals("Usuario")){
            hidden = "";
            oculto = "hidden";
            ocultoProv = "hidden";
        } else {
            hidden = "";
            oculto = "";
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
        
        int totalParts = 0;
        try {
            Connection con = connection.conectar();
            Statement st = con.createStatement();
            String sql = "SELECT count(*) FROM piezas";
            ResultSet rs= st.executeQuery(sql);
            if(rs.next()){
                totalParts = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("error db" + e);
        }
        
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
        <div class="container mt-5" id="containerGeneral">
            <div class="container" id="containerPanel">
                <center> <img src="images/FondoSplash_2.png" class="rounded float" id="imagenLogin" alt="Logo MatSimPro"/></center>    
                    <div class="container mt-5" id="containerSubPannel">
                        <h4>Panel General MatSimPro Web App</h4>
                        <h6>Conexión a Base Datos Remota Prodismo</h6>
                        <p>Fecha: <%= fecha %></p>
                    </div>

                    <nav class="navbar navbar-light" id="navBarUser">
                        <a class="navbar-brand" id="navbarBrand">Usuario: <%=sesion.getAttribute("tipo_nivel")%>  <%=sesion.getAttribute("estatus")%></a> 
                        <form class="form-inline float" action="logout.jsp">
                            <a href="datosUsuario.jsp" <%=hidden%>><i class="fa fa-user-circle" aria-hidden="true"></i>  <%=sesion.getAttribute("username")%></a>
                            <button class="btn btn-danger" type="submit">Log out <i class="bi bi-box-arrow-left"></i></button>
                        </form>
                    </nav>
                            
                <div class="row row-cols-1 row-cols-md-3 g-4" id="containerCards" <%=hidden%>>
                    <div class="col" id="cardParts" <%=ocultoProv%>>
                        <div class="card h-80" id="cardH80">
                            <img src="images/stamping_parts1.jpg" alt="Stamping Parts" id="form1"/>
                            <div class="card-body">
                                <h5 class="card-title">Piezas y Ensayos</h5>
                                <p class="card-text">Cargar piezas del proyecto y agregar ensayos.</p>
                                <p class="card-text">Piezas Registradas: <span class="badge rounded-pill bg-success text-white"><%=totalParts%></span></p>
                                <a title="Cargar Piezas y Ensayos" href="piezas.jsp" class="btn btn-primary" style="width: 100%;">Ver Todos</a>
                            </div>
                        </div>
                    </div>    

                    <div class="col" id="cardParts" <%=oculto%> <%=ocultoProv%>>
                        <div class="card h-80" id="cardH80">
                            <img src="images/User_80x80.png" alt="Datos Usuarios" id="form1"/>
                            <div class="card-body">
                                <h5 class="card-title">Datos de Usuarios</h5>
                                <p class="card-text">Crear, eliminar y/o modificar datos de Usuarios.</p>
                                <p class="card-text">Usuarios Registrados: <span class="badge rounded-pill bg-success text-white"><%=totalUsers%></span></p>
                                <a title="Datos de Usuarios" href="index.jsp" class="btn btn-warning" style="width: 100%;">Usuarios</a>
                            </div>
                        </div>
                    </div>    

                    <div class="col" id="cardParts">    
                        <div class="card h-80" id="cardH80">
                            <img src="images/Enayos.jpg" alt="Ensayos" width="150px" height="125px" id="form1"/>
                            <div class="card-body">
                                <h5 class="card-title">Datos de Ensayos</h5>
                                <p class="card-text">Cargar Datos de Ensayos de piezas del proyecto.</p>
                                <p class="card-text">Ensayos Registrados: <span class="badge rounded-pill bg-success text-white"><%=totalEnsayos%></span></p>
                                <a title="Cargar Datos de Ensayos" href="ensayos.jsp" class="btn btn-primary" style="width: 100%;">Ver Todos</a>
                            </div>
                        </div>
                    </div>
                        
                    <div class="col" id="cardParts">    
                        <div class="card h-80" id="cardH80">
                            <img src="images/construction2.jpg" alt="Página en construcción" width="150px" height="125px" id="form1"/>
                            <div class="card-body">
                                <h5 class="card-title">Estadísticas</h5>
                                <p class="card-text">.....</p>
                                <a title="Pagina en construcción" href="404.html" class="btn btn-primary" style="width: 100%;">Go..</a>
                            </div>
                        </div>
                    </div>    
    
                    <div class="col" id="cardParts">    
                        <div class="card h-80" id="cardH80">
                            <img src="images/Info.png" alt="Info Sitio" width="150px" height="125px" id="form1"/>
                            <div class="card-body">
                                <h5 class="card-title">Información</h5>
                                <p class="card-text">Ver información del sitio.</p>
                                <a title="Ver Info Sitio" href="infositio.jsp" class="btn btn-info" style="width: 100%;">Información</a>
                            </div>
                        </div>
                    </div>
                </div>
                            <p class="footer">Developed by Germán Montalbetti ©2021</p>            
            </div>        
        </div>       
    </body>
</html>
