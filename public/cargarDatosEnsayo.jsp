<%-- 
    Document   : cargarDatosEnsayo
    Created on : 24/09/2021, 16:04:48
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%--
    <%@page import="javafx.stage.FileChooser"%>
    <%@page import="javafx.scene.shape.Path"%>
    <%@page import="java.io.FileOutputStream"%>
    <%@page import="java.nio.file.Paths"%>
    <%@page import="java.io.InputStreamReader"%>
    <%@page import="java.io.BufferedReader"%>
    <%@page import="java.io.InputStream"%>
    <%@page import="java.io.FileInputStream"%>
    <%@page import="java.io.File"%>
    <%@page import="javax.swing.plaf.multi.MultiFileChooserUI"%>
    <%@page import="java.io.OutputStream"%>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/estilo.css"/>
        <title>Cargar Datos Ensayos</title>

    </head>
    <%
        Date date = new Date();
        HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
        
        PreparedStatement pstmt = null;
        //ResultSet rs = null;
        
        String urldb = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
        String usuariodb = "cadcam1_german"; 
        String passdb = "12345";
               
        String username = request.getParameter("username");
        String nombre_pieza = request.getParameter("nombre_pieza");
        String ensayo_categoria = request.getParameter("ensayo_categoria");
        String id_ensayo = request.getParameter("id_ensayo");
        String estatus = request.getParameter("estatus");
        //int id_pieza = Integer.parseInt(request.getParameter("id_pieza"));
        String hidden="";
        
        try{
                String driverName2 = "com.mysql.cj.jdbc.Driver";
                        
                Connection con = null;
                Class.forName(driverName2);
                con = DriverManager.getConnection(urldb, usuariodb, passdb);
                Statement st = con.createStatement();
                String sql = "SELECT `estatus` FROM `ensayos` where id_ensayo='" + id_ensayo + "' and estatus='Nuevo Ensayo S/D'";
                
                PreparedStatement pre12 = con.prepareStatement(sql);
                ResultSet rs = pre12.executeQuery();
                
                    if(rs.next()){
                                hidden="";
                            } else {
                                hidden="hidden";
                                out.println("<div class=\"container mt-5\">");
                                out.println("<div class=\"alert alert-danger\" role=\"alert\"> No se pudo cargar la interface para carga de Datos de ensayo! <br>"
                                    + " Recuerde que solo se puede registrar datos del estatus de ensayo: \"Nuevo Ensayo S/D\" </div> ");
                                out.println("<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                out.println("</div>");
                    }
                        rs.close();
                        con.close();
       
        } catch(SQLException e){
                out.println(e.getMessage());              
        }
 
    %>    
    <body>
        <div <%=hidden%>>
        <div class="container mt-3" style="background-color: #23a2dd;">
            <h1>Ingreso de Datos al Nuevo Ensayo: <%=ensayo_categoria%> <i class="bi bi-clipboard-data"></i></h1>
            <h5>Conexion a Base Datos Remota</h5>
            <p>Fecha: <%=date%></p>
        </div>

        <div class="container mt-3">
            <div class="row">
                <div class="col-sm">

                    <form  method="post" action="UploadDatosEnsayo" enctype="multipart/form-data">

                        <div class="form-group" id="form1">
                            <span class="input-group-text">Nombre pieza</span>
                            <input type="text" class="form-control" id="nombre_pieza1" name="nombre_pieza1" value="<%=request.getParameter("nombre_pieza")%>" aria-label="Disabled input" disabled>
                            <input type="hidden" class="form-control" id="nombre_pieza" name="nombre_pieza" value="<%=request.getParameter("nombre_pieza")%>">
                        </div>

                        <div class="form-group" id="form1">
                            <span class="input-group-text">Categoria de Ensayo</span>
                            <input type="text" class="form-control" id="ensayo_categoria1" name="ensayo_categoria1" value="<%=request.getParameter("ensayo_categoria")%>" aria-label="Disabled input" disabled>
                            <input type="hidden" class="form-control" id="ensayo_categoria" name="ensayo_categoria" value="<%=request.getParameter("ensayo_categoria")%>">
                        </div>

                        <!-- Alargamiento -->
                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #e3a25d"><b>Datos de Alargamiento</b></span>
                        </div>      

                        <div class="container mt-2">    
                            <div class="row gy-2 gx-3 align-items-center" id="form1">
                                <div class="col-sm-2">
                                    <div class="input-group" id="a_porcentual">
                                        <div class="input-group-text">Alarg.</div>
                                        <input type="number" class="form-control" name="a_porcentual" placeholder="20%" min="0" max="55" step="1" value="20">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="ag_porcentual">
                                        <div class="input-group-text">Ag.</div>
                                        <input type="number" class="form-control" name="ag_porcentual" placeholder="20%" min="0" max="55" step="0.1" value="0">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="ag_90_porcentual">
                                        <div class="input-group-text">Ag. 90°</div>
                                        <input type="number" class="form-control" name="ag_90_porcentual" placeholder="20%" min="0" max="55" step="0.1" value="0">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="a_50">
                                        <div class="input-group-text">A-50</div>
                                        <input type="number" class="form-control" name="a_50" min="0" max="55" step="0.1" value="0">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="a_80">
                                        <div class="input-group-text">A-80</div>
                                        <input type="number" class="form-control" name="a_80" min="0" max="55" step="0.1" value="0">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="a_80_90">
                                        <div class="input-group-text">A-80(90°)</div>
                                        <input type="number" class="form-control" name="a_80_90" min="0" max="55" step="0.1" value="0">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="a_80_minimo">
                                        <div class="input-group-text">A-80(mín)</div>
                                        <input type="number" class="form-control" name="a_80_minimo" min="0" max="55" step="0.1" value="0">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #e3a25d"></span>
                        </div>

                        <!-- Resistencia -->
                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #22a25d"><b>Datos Resistencia</b></span>
                        </div>
                        <div class="container mt-2">    
                            <div class="row gy-2 gx-3 align-items-center" id="form1">
                                <div class="col-sm-2">
                                    <div class="input-group" id="rm_max">
                                        <div class="input-group-text">Rm(max.)</div>
                                        <input type="number" class="form-control" id="rm_max_v" name="rm_max" value="0" min="0" max="1500" step="1" onclick="promedioRm()" onchange="promedioRm()">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="rm_min">
                                        <div class="input-group-text">Rm(min.)</div>
                                        <input type="number" class="form-control" id="rm_min_v" name="rm_min" value="0" min="0" max="1500" step="1" onclick="promedioRm()" onchange="promedioRm()">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="rm_medio">
                                        <div class="input-group-text">Rm medio</div>
                                        <input type="number" class="form-control" id="rm_medio_v" name="rm_medio" value="0" readonly="readonly">
                                        <label id="rm_medio"></label>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="rm_90">
                                        <div class="input-group-text">Rm 90°</div>
                                        <input type="number" class="form-control" id="rm_90" name="rm_90" value="0" min="0" max="1500" step="1">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="rm_unico">
                                        <div class="input-group-text">Rm único</div>
                                        <input type="number" class="form-control" name="rm_unico" value="0" min="0" max="1500" step="1">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="sigma_02">
                                        <div class="input-group-text">Sigma 0.2</div>
                                        <input type="number" class="form-control" name="sigma_02" value="0" min="0" max="1500" step="1">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="lim_elastico">
                                        <div class="input-group-text">Lim Elástico</div>
                                        <input type="number" class="form-control" name="lim_elastico" value="0" min="0" max="1500" step="1">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="container mt-2">    
                            <div class="row gy-2 gx-3 align-items-center" id="form1">
                                <div class="col-sm-2">
                                    <div class="input-group" id="rp_max">
                                        <div class="input-group-text">Rp max</div>
                                        <input type="number" class="form-control" id="rp_max_v" name="rp_max" value="0" min="0" max="1500" step="1" onclick="promedioRp()" onchange="promedioRp()">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="rp_min">
                                        <div class="input-group-text">Rp min</div>
                                        <input type="number" class="form-control" id="rp_min_v" name="rp_min" value="0" min="0" max="1500" step="1" onclick="promedioRp()" onchange="promedioRp()">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="rp_promedio">
                                        <div class="input-group-text">Rp prom</div>
                                        <input type="number" class="form-control" id="rp_promedio_v" name="rp_promedio" value="0" readonly="readonly">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="rp_unico">
                                        <div class="input-group-text">Rp unico</div>
                                        <input type="number" class="form-control" name="rp_unico" value="0" min="0" max="1500" step="1">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="container mt-2">    
                            <div class="row gy-2 gx-3 align-items-center" id="form1">
                                <div class="col-sm-3">
                                    <div class="input-group" id="lim_fluencia_max">
                                        <div class="input-group-text">Lim. Fluencia Max</div>
                                        <input type="number" class="form-control" name="lim_fluencia_max" value="0" min="0" max="1500" step="1">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="input-group" id="lim_fluencia_min">
                                        <div class="input-group-text">Lim. Fluencia Min</div>
                                        <input type="number" class="form-control" name="lim_fluencia_min" value="0" min="0" max="1500" step="1">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="input-group" id="lim_fluencia_unico">
                                        <div class="input-group-text">Lim. Fluencia Unico</div>
                                        <input type="number" class="form-control" name="lim_fluencia_unico" value="0" min="0" max="1500" step="1">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #22a25d"></span>
                        </div>


                        <!-- Datos n y r -->
                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #2282fd"><b>Datos n y r</b></span>
                        </div>

                        <div class="container mt-2">    
                            <div class="row gy-2 gx-3 align-items-center" id="form1">
                                <div class="col-sm-2">
                                    <div class="input-group" id="n_0">
                                        <div class="input-group-text">n 0°</div>
                                        <input type="number" class="form-control" id="n_0_v" name="n_0" value="0" min="0" max="2" step="0.001">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="n_45">
                                        <div class="input-group-text">n 45°</div>
                                        <input type="number" class="form-control" id="n_45_v" name="n_45" value="0" min="0" max="2" step="0.001">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="n_90">
                                        <div class="input-group-text">n 90°</div>
                                        <input type="number" class="form-control" id="n_90_v" name="n_90" value="0" min="0" max="2" step="0.001">
                                    </div>
                                </div>
                            </div>
                        </div>      

                        <div class="container mt-2">    
                            <div class="row gy-2 gx-3 align-items-center" id="form1">
                                <div class="col-sm-2">
                                    <div class="input-group" id="r_0">
                                        <div class="input-group-text">r 0°</div>
                                        <input type="number" class="form-control" id="r_0_v" name="r_0" value="0" min="0" max="3" step="0.01" onclick="promedio_r();" onchange="promedio_r();">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="r_45">
                                        <div class="input-group-text">r 45°</div>
                                        <input type="number" class="form-control" id="r_45_v" name="r_45" value="0" min="0" max="3" step="0.01" onclick="promedio_r();" onchange="promedio_r();">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="r_90">
                                        <div class="input-group-text">r 90°</div>
                                        <input type="number" class="form-control" id="r_90_v" name="r_90" value="0" min="0" max="3" step="0.01" onclick="promedio_r();" onchange="promedio_r();">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="r_m">
                                        <div class="input-group-text">r m</div>
                                        <input type="number" class="form-control" id="r_m_v" name="r_m" value="0" readonly="readonly">
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group" id="delta_r">
                                        <div class="input-group-text">Delta r</div>
                                        <input type="number" class="form-control" id="delta_rv" name="delta_r" value="0" readonly="readonly">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #2282fd"></span>
                        </div>

                        <!-- Archivos sim -->
                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #f2322d"><b>Datos Archivos SIM</b></span>
                        </div>

                        <div class="container mt-2">    
                            <div class="row gy-2 gx-3 align-items-center" id="form1">
                                <div class="mb-3">
                                    <div class="form-group" id="form1">
                                        <label for="formFile" class="form-label">Seleccionar Archivo .sim</label>
                                        <input class="form-control" type="file" id="archivoSim" accept=".afd" onchange="processSelectedFiles(this);">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="input-group" id="url_archivoSim">
                                        <div class="input-group-text">URL Archivo .afd</div>
                                        <input type="text" class="form-control" id="urlArchivoSim" name="urlArchivoSim" placeholder="Copie y pegue la URL correspondiente al archivo .afd">
                                    </div>
                                </div>
                                <div class="input-group mb-3">
                                    <span class="input-group-text" id="basic-addon1">Nombre Archivo .sim</span>
                                    <input type="text" class="form-control" id="nombreArchivoSimT" readonly="readonly">
                                    <input type="hidden" class="form-control" id="nombreArchivoSim" name="nombreArchivoSim">
                                </div>    
                            </div>
                        </div>

                        <div class="container mt-2">
                            <div class="row gy-2 gx-3 align-items-center" id="form1">
                                <div class="mb-3">
                                    <div class="form-group" id="form1">
                                        <label for="formFile" class="form-label">Seleccionar Archivo .mat</label>
                                        <input class="form-control" type="file" id="archivoMat" name="archivoMat" accept=".mat" onchange="processSelectedmatFiles(this);">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="input-group" id="url_archivoMat">
                                        <div class="input-group-text">URL Archivo .mat</div>
                                        <input type="text" class="form-control" id="urlArchivoMat" name="urlArchivoMat" placeholder="Copie y pegue la URL correspondiente al archivo .mat">
                                    </div>
                                </div>
                                <div class="input-group mb-3">
                                    <span class="input-group-text" id="basic-addon1">Nombre Archivo .mat</span>
                                    <input type="text" class="form-control" id="nombreArchivoMatT" readonly="readonly">
                                    <input type="hidden" class="form-control" id="nombreArchivoMat" name="nombreArchivoMat">
                                </div>    
                            </div>
                        </div>

                        <div class="container mt-2">
                            <div class="form-group" id="form1">
                                <span class="input-group-text">Descripción de Ensayo Simulación</span>
                                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="descripcion_sim" aria-label="Descripcion"></textarea>
                            </div>
                            <div class="container mt-2">
                                <div class="form-group" id="form1" onchange="processSelectedRadio();">
                                    <span class="input-group-text">Semáforo de Ensayo Simulación</span>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="radio" value="Mejoro" id="flexRadioDefault1" checked>
                                        <label class="form-check-label" for="flexRadioDefault1">Mejoró</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="radio" value="Empeoro" id="flexRadioDefault2">
                                        <label class="form-check-label" for="flexRadioDefault2">Empeoró</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="radio" value="Mejoro algunas zonas, Empeoro otras" id="flexRadioDefault3">
                                        <label class="form-check-label" for="flexRadioDefault3">Mejoró algunas zonas, Empeoró otras</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="radio" value="Sin cambios" id="flexRadioDefault4">
                                        <label class="form-check-label" for="flexRadioDefault4">Sin cambios</label>
                                    </div>
                                    <input type="hidden" class="form-control" id="valorRadio" name="valorRadio" value="Mejoro">
                                </div>
                            </div>
                        </div>  


                        <div class="form-group" id="form1">
                            <span class="input-group-text" style="background-color: #f2322d"></span>
                        </div>


                        <div class="form-group" id="form1">
                            <span class="input-group-text">Estatus</span>
                            <input type="text" class="form-control" id="estatus" name="estatus" value="<%=estatus%>" readonly="readonly">
                        </div>

                        <div class="form-group" id="form1">
                            <span for="fecha" class="form-label">Fecha</span>
                            <input type="date" class="form-control" id="fecha_ensayo" name="fecha_ensayo" required="required">
                        </div>

                        <div class="form-group" id="form1">
                            <input type="hidden" class="form-control" id="registrado_por" name="ultima_modificacion" value="<%= session.getAttribute("username")%>" required="required">
                            <input type="hidden" class="form-control" id="id_pieza" name="id_pieza" value="<%= request.getParameter("id_pieza")%>">
                            <input type="hidden" class="form-control" id="id_ensayo" name="id_ensayo" value="<%= request.getParameter("id_ensayo")%>">
                        </div>

                        <fieldset disabled>
                            <div class="form-group" id="form1">
                                <label for="registrado_por2">Ultima modificacion por</label>
                                <input type="text" class="form-control" id="registrado_por2" name="ultima_modificacion2" value="<%= session.getAttribute("username")%>">
                            </div>
                        </fieldset>

                        <div style="margin-bottom: 80px;">    
                            <button type="submit" id="form1" name="enviar" value="enviar" class="btn btn-primary">Registrar Datos de Ensayo <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                            <a href="ensayos.jsp" class="btn btn-secondary" id="form1">Volver <i class="fa fa-arrow-circle-left" aria-hidden="true"></i></a>
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
    
                    function processSelectedFiles() {
                        var fullPath = document.getElementById('archivoSim').value;
                            if (fullPath) {
                                var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
                                var filename = fullPath.substring(startIndex);
                                if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
                                    filename = filename.substring(1);
                                }
                                document.getElementById("nombreArchivoSimT").value = filename.replace(/\.[^/.]+$/, "");
                                document.getElementById("nombreArchivoSim").value = filename.replace(/\.[^/.]+$/, "");
                            }
                        }
                    
                    function processSelectedmatFiles() {
                        var fullPath = document.getElementById('archivoMat').value;
                            if (fullPath) {
                                var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
                                var filename = fullPath.substring(startIndex);
                                if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
                                    filename = filename.substring(1);
                                }
                                document.getElementById("nombreArchivoMatT").value = filename.replace(/\.[^/.]+$/, "");
                                document.getElementById("nombreArchivoMat").value = filename.replace(/\.[^/.]+$/, "");
                            }
                        }
                    
                        function processSelectedRadio(){
                            var radios = document.getElementsByName('radio');
                            for (var i = 0, length = radios.length; i < length; i++) {
                                if (radios[i].checked) {
                                    var valueRadio = (radios[i].value);
                                    document.getElementById("valorRadio").value = valueRadio;
                                  // only one radio can be logically checked, don't check the rest
                                  break;
                                }
                              }    
                        }    
        </script>
      </div>  
    </body>
</html>
