<%-- 
    Document   : editarPiezas
    Created on : 21/09/2021, 09:43:12
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
        <title>Editar Pieza Web App</title>
    </head>
    <%
        String fecha = FormatoFecha.formaFecha();
        
        String id_pieza = request.getParameter("id_pieza");
        String nombre_pieza = request.getParameter("nombre_pieza");
        String material_pieza = request.getParameter("material_pieza");
        String espesor_pieza = request.getParameter("espesor_pieza");
        String numero_pieza = request.getParameter("numero_pieza");
        String descripcion_pieza = request.getParameter("descripcion_pieza");
        String registradopor = request.getParameter("registrado_por");
        String hidden = "";

            if (request.getParameter("enviar") != null) {
                try {
                    Connection con = connection.conectar();
                    Statement st = con.createStatement();
                    String sql = "update `piezas` set nombre_pieza='" + nombre_pieza + "',material_pieza='" + material_pieza + "',espesor_pieza='" + espesor_pieza + "',numero_pieza='" + numero_pieza +
                            "',descripcion_pieza='" + descripcion_pieza + "',ultima_modificacion='" + registradopor + "' where id_pieza='"+id_pieza+"';";
                    int count = st.executeUpdate(sql);
                    
                        if(count >= 0){
                                    out.println("<div class=\"container mt-5\">"
                                              + "<svg xmlns=\"http://www.w3.org/2000/svg\" style=\"display: none;\">" 
                                              + "<symbol id=\"check-circle-fill\" fill=\"currentColor\" viewBox=\"0 0 16 16\">"
                                              + "<path d=\"M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z\"/>"
                                              + "</symbol>"
                                              + "</svg>"
                                              + "<div class=\"alert alert-success d-flex align-items-center\" role=\"alert\">"
                                              + "<svg class=\"bi flex-shrink-0 me-2\" width=\"24\" height=\"24\" role=\"img\" aria-label=\"Success:\"><use xlink:href=\"#check-circle-fill\"/></svg>"
                                              + "<div>"
                                              + " Datos modififcados con éxito en la BD! <br>"
                                              + " La pieza: " + nombre_pieza + "<br>N°: " + numero_pieza + "<br>Espesor: " + espesor_pieza + " mm.<br>Material: " + material_pieza + "<br> fue modificada con éxito a la BD!</div>"
                                              + "</div>"
                                              + "<a href=\"piezas.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                              + "</div>");
                                    hidden="hidden";
                                } else {
                                    out.println(  "<div class=\"container mt-5\">"
                                                + "<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo modificar los datos en la BD. <br>"
                                                + " Verifique la información ingresada e intentelo nuevamente por favor.</div>"
                                                + "<a href=\"piezas.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                                + "</did>");
                                    hidden="hidden";
                                }
                            st.close();
                            con.close();
                } catch (Exception e) {
                    out.print(e);
                }
            }
    %>
    <body>
        <div class="container mt-5" id="containerGeneral" <%=hidden%>>
            <header>
                <h1>Editar Datos de Piezas</h1>
                <h5>Conexion a Base Datos Remota</h5>
                <p>Fecha: <%= fecha %></p>
            </header>

            <div class="container">
                <div class="row">
                    <div class="col-sm">
                        <form action="editarPiezas.jsp" method="post">
                            <div class="form-group" id="form1">
                                <label for="nombre">Nombre Pieza</label>
                                <input type="text" class="form-control" id="nombre" value="<%= nombre_pieza%>" name="nombre_pieza" placeholder="Nombre" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label for="material">Material Pieza</label>
                                <input type="text" class="form-control" id="material" value="<%= material_pieza%>" name="material_pieza" placeholder="Material" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label for="espesor">Espesor (mm)</label>
                                <input type="number" class="form-control" min="0.5" max="12" step="0.01" id="espesor"  value="<%= espesor_pieza%>"  name="espesor_pieza" placeholder="E.g. 1.08" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <label for="tiponivel">Número Pieza</label>
                                <input type="text" class="form-control" id="numero" value="<%= numero_pieza%>" name="numero_pieza" placeholder="Número" required="required">
                            </div>
                            <div class="form-group" id="form1">
                                <span class="input-group-text" for="descripcion">Descripción Pieza</span>
                                <textarea class="form-control" id="descripcion" rows="3" name="descripcion_pieza" aria-label="Descripcion" required><%= descripcion_pieza%></textarea>
                            </div>
                            <div class="form-group">
                                <input type="hidden" class="form-control" id="registrado_por" name="registrado_por" value="<%= session.getAttribute("username")%>" required="required">
                            </div>
                            <fieldset disabled>
                                <div class="form-group" id="form1">
                                    <label for="registrado_por2">Modificado por</label>
                                    <input type="text" class="form-control" id="registrado_por2" name="registrado_por2" value="<%= session.getAttribute("username")%>">
                                </div>
                            </fieldset>
                            <div>       
                                <button type="submit" id="form1" name="enviar" class="btn btn-primary">Guardar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                                <a href="piezas.jsp" class="btn btn-danger" id="form1">Cancelar <i class="fa fa-ban" aria-hidden="true"></i></a>
                                <input type="hidden" name="id_pieza" value="<%= id_pieza%>">
                            </div>    
                        </form>

                    </div>
                </div>
            </div>
            <p class="footer">Developed by Germán Montalbetti ©2021</p>
        </div>                   
    </body>
</html>
