<%-- 
    Document   : editarDatosResis
    Created on : 13/10/2021, 15:00:36
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
        <link rel="stylesheet" href="css/estiloCargaDatosEnsayo.css"/>
        <title>Editar Datos Resistencia</title>
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
        
        //Datos resistencia----------------
        int id_resistencia = 0;
        int id_ensayo_fin = 0;
        int rm_max = 0;
        int rm_min = 0;
        int rm_medio = 0;
        int rm_90 = 0;
        int rm_unico = 0;
        int sigma_02 = 0;
        int lim_elastico = 0;
        int rp_max = 0;
        int rp_min = 0;
        int rp_promedio = 0;
        int rp_unico = 0;
        int lim_fluencia_max = 0;
        int lim_fluencia_min = 0;
        int lim_fluencia_unico = 0;
        
            try {
                Connection con = null;
                Statement st = null;
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(urldb, usuariodb, passdb);
                st = con.createStatement();
                rs = st.executeQuery("SELECT * FROM resistencia where id_ensayo='" + id_ensayo + "'");                                                                 
                    if(rs.next()){
                            id_resistencia = rs.getInt(1);
                            id_ensayo_fin = rs.getInt(2);
                            rm_max = rs.getInt(5);
                            rm_min = rs.getInt(6);
                            rm_medio = rs.getInt(7);
                            rm_90 = rs.getInt(8);
                            rm_unico = rs.getInt(9);
                            sigma_02 = rs.getInt(10);
                            lim_elastico = rs.getInt(11);
                            rp_max = rs.getInt(12);
                            rp_min = rs.getInt(13);
                            rp_promedio = rs.getInt(14);
                            rp_unico = rs.getInt(15);
                            lim_fluencia_max = rs.getInt(16);
                            lim_fluencia_min = rs.getInt(17);
                            lim_fluencia_unico = rs.getInt(18);
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
                    //Datos resistencia----------------
                    String id_ensayo_end = request.getParameter("id_ensayo");
                    String rm_max_fin = request.getParameter("rm_max");
                    String rm_min_fin = request.getParameter("rm_min");
                    String rm_medio_fin = request.getParameter("rm_medio");
                    String rm_90_fin = request.getParameter("rm_90");
                    String rm_unico_fin = request.getParameter("rm_unico");
                    String sigma_02_fin = request.getParameter("sigma_02");
                    String lim_elastico_fin = request.getParameter("lim_elastico");
                    String rp_max_fin = request.getParameter("rp_max");
                    String rp_min_fin = request.getParameter("rp_min");
                    String rp_promedio_fin = request.getParameter("rp_promedio");
                    String rp_unico_fin = request.getParameter("rp_unico");
                    String lim_fluencia_max_fin = request.getParameter("lim_fluencia_max");
                    String lim_fluencia_min_fin = request.getParameter("lim_fluencia_min");
                    String lim_fluencia_unico_fin = request.getParameter("lim_fluencia_unico");
                    
                    String fecha_resistencia = request.getParameter("fecha_ensayo");
                    String ultima_modif_resistencia = request.getParameter("registrado_por");
                    
                if(request.getParameter("ensayo_categoria").equalsIgnoreCase("Material Norma")){
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
                        
                        String sql = "UPDATE `resistencia` SET `rm_max`=" + rm_max_fin + ",`rm_min`=" + rm_min_fin + ",`rm_medio`=" + rm_medio_fin + ",`rm_90`=" + rm_90_fin +
                                    ",`sigma_02`=" + sigma_02_fin + ",`lim_elastico`=" + lim_elastico_fin + 
                                    ",`rp_max`=" + rp_max_fin + ",`rp_min`=" + rp_min_fin + ",`rp_promedio`=" + rp_promedio_fin +
                                    ",`lim_fluencia_max`=" + lim_fluencia_max_fin + ",`lim_fluencia_min`=" + lim_fluencia_min_fin +
                                    ",`fecha_resistencia`='" + fecha_resistencia + "',`ultima_modif_resistencia`='" + ultima_modif_resistencia +
                                    "' WHERE `id_ensayo`=" + id_ensayo_end + ";";
                        
                        int count = st.executeUpdate(sql);
//        out.println("Sintaxsys sql: " + sql);
//        out.println("Count value: " + count);
                        if(count > 0){
                                        out.println("<div class=\"container mt-5\">");
                                        out.println("<div class=\"alert alert-success\" role=\"alert\"> Datos de Resistencia modificados con éxito a la BD! <br>"
                                                + " Los datos de Resistencia del Ensayo Id#: " + id_ensayo + " Categoría: " + ensayo_categoria + "<br>De la pieza: " + nombre_pieza + "<br> fueron modificados con éxito en la BD!</div> ");
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
                        
                        String sql = "UPDATE `resistencia` SET `rm_unico`=" + rm_unico_fin + ",`sigma_02`=" + sigma_02_fin + ",`lim_elastico`=" + lim_elastico_fin +
                                    ",`rp_unico`=" + rp_unico_fin + ",`lim_fluencia_unico`=" + lim_fluencia_unico_fin +
                                    ",`fecha_resistencia`='" + fecha_resistencia + "',`ultima_modif_resistencia`='" + ultima_modif_resistencia +
                                    "' WHERE `id_ensayo`=" + id_ensayo_end + ";";
                        
                        int count = st.executeUpdate(sql);
//        out.println("Sintaxsys sql: " + sql);
//        out.println("Count value: " + count);
                        if(count > 0){
                                        out.println("<div class=\"container mt-5\">");
                                        out.println("<div class=\"alert alert-success\" role=\"alert\"> Datos modificados con éxito a la BD! <br>"
                                                + " Los datos de Resistencia del Ensayo Id#: " + id_ensayo + " Categoría: " + ensayo_categoria + "<br>De la pieza: " + nombre_pieza + "<br> fueron modificados con éxito en la BD!</div> ");
                                        out.println("<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                        out.println("</did>");
                                        hidden="hidden";
                        } else {
                                        out.println("<div class=\"container mt-5\">");
                                        out.println("<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudieron modificar los datos en la BD. <br>"
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
        <div class="container mt-5" id="containerGeneral" <%=hidden%>>
            <header>
                <h1>Editar Datos de Resistencia</h1>
                <h5>Conexion a Base Datos Remota</h5>
                <p>Fecha: <%= date %></p>
            </header>

            <div class="container">
                <div class="row">
                    <div class="col-sm">
                        <form action="editarDatosResis.jsp" method="post">
                            <div class="form-group" id="form1">
                                <span class="input-group-text">Nombre pieza</span>
                                <input type="text" class="form-control" id="nombre_pieza1" name="nombre_pieza1" value="<%=request.getParameter("nombre_pieza")%>" aria-label="Disabled input" disabled>
                                <input type="hidden" class="form-control" id="nombre_pieza" name="nombre_pieza" value="<%=request.getParameter("nombre_pieza")%>">
                            </div>

                            <div class="form-group" id="form1">
                                <span class="input-group-text">Categoría de Ensayo</span>
                                <input type="text" class="form-control" id="ensayo_categoria1" name="ensayo_categoria1" value="<%=request.getParameter("ensayo_categoria")%>" aria-label="Disabled input" disabled>
                                <input type="hidden" class="form-control" id="ensayo_categoria" name="ensayo_categoria" value="<%=request.getParameter("ensayo_categoria")%>">
                                <input type="hidden" class="form-control" id="id_ensayo" name="id_ensayo" value="<%=id_ensayo%>">
                            </div>

                            <!-- Resistencia -->
                            <div class="form-group" id="resistencia">
                                <b>Datos Resistencia - Id_resistencia: <%=id_resistencia%> - Id_ensayo: <%=id_ensayo%></b>

                                <div class="containerDatos2">    
                                    <div class="row gy-2 gx-3 align-items-center" id="form1">
                                        <div class="col-sm-2">
                                            <div class="input-group" id="rm_max">
                                                <span class="input-group-text">Rm (max.)</span>
                                                <input type="number" class="form-control" id="rm_max_v" name="rm_max" value="<%=rm_max%>" min="0" max="1500" step="1" onclick="promedioRm()" onchange="promedioRm()">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="rm_min">
                                                <span class="input-group-text">Rm (min.)</span>
                                                <input type="number" class="form-control" id="rm_min_v" name="rm_min" value="<%=rm_min%>" min="0" max="1500" step="1" onclick="promedioRm()" onchange="promedioRm()">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="rm_medio">
                                                <span class="input-group-text">Rm medio</span>
                                                <input type="number" class="form-control" id="rm_medio_v" name="rm_medio" value="<%=rm_medio%>" readonly="readonly">
                                                <span id="rm_medio"></span>
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="rm_90">
                                                <span class="input-group-text">Rm 90°</span>
                                                <input type="number" class="form-control" id="rm_90" name="rm_90" value="<%=rm_90%>" min="0" max="1500" step="1">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="rm_unico">
                                                <span class="input-group-text">Rm único</span>
                                                <input type="number" class="form-control" name="rm_unico" value="<%=rm_unico%>" min="0" max="1500" step="1">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="sigma_02">
                                                <span class="input-group-text">Sigma 0.2</span>
                                                <input type="number" class="form-control" name="sigma_02" value="<%=sigma_02%>" min="0" max="1500" step="1">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="lim_elastico">
                                                <span class="input-group-text">Lim Elástico</span>
                                                <input type="number" class="form-control" name="lim_elastico" value="<%=lim_elastico%>" min="0" max="1500" step="1">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="containerDatos2">    
                                    <div class="row gy-2 gx-3 align-items-center" id="form1">
                                        <div class="col-sm-2">
                                            <div class="input-group" id="rp_max">
                                                <span class="input-group-text">Rp max</span>
                                                <input type="number" class="form-control" id="rp_max_v" name="rp_max" value="<%=rp_max%>" min="0" max="1500" step="1" onclick="promedioRp()" onchange="promedioRp()">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="rp_min">
                                                <span class="input-group-text">Rp min</span>
                                                <input type="number" class="form-control" id="rp_min_v" name="rp_min" value="<%=rp_min%>" min="0" max="1500" step="1" onclick="promedioRp()" onchange="promedioRp()">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="rp_promedio">
                                                <span class="input-group-text">Rp prom.</span>
                                                <input type="number" class="form-control" id="rp_promedio_v" name="rp_promedio" value="<%=rp_promedio%>" readonly="readonly">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="rp_unico">
                                                <span class="input-group-text">Rp unico</span>
                                                <input type="number" class="form-control" name="rp_unico" value="<%=rp_unico%>" min="0" max="1500" step="1">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="containerDatos2">    
                                    <div class="row gy-2 gx-3 align-items-center" id="form1">
                                        <div class="col-sm-3">
                                            <div class="input-group" id="lim_fluencia_max">
                                                <span class="input-group-text">Lim. Fluencia Max</span>
                                                <input type="number" class="form-control" name="lim_fluencia_max" value="<%=lim_fluencia_max%>" min="0" max="1500" step="1">
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="input-group" id="lim_fluencia_min">
                                                <span class="input-group-text">Lim. Fluencia Min</span>
                                                <input type="number" class="form-control" name="lim_fluencia_min" value="<%=lim_fluencia_min%>" min="0" max="1500" step="1">
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="input-group" id="lim_fluencia_unico">
                                                <span class="input-group-text">Lim. Fluencia Único</span>
                                                <input type="number" class="form-control" name="lim_fluencia_unico" value="<%=lim_fluencia_unico%>" min="0" max="1500" step="1">
                                            </div>
                                        </div>
                                    </div>
                                </div>

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

                            <div>       
                                <button type="submit" id="form1" name="enviar" class="btn btn-primary">Actualizar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                                <a href="ensayos.jsp" class="btn btn-danger" id="form1">Cancelar <i class="fa fa-ban" aria-hidden="true"></i></a>

                            </div>    
                        </form>

                    </div>
                </div>
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
                           setInputDate("#fecha_ensayo");  
                        
                      var ensayo_categoria = document.getElementById("ensayo_categoria").value;
                    
                      var rm_max = document.getElementById("rm_max");
                      var rm_min = document.getElementById("rm_min");
                      var rm_medio = document.getElementById("rm_medio");
                      var rm_90 = document.getElementById("rm_90");
                      var rm_unico = document.getElementById("rm_unico");
                      var sigma_02 = document.getElementById("sigma_02");
                      var lim_elastico = document.getElementById("lim_elastico");
                      var rp_max = document.getElementById("rp_max");
                      var rp_min = document.getElementById("rp_min");
                      var rp_promedio = document.getElementById("rp_promedio");
                      var rp_unico = document.getElementById("rp_unico");
                      var lim_fluencia_max = document.getElementById("lim_fluencia_max");
                      var lim_fluencia_min = document.getElementById("lim_fluencia_min");
                      var lim_fluencia_unico = document.getElementById("lim_fluencia_unico");

                                     if(ensayo_categoria === "Material Norma"){
                                             rm_max.hidden = false;
                                             rm_min.hidden = false;
                                             rm_90.hidden = false;
                                             rm_medio.hidden = false;
                                             rm_unico.hidden = true;
                                             sigma_02.hidden = false;
                                             lim_elastico.hidden = false;
                                             rp_max.hidden = false;
                                             rp_min.hidden = false;
                                             rp_promedio.hidden = false;
                                             rp_unico.hidden = true;
                                             lim_fluencia_max.hidden = false;
                                             lim_fluencia_min.hidden = false;
                                             lim_fluencia_unico.hidden = true;
                        
                                     } else {
                                             rm_max.hidden = true;
                                             rm_min.hidden = true;
                                             rm_90.hidden = true;
                                             rm_medio.hidden = true;
                                             rm_unico.hidden = false;
                                             sigma_02.hidden = false;
                                             lim_elastico.hidden = false;
                                             rp_max.hidden = true;
                                             rp_min.hidden = true;
                                             rp_promedio.hidden = true;
                                             rp_unico.hidden = false;
                                             lim_fluencia_max.hidden = true;
                                             lim_fluencia_min.hidden = true;
                                             lim_fluencia_unico.hidden = false;
                                     }
                
                      function promedioRm(){
                         var rm_min_v = parseFloat(document.getElementById("rm_min_v").value);
                         var rm_max_v = parseFloat(document.getElementById("rm_max_v").value);
                         var resultado = 0;

                         if (rm_max_v >= rm_min_v){
                             var resultado = (((rm_max_v - rm_min_v) / 2) + (rm_min_v));
                         }
                         document.getElementById("rm_medio_v").value = Math.round(resultado);
                     }

                      function promedioRp(){
                         var rp_min_v = parseFloat(document.getElementById("rp_min_v").value);
                         var rp_max_v = parseFloat(document.getElementById("rp_max_v").value);
                         var resultado = 0;

                         if (rp_max_v >= rp_min_v){
                             var resultado = (rp_max_v + rp_min_v) / 2;
                         }
                         document.getElementById("rp_promedio_v").value = Math.round(resultado);
                     }

            </script>               
                <p class="footer">Developed by Germán Montalbetti ©2021</p>
        </div>                   
    </body>
</html>
