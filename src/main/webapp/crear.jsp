<%-- 
    Document   : crear
    Created on : 31/08/2021, 10:18:11
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="utiles.FormatoFecha"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>
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
        <link rel="stylesheet" href="css/estiloNuevaPieza.css"/>
        <title>Crear Nuevo Usuario</title>
    </head>
    <script type="text/javascript">
                    function validate_passwordLenght() {
                        var password = document.getElementById('password').value;
                        
                        if (password.length < 6) {
                            document.getElementById('message1').style.color = 'red';
                            document.getElementById('message1').innerHTML 
                              = '☒ La Contraseña debe tener al menos 6 caracteres';
                            document.getElementById('submit').disabled = true;
                            document.getElementById('submit').style.opacity = (0.4);
                        } else {
                            document.getElementById('message1').style.color = 'green';
                            document.getElementById('message1').innerHTML 
                              = '🗹 Largo de Contraseña aceptable!';
                        }
                    }
                    
                    function validate_password() {
  
                        var pass = document.getElementById('password').value;
                        var confirm_pass = document.getElementById('passwordConf').value;
                        
                        if (pass != confirm_pass) {
                            document.getElementById('message').style.color = 'red';
                            document.getElementById('message').innerHTML = '☒ Confirme la Contraseña';
                            document.getElementById('message2').style.color = 'red';
                            document.getElementById('message2').innerHTML 
                              = '☒ Confirme la Contraseña';
                            document.getElementById('submit').disabled = true;
                            document.getElementById('submit').style.opacity = (0.4);
                        } else {
                            document.getElementById('message').style.color = 'green';
                            document.getElementById('message').innerHTML = '🗹 Las Contraseñas coinciden!!';
                            document.getElementById('message2').style.color = 'green';
                            document.getElementById('message2').innerHTML = '🗹 Las Contraseñas coinciden!!';
                            document.getElementById('submit').disabled = false;
                            document.getElementById('submit').style.opacity = (1);
                        }
                    }

                    function wrong_pass_alert() {
                        if (document.getElementById('password').value != "" && document.getElementById('passwordConf').value != "") {
                            alert("La contraseña se generó exitosamente!!!");
                        } else {
                            alert("Por favor, complete todos los campos!!!");
                        }
                    }
        </script> 
    
    <%
        String fecha = FormatoFecha.formaFecha();
        
        HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
        String username = request.getParameter("username");
        String hidden="";
    
            if (request.getParameter("enviar")!= null){
                //int id_usuario = 0;
                String nombre = request.getParameter("nombre");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String passwordConf = request.getParameter("passwordConf");
                String tiponivel = request.getParameter("tipo_nivel");
                String estatus = request.getParameter("estatus");
                String registradopor = request.getParameter("registrado_por");
                String fechaRegistro = request.getParameter("fecha");

                try {
                    Connection con = connection.conectar();
                    Statement st = con.createStatement();
                    String sql = "insert into usuarios (nombre_usuario,email,username,password, passwordConf,tipo_nivel,estatus,registrado_por,fecha) values ('"+nombre+"','"+email+"','"+username+"','"+password+"','"+passwordConf+"','"+tiponivel+"','"+estatus+"','"+registradopor+"','"+fechaRegistro+"');";
                    int count = st.executeUpdate(sql);

                    if(count >= 0){
                        out.println(  "<svg xmlns=\"http://www.w3.org/2000/svg\" style=\"display: none;\">"
                                    + "<symbol id=\"check-circle-fill\" fill=\"currentColor\" viewBox=\"0 0 16 16\">"
                                    + "<path d=\"M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z\"/>"
                                    + "</symbol>"
                                    + "</svg>"
                                    + "<div class=\"container mt-5\">"
                                    + "<div class=\"alert alert-success d-flex align-items-center\" role=\"alert\">"
                                    + "<svg class=\"bi flex-shrink-0 me-2\" width=\"24\" height=\"24\" role=\"img\" aria-label=\"Success:\"><use xlink:href=\"#check-circle-fill\"/></svg>"
                                    + "<div>Datos ingresados con éxito a la BD! <br>"
                                    + "El usuario: " + nombre + "<br>Em@il: " + email + "<br>Nivel: " + tiponivel + "<br>Estatus: " + estatus + "<br>Fue ingresado con éxito a la BD, por el usuario: " + registradopor + ", en la fecha: " + fechaRegistro + "<br>"
                                    + "<a title=\"Volver\" href=\"index.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                    + "</did>"
                                    + "</did>");
                        hidden="hidden";
                    } else {
                        out.println(  "<div class=\"container mt-5\">"
                                    + "<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo registrar los datos en la BD!! <br>"
                                    + "Esto puede ser debido a que el usuario ya existe o se ingresó algún dato erroneo. <br>"
                                    + "Verifique la información ingresada e intentelo nuevamente por favor.</div>"
                                    + "<a href=\"index.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                    + "</did>");
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
        <div class="container my-5 mx-auto" id="containerGeneral" <%=hidden%>>
            <header>
                <h1>Ingreso Datos Nuevo Usuario <i class="bi bi-person-square"></i></h1>
                <h5>Conexión a Base Datos Remota</h5>
                <p>Fecha: <%= fecha %></p>
            </header>

            <div class="container">
                <div class="row">
                    <div class="col-8 mx-auto">
                        <form action="crear.jsp" method="post">
                            <div class="form-group" id="form1">
                                <label for="nombre">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" aria-describedby="Nombre" placeholder="Nombre" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label for="email">Em@il</label>
                                <input type="text" class="form-control" id="email" name="email" placeholder="Em@il" required="required">
                                <span id="veryImportant" style="color:red">Atención! Este email es el que se utilizará para recuperar su Password luego. </span>
                            </div>
                            <div class="form-group" id="form1">
                                <label for="username">User Name</label>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Nombre de Usuario" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label for="password" id="labelPassword">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required="required" onkeyup="validate_passwordLenght()">
                                <span id="message" style="color:red"> </span> <br>
                                <span id="message1" style="color:red"> </span>
                            </div>
                            <div class="form-group" id="form1">
                                <label for="passwordConf" id="labelPasswordConfirm">Confirmar Password</label>
                                <input type="password" class="form-control" id="passwordConf" name="passwordConf" placeholder="Confirmar Password" required="required" onkeyup="validate_password()">
                                <span id="message2" style="color:red"> </span>
                            </div>
                            <div class="form-group" id="form1">
                                <label for="tipo_nivel">Tipo de Nivel</label>
                                <select class="form-select" id="tipo_nivel" name="tipo_nivel" required>
                                    <option selected disabled value="">Seleccione opción...</option>
                                    <option>Administrador</option>
                                    <option>Procesista</option>
                                    <option>Usuario</option>
                                    <option>Proveedor</option>
                                </select>    
                            </div>
                            <div class="form-group" id="form1">
                                <label for="estatus">Estatus</label>
                            </div>
                            <div class="form-group">
                                <div class="form-check form-check-inline">
                                    <input type="radio" class="form-check-input" id="estatusA" name="estatus" value="Activo" checked>
                                    <label class="custom-control-label" for="estatusA">Activo</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input type="radio" class="form-check-input" id="estatusI" name="estatus" value="Inactivo">
                                    <label class="custom-control-label" for="estatusI">Inactivo</label>
                                </div>
                            </div>

                            <div class="form-group" id="form1">
                                <label for="fecha">Fecha</label>
                                <input type="date" class="form-control" id="fecha" name="fecha" required="required" value="today">
                            </div>
                            <fieldset disabled>
                                <div class="form-group" id="form1">
                                    <label for="registrado_por2">Registrado por</label>
                                    <input type="text" class="form-control" id="registrado_por2" name="registrado_por2" value="<%= session.getAttribute("username")%>">
                                </div>
                            </fieldset>
                            <div class="d-block mx-auto my-3 text-center">
                                <button type="submit" id="submit" name="enviar" class="btn btn-primary mx-auto me-sm-4" style="width: 8rem" onclick="wrong_pass_alert()" disabled>Guardar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                                <button type = "reset" value = "Reset" class="btn btn-info mx-auto" style="width: 8rem">Reset <i class="fa fa-refresh" aria-hidden="true"></i></button>
                                <a href="index.jsp" class="btn btn-secondary mx-auto ms-sm-4" id="form1" style="width: 8rem">Volver <i class="fa fa-arrow-circle-left" aria-hidden="true"></i></a>
                            </div>
                            <div>
                                <input type="hidden" class="form-control" id="registrado_por" name="registrado_por" value="<%= session.getAttribute("username")%>">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <p class="footer">Developed by Germán Montalbetti ©2022</p>
        </div>

        <script type="text/javascript">
                    function setInputDate(_id){
                        var _dat = document.querySelector(_id);
                        var hoy = new Date(),
                            d = hoy.getDate(),
                            m = hoy.getMonth()+1, 
                            y = hoy.getFullYear(),
                            data;

                        if(d < 10){
                            d = "0"+d;
                        };
                        if(m < 10){
                            m = "0"+m;
                        };

                        data = y+"-"+m+"-"+d;
                        console.log(data);
                        _dat.value = data;
                    };
                         setInputDate("#fecha");  
        </script> 
    </body>
</html>
