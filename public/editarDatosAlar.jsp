<%-- 
    Document   : editarDatosAlar
    Created on : 07/10/2021, 14:09:45
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
        <title>Editar Datos Alargamiento</title>
    </head>
    <%
        Date date = new Date();
        
        String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
        String usuariodb = "cadcam1_german"; 
        String passdb = "12345";
        ResultSet rs = null;
        
        //String id_pieza = request.getParameter("id_pieza");
        String id_ensayo = request.getParameter("id_ensayo");
        String nombre_pieza = request.getParameter("nombre_pieza");
        String ensayo_categoria = request.getParameter("ensayo_categoria");
        String hidden = "";
        
        //Datos alargamiento----------------
        int id_alargamiento = 0;
        int id_ensayo_fin = 0;
        int a_porcentual = 0;//Integer.parseInt(request.getParameter("a_porcentual"));
        double ag_porcentual = 0;//Double.parseDouble(request.getParameter("ag_porcentual"));
        double ag_90_porcentual = 0;//Double.parseDouble(request.getParameter("ag_90_porcentual"));
        double a_50 = 0;//Double.parseDouble(request.getParameter("a_50"));
        double a_80 = 0;//Double.parseDouble(request.getParameter("a_80"));
        double a_80_90 = 0;//Double.parseDouble(request.getParameter("a_80_90"));
        double a_80_minimo = 0;//Double.parseDouble(request.getParameter("a_80_minimo"));
        
            try {
                Connection con = null;
                Statement st = null;
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(urldb, usuariodb, passdb);
                st = con.createStatement();
                rs = st.executeQuery("SELECT * FROM alargamiento where id_ensayo='" + id_ensayo + "'");                                                                 
                    if(rs.next()){
                            id_alargamiento = rs.getInt(1);
                            id_ensayo_fin = rs.getInt(2);
                            a_porcentual = rs.getInt(5);
                            ag_porcentual = rs.getDouble(6);
                            ag_90_porcentual = rs.getDouble(7);
                            a_50 = rs.getDouble(8);
                            a_80 = rs.getDouble(9);
                            a_80_90 = rs.getDouble(10);
                            a_80_minimo = rs.getDouble(11);
                    }
                    rs.close();
                    st.close();
                    con.close();

            } catch (Exception e) {
                      out.print(e);
            }
    %>
    
    <%
    
        if (request.getParameter("enviar") != null ) {
                    //Datos alargamiento----------------
                    String id_ensayo_end = request.getParameter("id_ensayo");
                    String a_porcentual_fin = request.getParameter("a_porcentual");
                    String ag_porcentual_fin = request.getParameter("ag_porcentual");
                    String ag_90_porcentual_fin = request.getParameter("ag_90_porcentual");
                    String a_50_fin = request.getParameter("a_50");
                    String a_80_fin = request.getParameter("a_80");
                    String a_80_90_fin = request.getParameter("a_80_90");
                    String a_80_minimo_fin = request.getParameter("a_80_minimo");
                    String fecha_alargamiento = request.getParameter("fecha_ensayo");
                    String ultima_modif_alargamiento = request.getParameter("registrado_por");
                    
                if(request.getParameter("ensayo_categoria").equalsIgnoreCase("Material Ensayado")){
                    //-----------------------------------------------------
                    try {
                        Connection con = null;
                        Statement st = null;
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(urldb, usuariodb, passdb);
                        st = con.createStatement();
                        
                        String sql = "UPDATE `ensayos` SET `estatus`='Datos Actualizados'  WHERE `id_ensayo`=" + id_ensayo_end + ";";
                        st.executeUpdate(sql);
                        st.close();
                        con.close();
                
                    } catch (SQLException e) {
                            out.print(e);
                    }
                    //-----------------------------------------------------
                    try {
                        Connection con = null;
                        Statement st = null;
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(urldb, usuariodb, passdb);
                        st = con.createStatement();
                        
                        String sql = "UPDATE `alargamiento` SET `a_porcentual`=" + a_porcentual_fin + ",`ag_porcentual`=" + ag_porcentual_fin + ",`ag_90_porcentual`=" +
                                    ag_90_porcentual_fin + ",`a_50`=" + a_50_fin + ",`a_80`=" + a_80_fin + ",`a_80_90`=" + a_80_90_fin + ",`a_80_minimo`=" +
                                    a_80_minimo_fin + ",`fecha_alargamiento`='" + fecha_alargamiento + "',`ultima_modif_alargamiento`='" + ultima_modif_alargamiento +
                                    "' WHERE `id_ensayo`=" + id_ensayo_end + ";";
                        
                        int count = st.executeUpdate(sql);
                        //out.println("Sintaxsys sql: " + sql);
                        //out.println("Count value: " + count);
                        if(count > 0){
                                        out.println("<div class=\"container mt-5\">");
                                        out.println("<div class=\"alert alert-success\" role=\"alert\"> Datos modificados con éxito a la BD! <br>"
                                                + " Los datos de Alargamiento del Ensayo Id#: " + id_ensayo + " Categoría: " + ensayo_categoria + "<br>De la pieza: " + nombre_pieza + "<br> fueron modificados con éxito en la BD!</div> ");
                                        out.println("<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                        out.println("</did>");
                                        hidden="hidden";
                        } else {
                                        out.println("<div class=\"container mt-5\">");
                                        out.println("<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo modificar los datos en la BD. <br>"
                                                + " Puede que los datos del ensayo no se hayan cargado aún. Verifique la información ingresada e intentelo nuevamente por favor. </div> ");

                                        out.println("<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                        out.println("</did>");
                                        hidden="hidden";
                                    }
                                st.close();
                                con.close();
                
                } catch (SQLException e) {
                    out.print(e);
                }
        
                } else {
                    //-----------------------------------------------------
                    try {
                        Connection con = null;
                        Statement st = null;
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(urldb, usuariodb, passdb);
                        st = con.createStatement();
                        
                        String sql = "UPDATE `ensayos` SET `estatus`='Datos Actualizados'  WHERE `id_ensayo`=" + id_ensayo_end + ";";
                        st.executeUpdate(sql);
                        
                        st.close();
                        con.close();
                
                    } catch (SQLException e) {
                            out.print(e);
                    }
                    //-----------------------------------------------------
                    try {
                        Connection con = null;
                        Statement st = null;
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(urldb, usuariodb, passdb);
                        st = con.createStatement();
                        
                        String sql = "UPDATE `alargamiento` SET `a_porcentual`=" + a_porcentual_fin + ",`fecha_alargamiento`='" + fecha_alargamiento + "',`ultima_modif_alargamiento`='" + ultima_modif_alargamiento +
                                    "' WHERE `id_ensayo`=" + id_ensayo_end + ";";
                        
                        int count = st.executeUpdate(sql);
                        //out.println("Sintaxsys sql: " + sql);
                        //out.println("Count value: " + count);
                        if(count > 0){
                                        out.println("<div class=\"container mt-5\">");
                                        out.println("<div class=\"alert alert-success\" role=\"alert\"> Dato modificado con éxito a la BD! <br>"
                                                + " El dato de Alargamiento del Ensayo Id#: " + id_ensayo + " Categoría: " + ensayo_categoria + "<br>De la pieza: " + nombre_pieza + "<br> fue modificado con éxito en la BD!</div> ");
                                        out.println("<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                        out.println("</did>");
                                        hidden="hidden";
                        } else {
                                        out.println("<div class=\"container mt-5\">");
                                        out.println("<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo modificar el dato en la BD. <br>"
                                                + " Puede que los datos del ensayo no se hayan cargado aún. Verifique la información ingresada e intentelo nuevamente por favor. </div> ");

                                        out.println("<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                        out.println("</did>");
                                        hidden="hidden";
                                    }
                                st.close();
                                con.close();
                
                } catch (SQLException e) {
                    out.print(e);
                }
                
                }   
            }
    %>     
    
    <body>
        <div <%=hidden%>>
        <div class="container mt-5" style="background-color: #53f2fd;">
            <h1>Editar Datos de Alargamiento</h1>
            <h5>Conexion a Base Datos Remota</h5>
            <p>Fecha: <%= date %></p>
        </div>

        <div class="container mt-5">
            <div class="row">
                <div class="col-sm">

                    <form action="editarDatosAlar.jsp" method="post">
                        
                        <div class="form-group" id="form1">
                            <span class="input-group-text">Nombre pieza</span>
                            <input type="text" class="form-control" id="nombre_pieza1" name="nombre_pieza1" value="<%=request.getParameter("nombre_pieza")%>" aria-label="Disabled input" disabled>
                            <input type="hidden" class="form-control" id="nombre_pieza" name="nombre_pieza" value="<%=request.getParameter("nombre_pieza")%>">
                        </div>

                        <div class="form-group" id="form1">
                            <span class="input-group-text">Categoria de Ensayo</span>
                            <input type="text" class="form-control" id="ensayo_categoria1" name="ensayo_categoria1" value="<%=request.getParameter("ensayo_categoria")%>" aria-label="Disabled input" disabled>
                            <input type="hidden" class="form-control" id="ensayo_categoria" name="ensayo_categoria" value="<%=request.getParameter("ensayo_categoria")%>">
                            <input type="hidden" class="form-control" id="id_ensayo" name="id_ensayo" value="<%=id_ensayo%>">
                        </div>
                        
                        <!-- Alargamiento -->
                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #e3a25d"><b>Datos de Alargamiento - Id_alargamiento: <%=id_alargamiento%> - Id_ensayo: <%=id_ensayo%> </b></span>
                        </div>      

                        <div class="container mt-2">    
                            <div class="row gy-2 gx-3 align-items-center" id="form1">
                                <div class="col-sm-2">
                                    <div class="input-group" id="a_porcentual">
                                        <div class="input-group-text">Alarg.</div>
                                        <input type="number" class="form-control" name="a_porcentual" placeholder="20%" min="0" max="45" step="1" value="<%=a_porcentual%>">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="ag_porcentual">
                                        <div class="input-group-text">Ag.</div>
                                        <input type="number" class="form-control" name="ag_porcentual" placeholder="20%" min="0" max="45" step="0.1" value="<%=ag_porcentual%>">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="ag_90_porcentual">
                                        <div class="input-group-text">Ag. 90°</div>
                                        <input type="number" class="form-control" name="ag_90_porcentual" placeholder="20%" min="0" max="45" step="0.1" value="<%=ag_90_porcentual%>">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="a_50">
                                        <div class="input-group-text">A-50</div>
                                        <input type="number" class="form-control" name="a_50" min="0" max="45" step="0.1" value="<%=a_50%>">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="a_80">
                                        <div class="input-group-text">A-80</div>
                                        <input type="number" class="form-control" name="a_80" min="0" max="45" step="0.1" value="<%=a_80%>">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="input-group" id="a_80_90">
                                        <div class="input-group-text">A-80(90°)</div>
                                        <input type="number" class="form-control" name="a_80_90" min="0" max="45" step="0.1" value="<%=a_80_90%>">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="input-group" id="a_80_minimo">
                                        <div class="input-group-text">A-80(mín.)</div>
                                        <input type="number" class="form-control" name="a_80_minimo" min="0" max="45" step="0.1" value="<%=a_80_minimo%>">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #e3a25d"></span>
                        </div>
                        
                        <div class="form-group" id="form1">
                            <span for="fecha" class="form-label">Fecha</span>
                            <input type="date" class="form-control" id="fecha_ensayo" name="fecha_ensayo" required="required">
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
                            <button type="submit" id="form1" name="enviar" class="btn btn-primary">Actualizar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                            <a href="ensayos.jsp" class="btn btn-danger" id="form1">Cancelar <i class="fa fa-ban" aria-hidden="true"></i></a>
                            
                        </div>    
                    </form>

                </div>
            </div>
        </div>
       
          <script type="text/javascript">
                    var ensayo_categoria = document.getElementById("ensayo_categoria").value;
                    var a_porcentual = document.getElementById("a_porcentual");
                    var ag_porcentual = document.getElementById("ag_porcentual");
                    var ag_90_porcentual = document.getElementById("ag_90_porcentual");
                    var a_50 = document.getElementById("a_50");
                    var a_80 = document.getElementById("a_80");
                    var a_80_90 = document.getElementById("a_80_90");
                    var a_80_minimo = document.getElementById("a_80_minimo");

                            if(ensayo_categoria === "Material Ensayado"){
                                    a_porcentual.hidden = false;
                                    ag_porcentual.hidden = false;
                                    ag_90_porcentual.hidden = false;
                                    a_50.hidden = false;
                                    a_80.hidden = false;
                                    a_80_90.hidden = false;
                                    a_80_minimo.hidden = false;

                            } else {
                                    a_porcentual.hidden = false;
                                    ag_porcentual.hidden = true;
                                    ag_90_porcentual.hidden = true;
                                    a_50.hidden = true;
                                    a_80.hidden = true;
                                    a_80_90.hidden = true;
                                    a_80_minimo.hidden = true;
                            }
        </script>               
    
      </div>                   
    </body>
</html>

