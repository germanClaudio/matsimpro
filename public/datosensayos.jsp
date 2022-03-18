<%-- 
    Document   : datosensayos
    Created on : 01/10/2021, 10:32:30
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
        String nombre_pieza = request.getParameter("nombre_pieza");
        String id_ensayo = request.getParameter("id_ensayo");
        String ensayo_categoria = request.getParameter("ensayo_categoria");
        
        Connection con = null;
    
        Statement st = null;
        ResultSet rs = null;
    
        String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
        String usuariodb = "cadcam1_german";
        String passdb = "12345";
    %>
    <body>
        <div class="container mt-5" style="background-color: #2233f4; color: white;">
            <h1 class="text-center">Datos de Ensayos Registrados <i class="fa fa-thermometer-half" aria-hidden="true"></i></h1>
            <h5>Conexión a Base Datos Remota</h5>
            <p>Fecha: <%= date %></p>
        </div>
        <div class="container mt-3">
            <nav class="navbar navbar-light" style="background-color: #e3f28d;">
                <a class="navbar-brand" style="margin-left: 15px;">Usuario</a>
                <form class="form-inline" action="logout.jsp">
                    <a href="datosUsuario.jsp" style="margin-right: 15px;"><i class="fa fa-user-circle-o" aria-hidden="true"></i>  <%= sesion.getAttribute("username")%></a>
                    <button class="btn btn-danger my-2 my-sm-0 ml-3" type="submit" style="margin-right: 15px;">Log out <i class="bi bi-door-open"></i></button>
                    <a href="ensayos.jsp" class="btn btn-secondary" style="margin-right: 15px;"> Volver <i class="fa fa-arrow-circle-left" ></i></a>
                </form>
            </nav>
                    <div>
                        <input type="hidden" name="id_ensayo" value="<%=id_ensayo%>">        
                    </div>
            <div class="row mt-3">
                
                                <table class="table table-sm">
                                    <thead "thead-dark" style="background-color: #e3f2fd;">
                                        <tr>
                                            <th scope="col" colspan="7" class="text-center" > Pieza: <%=nombre_pieza%>  -   Id Ensayo #: <%=id_ensayo%> -   Categoria Ensayo: <%=ensayo_categoria%> </th>
                                        </tr>
                                        <tr>
                                            <th scope="col" colspan="6" class="text-center" > <i class="bi bi-box-arrow-right"></i> Datos Alargamiento </th>
                                            <th scope="col" colspan="1"><a href="editarDatosAlar.jsp?id_ensayo=<%=id_ensayo%>&nombre_pieza=<%=nombre_pieza%>&ensayo_categoria=<%=ensayo_categoria%>" class="btn btn-outline-primary btn-sm"> <i class="bi bi-pen"></i>  Editar Datos Ensayo</a> </th>
                                        </tr>

                                        <tr>
                                            <th scope="col" width="14%" class="text-center">A %</th>
                                            <th scope="col" width="14%" class="text-center">Ag %</th>
                                            <th scope="col" width="14%" class="text-center">Ag 90° %</th>
                                            <th scope="col" width="14%" class="text-center">A 50</th>
                                            <th scope="col" width="14%" class="text-center">A 80</th>
                                            <th scope="col" width="14%" class="text-center">A 80 90</th>
                                            <th scope="col" class="text-center">A 80 min.</th>
                                        </tr>
                                    </thead>
                                    <tr>
                <%
                                        try{
                                            Class.forName("com.mysql.cj.jdbc.Driver");

                                            con = DriverManager.getConnection(urldb, usuariodb, passdb);
                                            st = con.createStatement();
                                            rs = st.executeQuery("SELECT `a_porcentual`, `ag_porcentual`, `ag_90_porcentual`, `a_50`, `a_80`, `a_80_90`, `a_80_minimo` FROM `alargamiento` where id_ensayo='" + id_ensayo + "'");
                                
                                            while (rs.next()) {
                                                out.print(
                                                          "<td scope=\"row\" class=\"text-center\">" + rs.getInt("a_porcentual") + "</td>"
                                                        + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble("ag_porcentual") + "</td>"
                                                        + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble("ag_90_porcentual") + "</td>"
                                                        + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble("a_50") + "</td>"
                                                        + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble("a_80") + "</td>"
                                                        + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble("a_80_90") + "</td>"
                                                        + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble("a_80_minimo") + "</td>"
                                                );        
                                            }   
                                            rs.close();
                                            con.close();

                                        } catch (SQLException e) {
                                            out.print("Error al cargar BD " + e);
                                        } catch (ClassNotFoundException ex) {
                                            out.print("Error al cargar BD, no se encuentra clase mysql " + ex);
                                        }    
                %>    
                                    </tr>
                               </table> 
                                    
                                    <div>
                                        <br>
                                    </div>            
                            
                        <table class="table table-sm">
                                    <thead "thead-dark" style="background-color: #e3f2fd;">
                                        <tr>
                                            <th scope="col" colspan="11" class="text-center" > <i class="bi bi-speedometer"></i> Datos Resistencia </th>
                                            <th scope="col" colspan="3"><a href="editarDatosResis.jsp?id_ensayo=<%=id_ensayo%>&nombre_pieza=<%=nombre_pieza%>&ensayo_categoria=<%=ensayo_categoria%>" class="btn btn-outline-primary btn-sm"> <i class="bi bi-pen"></i>  Editar Datos Ensayo</a> </th>
                                        </tr>
                                        
                                        <tr>
                                            <th scope="col" width="7%" class="text-center">Rm max</th>
                                            <th scope="col" width="7%" class="text-center">Rm min</th>
                                            <th scope="col" width="7%" class="text-center">Rm med</th>
                                            <th scope="col" width="7%" class="text-center">Rm 90°</th>
                                            <th scope="col" width="7%" class="text-center">Rm unico</th>
                                            <th scope="col" width="7%" class="text-center">Sigma 0.2</th>
                                            <th scope="col" width="7%" class="text-center">Lim Elast.</th>
                                            <th scope="col" width="7%" class="text-center">Rp max</th>
                                            <th scope="col" width="7%" class="text-center">Rp min</th>
                                            <th scope="col" width="7%" class="text-center">Rp Prom</th>
                                            <th scope="col" width="7%" class="text-center">Rp unico</th>
                                            <th scope="col" width="8%" class="text-center">L. Flue max</th>
                                            <th scope="col" width="8%" class="text-center">L. Flue min</th>
                                            <th scope="col" class="text-center">L. Flue unico</th>
                                        </tr>
                                    </thead>
                                    <tr>
                <%
                                        try{
                                            Class.forName("com.mysql.cj.jdbc.Driver");

                                            con = DriverManager.getConnection(urldb, usuariodb, passdb);
                                            st = con.createStatement();
                                            rs = st.executeQuery("SELECT * FROM `resistencia` where id_ensayo='" + id_ensayo + "'");
                                
                                        while (rs.next()) {
                                            out.print(
                                                      "<td scope=\"row\" class=\"text-center\">" + rs.getInt(5) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(6) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(7) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(8) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(9) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(10) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(11) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(12) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(13) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(14) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(15) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(16) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(17) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getInt(18) + "</td>"
                                            );        
                                        }   
                                        rs.close();
                                        con.close();

                                        } catch (SQLException e) {
                                            out.print("Error al cargar BD " + e);
                                        } catch (ClassNotFoundException ex) {
                                            out.print("Error al cargar BD, no se encuentra clase mysql " + ex);
                                        }    
                %>    
                                    </tr>
                               </table> 
                                    
                                    <div>
                                        <br>
                                    </div>            
                            
                        <table class="table table-sm">
                                    <thead "thead-dark" style="background-color: #e3f2fd;">
                                        <tr>
                                            <th scope="col" colspan="6" class="text-center" > <i class="bi bi-calendar3"></i> Datos n y r </th>
                                            <th scope="col" colspan="2"><a href="editardatosnyr.jsp?id_ensayo=<%=id_ensayo%>&nombre_pieza=<%=nombre_pieza%>&ensayo_categoria=<%=ensayo_categoria%>" class="btn btn-outline-primary btn-sm"> <i class="bi bi-pen"></i>  Editar Datos Ensayo</a> </th>
                                        </tr>
                                        
                                        <tr>
                                            <th scope="col" width="12%" class="text-center">n0°</th>
                                            <th scope="col" width="13%" class="text-center">n45°</th>
                                            <th scope="col" width="12%" class="text-center">n90°</th>
                                            <th scope="col" width="13%" class="text-center">r0°</th>
                                            <th scope="col" width="12%" class="text-center">r45°</th>
                                            <th scope="col" width="13%" class="text-center">n90°</th>
                                            <th scope="col" width="12%" class="text-center">rm</th>
                                            <th scope="col" class="text-center">Δ r</th>
                                        </tr>
                                    </thead>
                                    <tr>
                <%
                                        try{
                                            Class.forName("com.mysql.cj.jdbc.Driver");

                                            con = DriverManager.getConnection(urldb, usuariodb, passdb);
                                            st = con.createStatement();
                                            rs = st.executeQuery("SELECT * FROM `datos_n_r` where id_ensayo='" + id_ensayo + "'");
                                
                                        while (rs.next()) {
                                            out.print(
                                                      "<td scope=\"row\" class=\"text-center\">" + rs.getDouble(5) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble(6) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble(7) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble(8) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble(9) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble(10) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble(11) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getDouble(12) + "</td>"
                                            );        
                                        }   
                                        rs.close();
                                        con.close();

                                        } catch (SQLException e) {
                                            out.print("Error al cargar BD " + e);
                                        } catch (ClassNotFoundException ex) {
                                            out.print("Error al cargar BD, no se encuentra clase mysql " + ex);
                                        }    
                %>    
                                    </tr>
                               </table>      
                            
                                    <div>
                                        <br>
                                    </div>            
                            
                        <table class="table table-sm">
                                    <thead "thead-dark" style="background-color: #e3f2fd;">
                                        <tr>
                                            <th scope="col" colspan="2" class="text-center" > <i class="bi bi-file-earmark-ppt"></i> Archivos .afd </th>
                                            <th scope="col" colspan="2" > <a href="editarDatosSim.jsp?id_ensayo=<%=id_ensayo%>&nombre_pieza=<%=nombre_pieza%>&ensayo_categoria=<%=ensayo_categoria%>" class="btn btn-outline-primary btn-sm"> <i class="bi bi-pen"></i>  Editar Datos Ensayo</a> </th>
                                        </tr>
                                        
                                        <tr>
                                            <th scope="col" with="20%" class="text-center">url .afd</th>
                                            <th scope="col" with="20%" class="text-center">Nombre .afd</th>
                                            <th scope="col" with="20%" class="text-center">Descripcion</th>
                                            <th scope="col" class="text-center">Semaforo</th>
                                        </tr>
                                    </thead>
                                    <tr>
                <%
                                        try{
                                            Class.forName("com.mysql.cj.jdbc.Driver");

                                            con = DriverManager.getConnection(urldb, usuariodb, passdb);
                                            st = con.createStatement();
                                            rs = st.executeQuery("SELECT * FROM `archivos_sim` where id_ensayo='" + id_ensayo + "'");
                                
                                        while (rs.next()) {
                                            out.print(
                                                      "<td scope=\"row\" class=\"text-center\">" + rs.getString(5) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getString(6) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getString(10) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getString(11) + "</td>"
                                            );        
                                        }   
                                        rs.close();
                                        con.close();

                                        } catch (SQLException e) {
                                            out.print("Error al cargar BD " + e);
                                        } catch (ClassNotFoundException ex) {
                                            out.print("Error al cargar BD, no se encuentra clase mysql " + ex);
                                        }    
                %>    
                                    </tr>
                        </table>
                
                            <div>
                                <br>
                            </div>            
                            
                        <table class="table table-sm">
                                    <thead "thead-dark" style="background-color: #e3f2fd;">
                                        <tr>
                                            <th scope="col" colspan="3" class="text-center" > <i class="bi bi-file-earmark-easel"></i> Archivos .mat </th>
                                        </tr>
                                        
                                        <tr>
                                            <th scope="col" class="text-center">Nombre .mat</th>
                                            <th scope="col" class="text-center">url .mat</th>
                                            <th scope="col" class="text-center">Arch .mat</th>
                                        </tr>
                                    </thead>
                                    <tr>
                <%
                                        try{
                                            Class.forName("com.mysql.cj.jdbc.Driver");

                                            con = DriverManager.getConnection(urldb, usuariodb, passdb);
                                            st = con.createStatement();
                                            rs = st.executeQuery("SELECT * FROM `archivos_sim` where id_ensayo='" + id_ensayo + "'");
                                
                                        while (rs.next()) {
                                            out.print(
                                                      "<td scope=\"row\" class=\"text-center\">" + rs.getString(7) + "</td>"
                                                    + "<td scope=\"row\" class=\"text-center\">" + rs.getString(8) + "</td>" 
                                                    + "<td scope=\"row\" class=\"text-center\">" + "<a href=\"downloadmat.jsp?id_ensayo=" + id_ensayo +  "&nombre_archivo_mat=" + rs.getString(7) + "\" class=\"ml-l\"> <i class=\"fa fa-cloud-download\" aria-hidden=\"true\"></i> Descargar Archivo .mat </a>" + "</td>"
                                                );
                                        }   
                                        rs.close();
                                        con.close();

                                        } catch (SQLException e) {
                                            out.print("Error al cargar BD " + e);
                                        } catch (ClassNotFoundException ex) {
                                            out.print("Error al cargar BD, no se encuentra clase mysql " + ex);
                                        }    
                %>    
                                    </tr>
                        </table>
                            <div>
                                <br>
                            </div>      
            </div>
        </div>
    </body>
</html>
