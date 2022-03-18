<%-- 
    Document   : crearnuevoensayo
    Created on : 21/09/2021, 14:19:49
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="utiles.FormatoFecha"%>
<%@page import="java.util.Date"%>
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
        <title>Crear Nuevo Ensayo</title>
    </head>
    <%
        String fecha = FormatoFecha.formaFecha();
        HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
                       
        String username = request.getParameter("username");
        String nombre_pieza = request.getParameter("nombre_pieza");
        //int id_pieza = Integer.parseInt(request.getParameter("id_pieza"));
    %>    
    <body>
        <div class="container mt-5" id="containerGeneral">
            <header>
                <h1>Ingreso Nuevo Ensayo <i class="fa fa-thermometer-full" aria-hidden="true"></i></h1>
                <h5>Conexión a Base Datos Remota</h5>
                <p>Fecha: <%= fecha %></p>
            </header>
            <div class="container">
                <div class="row">
                    <div class="col-sm">
                        <form  method="post" action="UploadArchivo" enctype="multipart/form-data">
                            <div class="form-group" id="form1">
                                <label>Nombre Pieza</label>
                                <input type="text" class="form-control" id="nombre_pieza1" name="nombre_pieza1" value="<%=request.getParameter("nombre_pieza")%>" aria-label="Disabled input" disabled>
                                <input type="hidden" class="form-control" id="nombre_pieza" name="nombre_pieza" value="<%=request.getParameter("nombre_pieza")%>">
                            </div>
                            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.0/jquery.min.js"></script>
                            <div class="form-group" id="form1">
                                <span class="input-group-text">Categoría del Ensayo</span>
                                <select class="form-select" id="ensayo_categoria" name="ensayo_categoria" required>
                                    <option selected disabled value="">Seleccione una categoría...</option>
                                    <option>Material Catalogo</option>
                                    <option>Material Norma</option>
                                    <option>Mat. Norma Lim. Inferior</option>
                                    <option>Mat. Norma Lim. Superior</option>
                                    <option>Material Ensayado</option>
                                    <option>Material Norma - Prueba_1</option>
                                    <option>Material Norma - Prueba_2</option>
                                    <option>Material Norma - Prueba_3</option>
                                    <option>Material Norma - Prueba_4</option>
                                </select>
                                <input type="hidden" class="form-control" id="valorseleccion" name="valorseleccion">
                            </div>

                            <div class="form-group" id="form1">
                                <span class="input-group-text">Descripción del Ensayo</span>
                                <textarea class="form-control" id="description" rows="3" name="ensayo_descripcion" aria-label="Descripcion"></textarea>
                            </div>

                            <div class="form-group" id="form1">
                                <span for="formFile" class="form-label">Seleccionar Archivo Norma Material</span> <br>
                                <span> (Recuerde: Solo puede seleccionar archivos pdf)</span>
                                <input class="form-control" type="file" id="norma_material" name="norma_material" accept="application/pdf">
                            </div>

                            <div class="form-group" id="form1">
                                <label for="fecha">Fecha</label>
                                <input type="date" class="form-control" id="fecha" name="fecha_ensayo" required="required" value="today">
                            </div>

                            <div class="form-group" id="form1">
                                <input type="hidden" class="form-control" id="registrado_por" name="ultima_modificacion" value="<%= session.getAttribute("username")%>" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <input type="hidden" class="form-control" id="id_pieza" name="id_pieza" value="<%= request.getParameter("id_pieza")%>">
                            </div>

                            <div class="form-group" id="form1">
                                <label>Estatus</label>
                                <input type="text" class="form-control" id="estatus" name="estatus1" value="Nuevo Ensayo S/D" aria-label="Disabled input" disabled readonly>
                                <input type="hidden" class="form-control" id="estatus" name="estatus" value="Nuevo Ensayo S/D" required="required">
                            </div>

                            <fieldset disabled>
                                <div class="form-group" id="form1">
                                    <label for="registrado_por2">Ultima modificación por</label>
                                    <input type="text" class="form-control" id="registrado_por2" name="ultima_modificacion2" value="<%= session.getAttribute("username")%>">
                                </div>
                            </fieldset>

                            <div>    
                                <button type="submit" id="form1" name="enviar" value="enviar" class="btn btn-primary">Registrar Ensayo <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                                <a title="Volver" href="piezas.jsp" class="btn btn-secondary" id="form1">Volver <i class="fa fa-arrow-circle-left" aria-hidden="true"></i></a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <p class="footer">Developed by Germán Montalbetti ©2021</p>
        </div>        
    </body>
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
                         
                function processSelected()
                {
                    var selectedValue = document.getElementById("ensayo_categoria").value;
                    //alert(selectedValue);
                    document.getElementById("valorseleccion").value = selectedValue;
                }
                getSelectValue();         
    </script>
</html>
