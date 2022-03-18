<%-- 
    Document   : editarPiezas
    Created on : 21/09/2021, 09:43:12
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>

<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="css/estilo.css"/>
        <title>Editar Pieza Web App</title>
    </head>
    <%
        Date date = new Date();
        
        String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
        String usuariodb = "cadcam1_german"; 
        String passdb = "12345";
        
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
                    Connection con = null;
                    Statement st = null;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(urldb, usuariodb, passdb);
                    st = con.createStatement();
                    int count = st.executeUpdate("update `piezas` set nombre_pieza='" + nombre_pieza + "',material_pieza='" + material_pieza + "',espesor_pieza='" + espesor_pieza + "',numero_pieza='" + numero_pieza + "',descripcion_pieza='" + descripcion_pieza + "',ultima_modificacion='" + registradopor + "' where id_pieza='"+id_pieza+"';");
                    //request.getRequestDispatcher("piezas.jsp").forward(request, response);
                
                        if(count >= 0){
                                    out.println("<div class=\"container mt-5\">");
                                    out.println("<div class=\"alert alert-success\" role=\"alert\"> Datos modififcados con éxito a la BD! <br>"
                                            + " La pieza: " + nombre_pieza + "<br>N°: " + numero_pieza + "<br>Espesor: " + espesor_pieza + " mm.<br>Material: " + material_pieza + "<br> fue modificada con éxito a la BD!</div> ");
                                    out.println("<a href=\"piezas.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                    out.println("</did>");
                                    hidden="hidden";
                                } else {
                                    out.println("<div class=\"container mt-5\">");
                                    out.println("<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo modificar los datos en la BD. <br>"
                                            + " Verifique la información ingresada e intentelo nuevamente por favor. </div> ");

                                    out.println("<a href=\"piezas.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                    out.println("</did>");
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
        <div <%=hidden%>>
        <div class="container mt-3" style="background-color: #53f2fd;">
            <h1>Editar Datos de Piezas</h1>
            <h5>Conexion a Base Datos Remota</h5>
            <p>Fecha: <%= date %></p>
        </div>

        <div class="container mt-3">
            <div class="row">
                <div class="col-sm">

                    <form action="editarPiezas.jsp" method="post">
                        <div class="form-group" id="form1">
                            <label for="nombre">Nombre</label>
                            <input type="text" class="form-control" id="nombre" value="<%= nombre_pieza%>" name="nombre_pieza" placeholder="Nombre" required="required">
                        </div>
                        <div class="form-group" id="form1">
                            <label for="material">Material</label>
                            <input type="text" class="form-control" id="material" value="<%= material_pieza%>" name="material_pieza" placeholder="Material" required="required">
                        </div>
                        <div class="form-group" id="form1">
                            <label for="espesor">Espesor (mm)</label>
                            <input type="number" class="form-control" min="0.5" max="10" step="0.01" id="espesor"  value="<%= espesor_pieza%>"  name="espesor_pieza" placeholder="E.g. 1.08" required="required">
                        </div>
                        <div class="form-group" id="form1">
                            <label for="tiponivel">Número</label>
                            <input type="text" class="form-control" id="numero" value="<%= numero_pieza%>" name="numero_pieza" placeholder="Número" required="required">
                        </div>
                        
                        <div class="form-group" id="form1">
                            <label for="descripcion">Descripcion</label>
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
                             
                        <div style="margin-bottom: 100px;">       
                            <button type="submit" id="form1" name="enviar" class="btn btn-primary">Guardar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                            <a href="piezas.jsp" class="btn btn-danger" id="form1">Cancelar <i class="fa fa-ban" aria-hidden="true"></i></a>
                            <input type="hidden" name="id_pieza" value="<%= id_pieza%>">
                         </div>    
                    </form>

                </div>
            </div>
        </div>
        
      </div>                   
    </body>
</html>
