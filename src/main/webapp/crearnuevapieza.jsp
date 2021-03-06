<%-- 
    Document   : crearnuevapieza
    Created on : 16/09/2021, 14:10:27
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
        <title>Crear Nueva Pieza</title>
    </head>
    <%
        String fecha = FormatoFecha.formaFecha();
        
        HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
        
        String username = request.getParameter("username");
        //int id_pieza = Integer.parseInt(request.getParameter("id_pieza"));
    %>
    <body>
        <div class="container mt-5" id="containerGeneral">
            <header>
                <h1>Ingreso Datos Nueva Pieza <i class="bi bi-gear-wide-connected" aria-hidden="true"></i></h1>
                <h5>Conexión a Base Datos Remota</h5>
                <p>Fecha: <%= fecha %></p>
            </header>
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <form  method="post" action="UploadNuevaPieza" enctype="multipart/form-data">
                            <div class="form-group" id="form1">
                                <label>Nombre Pieza</label>
                                <input type="text" class="form-control" id="nombre" name="nombre_pieza" aria-describedby="Nombre" placeholder="Nombre Pieza" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label>Material Pieza</label>
                                <input type="text" class="form-control" id="material" name="material_pieza" placeholder="Material" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label>Espesor (mm)</label>
                                <input type="number" min="0.5" max="10" step="0.01" class="form-control" id="espesor" name="espesor_pieza" placeholder="E.g. 1.08" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label>Número Pieza</label>
                                <input type="text" class="form-control" id="numero" name="numero_pieza" placeholder="Número de pieza" required="required">
                            </div>

                            <div class="form-group" id="form1">
                                <span for="formFile" class="form-label">Seleccionar Imagen de pieza</span> <br>
                                <span> (Recuerde: Solo puede seleccionar archivos png, gif, jpeg, jpg, tiff, tif)</span>
                                <input class="form-control" type="file" id="imagen_pieza" name="imagen_pieza" accept="image/png, image/gif, image/jpeg,image/jpg, image/tiff, image/tif">
                            </div>

                            <div class="form-group" id="form1">
                                <span class="input-group-text">Descripción Pieza</span>
                                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="descripcion_pieza" aria-label="Descripcion"></textarea>
                            </div>

                            <div class="form-group" id="form1">
                                <input type="hidden" class="form-control" id="registrado_por" name="ultima_modificacion" value="<%= session.getAttribute("username")%>" required="required">
                            </div>

                            <fieldset disabled>
                                <div class="form-group" id="form1">
                                    <label for="registrado_por2">Ultima modificación por</label>
                                    <input type="text" class="form-control" id="registrado_por2" name="ultima_modificacion2" value="<%= session.getAttribute("username")%>">
                                </div>
                            </fieldset>

                            <div class="d-block mx-auto my-1 text-center">    
                                <button type="submit" id="form1" name="enviar" value="enviar" class="btn btn-primary mx-auto me-sm-4" style="width: 8rem">Registrar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                                <button type = "reset" value = "Reset" class="btn btn-info mx-auto" style="width: 8rem">Reset <i class="fa fa-refresh" aria-hidden="true"></i></button>
                                <a title="Volver" href="piezas.jsp" class="btn btn-secondary mx-auto ms-sm-4" style="width: 8rem" id="form1">Volver <i class="fa fa-arrow-circle-left" aria-hidden="true"></i></a>
                            </div>
                        </form>
                    </div>    
                </div>
            </div>
            <p class="footer">Developed by Germán Montalbetti ©2021</p>
        </div>
    </body>
</html>

