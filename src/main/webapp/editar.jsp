<%-- 
    Document   : editar
    Created on : 31/08/2021, 12:35:52
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="utiles.FormatoFecha"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utiles.connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="css/estiloNuevaPieza.css"/>
        <title>Editar Usuario Web App</title>
    </head>
    <%
        String fecha = FormatoFecha.formaFecha();
        
        String id = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String tipoNivel = request.getParameter("tipo_nivel");
        String estatus = request.getParameter("estatus");
        String registradopor = request.getParameter("registrado_por");
        String fechaRegistro = request.getParameter("fecha");
        
        String hidden="";
        String checkedActivo="";
        String checkedInactivo="";
        
        if (estatus.equals("Activo")){
                checkedActivo="checked";
                checkedInactivo="";
        } else {
                checkedActivo="";
                checkedInactivo="checked";
        }
            if (request.getParameter("enviar") != null) {
                try {
                    Connection con = connection.conectar();
                    Statement st = con.createStatement();
                    String sql = "update usuarios set nombre_usuario='" + nombre + "',email='" + email + "',username='" + username + "',tipo_nivel='" + tipoNivel + "',estatus='" + estatus +
                            "',registrado_por='" + registradopor + "',fecha='" + fechaRegistro +"' where id_usuario='"+id+"';";
                    int count = st.executeUpdate(sql);
                    
                    if(count >= 0){
                        out.println("<div class=\"container mt-5\">"
                                  + "<div class=\"alert alert-success\" role=\"alert\"> Datos modificados con éxito en la BD! <br>"
                                  + " Los datos del usuario: " + nombre + "<br>Em@il: " + email + "<br>Nivel: " + tipoNivel + "<br>Estatus: " + estatus + "<br> Fueron modificados con éxito a la BD, por el usuario: " + registradopor + ", en la fecha: " + fechaRegistro + " </div>"
                                  + "<a href=\"index.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                  + "</did>");
                        hidden="hidden";
                    } else {
                        out.println("<div class=\"container mt-5\">"
                                + "<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo modificar los datos en la BD. <br>"
                                + " Esto puede ser debido a que se ingreso algún dato erroneo. <br>"
                                + " Verifique la información ingresada e intentelo nuevamente por favor. </div> "
                                + "<a href=\"index.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                + "</did>");
                        hidden="hidden";
                    }
                    st.close();
                    con.close();
                    //request.getRequestDispatcher("index.jsp").forward(request, response);
                } catch (Exception e) {
                    out.print(e);
                }
            }
        %>
        <body>
        <div class="container mt-5" id="containerGeneral" <%=hidden%>>
        <header>
            <h1>Editar Datos de Usuarios</h1>
            <h5>Conexion a Base Datos Remota</h5>
            <p>Fecha: <%= fecha %></p>
        </header>

        <div class="container">
            <div class="row">
                <div class="col-sm">

                    <form action="editar.jsp" method="get">
                        <div class="form-group" id="form1">
                            <label for="nombre">Nombre</label>
                            <input type="text" class="form-control" id="nombre" value="<%= nombre%>" name="nombre" placeholder="Nombre" required="required">
                        </div>
                        <div class="form-group" id="form1">
                            <label for="email">Email</label>
                            <input type="text" class="form-control" id="email" value="<%= email%>" name="email" placeholder="Em@il" required="required">
                        </div>
                        <div class="form-group" id="form1">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="username"  value="<%= username%>"  name="username" placeholder="Username" required="required">
                        </div>
                        <div class="form-group" id="form1">
                            <label for="tiponivel">Tipo Nivel</label>
                            <select class="form-control" id="tipo_nivel" name="tipo_nivel" required="required" value="<%= tipoNivel%>">
                                <option selected disabled value="">Seleccione una opción...</option>
                                <option>Administrador</option>
                                <option>Procesista</option>
                                <option>Usuario</option>
                                <option>Proveedor</option>
                            </select>    
                        </div>
                        <div class="form-group" id="form1">
                            <label for="estatus">Estatus</label>
                        </div>
                        <div class="form-group" >
                                <div class="form-check form-check-inline">
                                    <input type="radio" class="form-check-input" id="estatusA" name="estatus" value="Activo" <%=checkedActivo%>>
                                    <label class="custom-control-label" for="estatusA">Activo</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input type="radio" class="form-check-input" id="estatusI" name="estatus" value="Inactivo" <%=checkedInactivo%>>
                                    <label class="custom-control-label" for="estatusI">Inactivo</label>
                                </div>
                            </div>
                        
                        <div class="form-group">
                            <input type="hidden" class="form-control" id="registrado_por" name="registrado_por" value="<%= session.getAttribute("username")%>" required="required">
                        </div>
                        
                        <div class="form-group" id="form1">
                            <label for="fecha">Fecha</label>
                            <input type="date" class="form-control" id="fecha" name="fecha" value="<%= fechaRegistro%>" required="required">
                        </div>
                        <fieldset disabled>
                            <div class="form-group" id="form1">
                                <label for="registrado_por2">Modificado por</label>
                                <input type="text" class="form-control" id="registrado_por2" name="registrado_por2" value="<%= session.getAttribute("username")%>">
                            </div>
                        </fieldset>
                        <div>       
                            <button type="submit" id="form1" name="enviar" class="btn btn-primary">Guardar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                            <a href="index.jsp" class="btn btn-danger" id="form1">Cancelar <i class="fa fa-ban" aria-hidden="true"></i></a>
                            <input type="hidden" name="id" value="<%= id%>">
                         </div>    
                    </form>

                </div>
            </div>
        </div>
                         <p class="footer">Developed by Germán Montalbetti ©2021</p>
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
