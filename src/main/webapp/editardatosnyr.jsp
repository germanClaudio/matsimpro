<%-- 
    Document   : editardatosnyr
    Created on : 14/10/2021, 11:18:02
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
        <link rel="stylesheet" href="css/estiloCargaDatosEnsayo.css"/>
        <title>Editar Datos n y r</title>
    </head>
    <%
        String fecha = FormatoFecha.formaFecha();
        Statement st = null;
        ResultSet rs = null;
        
        //String id_pieza = request.getParameter("id_pieza");
        String id_ensayo = request.getParameter("id_ensayo");
        String nombre_pieza = request.getParameter("nombre_pieza");
        String ensayo_categoria = request.getParameter("ensayo_categoria");
        String hidden = "";
        
        //Datos n y r ----------------
        int id_datos_n_r = 0;
        int id_ensayo_fin = 0;
        double n_0 = 0;
        double n_45 = 0;
        double n_90 = 0;
        double r_0 = 0;
        double r_45 = 0;
        double r_90 = 0;
        double r_m = 0;
        double delta_r = 0;
        
            try {
                Connection con = connection.conectar();
                st = con.createStatement();
                String sql = "SELECT * FROM datos_n_r where id_ensayo='" + id_ensayo + "'";
                rs = st.executeQuery(sql);                                                                 
                    if(rs.next()){
                            id_datos_n_r = rs.getInt(1);
                            id_ensayo_fin = rs.getInt(2);
                            n_0 = rs.getDouble(5);
                            n_45 = rs.getDouble(6);
                            n_90 = rs.getDouble(7);
                            r_0 = rs.getDouble(8);
                            r_45 = rs.getDouble(9);
                            r_90 = rs.getDouble(10);
                            r_m = rs.getDouble(11);
                            delta_r = rs.getDouble(12);
                    }
                    rs.close();
                    st.close();
                    con.close();
            } catch (Exception e) {
                      out.print(e);
            }
    
        if (request.getParameter("enviar") != null ) { //Datos resistencia----------------
            String id_ensayo_end = request.getParameter("id_ensayo");
            String n_0_fin = request.getParameter("n_0");
            String n_45_fin = request.getParameter("n_45");
            String n_90_fin = request.getParameter("n_90");
            String r_0_fin = request.getParameter("r_0");
            String r_45_fin = request.getParameter("r_45");
            String r_90_fin = request.getParameter("r_90");
            String r_m_fin = request.getParameter("r_m");
            String delta_r_fin = request.getParameter("delta_r");

            String fecha_datos_n_r = request.getParameter("fecha_ensayo");
            String ultima_modif_datos_nr = request.getParameter("registrado_por");
                    
                if(id_ensayo != null){
                    try {
                        Connection con = connection.conectar();
                        st = con.createStatement();
                        String sql = "UPDATE `ensayos` SET `estatus`='Datos Actualizados'  WHERE `id_ensayo`=" + id_ensayo_end + ";";
                        st.executeUpdate(sql);
                        st.close();
                        con.close();
                
                    } catch (SQLException e) {
                            out.print(e);
                    }  //-----------------------------------------------------
                    try {
                        Connection con = connection.conectar();
                        st = con.createStatement();
                        String sql = "UPDATE `datos_n_r` SET `n_0`=" + n_0_fin + ",`n_45`=" + n_45_fin + ",`n_90`=" + n_90_fin +
                                    ",`r_0`=" + r_0_fin + ",`r_45`=" + r_45_fin + ",`r_90`=" + r_90_fin + 
                                    ",`r_m`=" + r_m_fin + ",`delta_r`=" + delta_r_fin +
                                    ",`fecha_datos_n_r`='" + fecha_datos_n_r + "',`ultima_modif_datos_nr`='" + ultima_modif_datos_nr +
                                    "' WHERE `id_ensayo`=" + id_ensayo_end + ";";
                        
                        int count = st.executeUpdate(sql);
                    //out.println("Sintaxsys sql: " + sql);
                    //out.println("Count value: " + count);
                        if(count > 0){
                            out.println(  "<div class=\"container mt-5\">"
                                        + "<div class=\"alert alert-success\" role=\"alert\"> Datos de n y r modificados con éxito a la BD! <br>"
                                        + " Los datos de n y r del Ensayo Id#: " + id_ensayo + " Categoría: " + ensayo_categoria + "<br>De la pieza: " + nombre_pieza + "<br> fueron modificados con éxito en la BD!</div> "
                                        + "<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                        + "</did>");
                            hidden="hidden";
                        } else {
                            out.println(  "<div class=\"container mt-5\">"
                                        + "<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo modificar los datos n y r en la BD. <br>"
                                        + " Puede que los datos del ensayo no se hayan cargado aún. Verifique la información ingresada e intentelo nuevamente por favor. </div> "
                                        + "<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                        + "</did>");
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
        <div class="container mt-5" id="containerGeneral"<%=hidden%>>
            <header>
                <h1>Editar Datos n y r</h1>
                <h5>Conexion a Base Datos Remota</h5>
                <p>Fecha: <%= fecha %></p>
            </header>
            <div class="container">
                <div class="row">
                    <div class="col-sm">
                        <form action="editardatosnyr.jsp" method="post">
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
                            <!-- Datos n y r -->
                            <div class="form-group" id="datos">
                                <span <b>Datos n y r - Id n y r: <%=id_datos_n_r%> - Id ensayo: <%=id_ensayo%></b></span>
                                <div class="containerDatos3">    
                                    <div class="row gy-2 gx-3 align-items-center" id="form1">
                                        <div class="col-sm-2">
                                            <div class="input-group" id="n_0">
                                                <span class="input-group-text">n 0°</span>
                                                <input type="number" class="form-control" id="n_0_v" name="n_0" value="<%=n_0%>" min="0" max="2" step="0.001">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="n_45">
                                                <span class="input-group-text">n 45°</span>
                                                <input type="number" class="form-control" id="n_45_v" name="n_45" value="<%=n_45%>" min="0" max="2" step="0.001">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="n_90">
                                                <span class="input-group-text">n 90°</span>
                                                <input type="number" class="form-control" id="n_90_v" name="n_90" value="<%=n_90%>" min="0" max="2" step="0.001">
                                            </div>
                                        </div>
                                    </div>
                                </div>      
                                <div class="containerDatos3">    
                                    <div class="row gy-2 gx-3 align-items-center" id="form1">
                                        <div class="col-sm-2">
                                            <div class="input-group" id="r_0">
                                                <span class="input-group-text">r 0°</span>
                                                <input type="number" class="form-control" id="r_0_v" name="r_0" value="<%=r_0%>" min="0" max="3" step="0.01" onclick="promedio_r();" onchange="promedio_r();">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="r_45">
                                                <span class="input-group-text">r 45°</span>
                                                <input type="number" class="form-control" id="r_45_v" name="r_45" value="<%=r_45%>" min="0" max="3" step="0.01" onclick="promedio_r();" onchange="promedio_r();">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="r_90">
                                                <span class="input-group-text">r 90°</span>
                                                <input type="number" class="form-control" id="r_90_v" name="r_90" value="<%=r_90%>" min="0" max="3" step="0.01" onclick="promedio_r();" onchange="promedio_r();">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="r_m">
                                                <span class="input-group-text">r m</span>
                                                <input type="number" class="form-control" id="r_m_v" name="r_m" value="<%=r_m%>" readonly="readonly">
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group" id="delta_r">
                                                <span class="input-group-text">Delta r</span>
                                                <input type="number" class="form-control" id="delta_rv" name="delta_r" value="<%=delta_r%>" readonly="readonly">
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
                        <a title="Volver" href="ensayos.jsp" class="btn btn-danger" id="form1">Cancelar <i class="fa fa-ban" aria-hidden="true"></i></a>
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
                    
                function promedio_r(){
                      var r0 = parseFloat(document.getElementById("r_0_v").value);
                      var r45 = parseFloat(document.getElementById("r_45_v").value);
                      var r90 = parseFloat(document.getElementById("r_90_v").value);

                      if (r0 !== 0 || r45 !== 0 || r90 !== 0){
                          var resultadop = parseFloat((r0 + (2 * r45) + r90)/4);
                          var resultadod = parseFloat((r0 - (2 * r45) + r90)/2);
                      }
                          document.getElementById("r_m_v").value = resultadop.toFixed(3);
                          document.getElementById("delta_rv").value = resultadod.toFixed(3);
                }
        </script>               
        <p class="footer">Developed by Germán Montalbetti ©2021</p>
    </div>                   
</body>
</html>

