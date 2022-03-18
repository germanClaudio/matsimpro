<%-- 
    Document   : crear
    Created on : 31/08/2021, 10:18:11
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>

<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
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
        <title>Crear Usuario Web Application</title>
    </head>
    <%
        Date date = new Date();
        
        HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
        
        String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
        String usuariodb = "cadcam1_german"; 
        String passdb = "12345";
        
        String username = request.getParameter("username");
        String hidden="";
    
                        if (request.getParameter("enviar")!= null){
                            //int id_usuario = 0;
                            String nombre = request.getParameter("nombre");
                            String email = request.getParameter("email");
                            String password = request.getParameter("password");
                            String tiponivel = request.getParameter("tipo_nivel");
                            String estatus = request.getParameter("estatus");
                            String registradopor = request.getParameter("registrado_por");
                            String fecha = request.getParameter("fecha");
                            
                            try {
                                Connection con=null;
                                Statement st=null;

                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con = DriverManager.getConnection(urldb, usuariodb, passdb);
                                st = con.createStatement();
                                int count = st.executeUpdate("insert into usuarios (nombre_usuario,email,username,password,tipo_nivel,estatus,registrado_por,fecha) values ('"+nombre+"','"+email+"','"+username+"','"+password+"','"+tiponivel+"','"+estatus+"','"+registradopor+"','"+fecha+"');");

                                if(count >= 0){
                                    out.println("<div class=\"container mt-5\">");
                                    out.println("<div class=\"alert alert-success\" role=\"alert\"> Datos ingresados con éxito a la BD! <br>"
                                            + " El usuario: " + nombre + "<br>Em@il: " + email + "<br>Nivel: " + tiponivel + "<br>Estatus: " + estatus + "<br> Fue ingresado con éxito a la BD, por el usuario: " + registradopor + ", en la fecha: " + fecha + " </div> ");
                                    out.println("<a href=\"index.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                    out.println("</did>");
                                    hidden="hidden";
                                } else {
                                    out.println("<div class=\"container mt-5\">");
                                    out.println("<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo registrar los datos en la BD. <br>"
                                            + " Esto puede ser debido a que el usuario ya existe o se ingreso algún dato erroneo. <br>"
                                            + " Verifique la información ingresada e intentelo nuevamente por favor. </div> ");
                                   out.println("<a href=\"index.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                    out.println("</did>");
                                    hidden="hidden";
                                }
                            st.close();
                            con.close();
                                //request.getRequestDispatcher("index.jsp").forward(request, response);                            

                            } catch (SQLException e) {
                            out.print("Error al guardar usuario en BD " + e);
                            }
                        }
                    %>
    <body>
        <div <%=hidden%>>
            <div class="container mt-3"style="background-color: #53f2fd;">
                <h1>Ingreso Datos Usuario</h1>
                <h5>Conexion a Base Datos Remota</h5>
                <p>Fecha: <%= date %></p>
            </div>
        
        
            <div class="container mt-3" >
                <div class="row">
                    <div class="col-sm">

                        <form action="crear.jsp" method="post">
                            <div class="form-group" id="form1">
                                <label for="nombre">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" aria-describedby="Nombre" placeholder="Nombre" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label for="email">Em@il</label>
                                <input type="text" class="form-control" id="email" name="email" placeholder="Em@il" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label for="username">User Name</label>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Nombre de Usuario" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label for="tipo_nivel">Tipo de Nivel</label>
                                <select class="form-select" id="tipo_nivel" name="tipo_nivel" required>
                                    <option selected disabled value="">Seleccione opción...</option>
                                    <option>Administrador</option>
                                    <option>Procesista</option>
                                    <option>Proveedor</option>
                                </select>    
                            </div>
                            <div class="form-group" id="form1">
                                <label for="estatus">Estatus</label>
                            </div>
                            <div class="form-group" >
                                <div class="form-check form-check-inline">
                                    <input type="radio" class="form-check-input" id="estatusA" name="estatus" value="Activo" checked>
                                    <label class="custom-control-label" for="estatusA">Activo</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input type="radio" class="form-check-input" id="estatusI" name="estatus" value="Inactivo">
                                    <label class="custom-control-label" for="estatusI">Inactivo</label>
                                </div>
                            </div>

                            <fieldset disabled>
                            <div class="form-group" id="form1">
                                <label for="registrado_por2">Registrado por</label>
                                <input type="text" class="form-control" id="registrado_por2" name="registrado_por2" value="<%= session.getAttribute("username")%>">
                            </div>
                            </fieldset>
                            <div class="form-group" id="form1">
                                <label for="fecha">Fecha</label>
                                <input type="date" class="form-control" id="fecha" name="fecha" required="required">
                            </div>
                            <div style="margin-bottom: 100px;">    
                                <button type="submit" id="form1" name="enviar" class="btn btn-primary">Guardar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                                <a href="index.jsp" class="btn btn-secondary" id="form1">Volver <i class="fa fa-arrow-circle-left" aria-hidden="true"></i></a>
                            </div>
                            
                            <div class="form-group" id="form1">
                                <input type="hidden" class="form-control" id="registrado_por" name="registrado_por" value="<%= session.getAttribute("username")%>" required="required">
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>        
    </body>
</html>
