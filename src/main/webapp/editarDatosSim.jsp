<%-- 
    Document   : editarDatosSim
    Created on : 14/10/2021, 12:15:48
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>

<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.InputStream"%>
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
        <title>Editar Datos Archivo Sim</title>
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
        String checkedmejor = "";
        String checkedpeor = "";
        String checkedmejorpeor = "";
        String checkedsincambio = "";
        
        //Datos n y r ----------------
        int id_archivos_sim = 0;
        int id_ensayo_fin = 0;
        String url_archivo_sim = "";
        String nombre_archivo_sim = "";
        String descripcion_sim = "";
        String nombre_archivo_mat = "";
        String url_archivo_mat = "";
        String semaforo = "";
        
            try {
                Connection con = null;
                Statement st = null;
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(urldb, usuariodb, passdb);
                st = con.createStatement();
                rs = st.executeQuery("SELECT * FROM archivos_sim where id_ensayo='" + id_ensayo + "'");                                                                 
                    if(rs.next()){
                            id_archivos_sim = rs.getInt(1);
                            id_ensayo_fin = rs.getInt(2);
                            url_archivo_sim = rs.getString(5);
                            nombre_archivo_sim = rs.getString(6);
                            nombre_archivo_mat = rs.getString(7);
                            url_archivo_mat = rs.getString(8);
                            descripcion_sim = rs.getString(10);
                            semaforo = rs.getString(11);
                    }
                    rs.close();
                    st.close();
                    con.close();

            } catch (Exception e) {
                      out.print(e);
            }
            //Semaforo values ----------------------------------
                    if(semaforo.equalsIgnoreCase("Mejoro")){
                        checkedmejor = "checked";
                        checkedpeor = "";
                        checkedmejorpeor = "";
                        checkedsincambio = "";
                    } else if (semaforo.equalsIgnoreCase("Empeoro")){
                        checkedmejor = "";
                        checkedpeor = "checked";
                        checkedmejorpeor = "";
                        checkedsincambio = "";
                    } else if (semaforo.equalsIgnoreCase("Sin cambios")){
                        checkedmejor = "";
                        checkedpeor = "";
                        checkedmejorpeor = "";
                        checkedsincambio = "checked";
                    } else {
                        checkedmejor = "";
                        checkedpeor = "";
                        checkedmejorpeor = "checked";
                        checkedsincambio = "";
                    }       
                    
        if (request.getParameter("enviar") != null ) {
                    //Datos archivo sim --------------
                    String id_ensayo_end = request.getParameter("id_ensayo");
                    String url_archivo_sim_fin = request.getParameter("urlArchivoSim");
                    String nombre_archivo_sim_fin = request.getParameter("nombreArchivoSim");
                    String descripcion_sim_fin = request.getParameter("descripcion_sim");
                    String semaforo_fin = request.getParameter("valorRadio");
                    String nombre_archivo_mat_fin = request.getParameter("nombreArchivoMat");
                    String url_archivo_mat_fin = request.getParameter("urlArchivoMat");
                    
                    //InputStream inputStream = null;
                    //    Part filePart = request.getPart("archivoMat");
                    //    if (filePart!=null){
                    //        inputStream = filePart.getInputStream();
                    //    }
                    
                    String fecha = request.getParameter("fecha_ensayo");
                    String ultima_modif_sim = request.getParameter("registrado_por");
                    
                if(id_ensayo != null){
                    
                    try {
                        Connection con = null;
                        Statement st = null;
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(urldb, usuariodb, passdb);
                        st = con.createStatement();
                        
                        String sql = "UPDATE `ensayos` SET `estatus`='Datos Actualizados' WHERE `id_ensayo`=" + id_ensayo_end + ";";
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
                        
                        String sql = "UPDATE `archivos_sim` SET `url_archivo_sim`='" + url_archivo_sim_fin + "',`nombre_archivo_sim`='" + nombre_archivo_sim_fin +
                                    "',`nombre_archivo_mat`='" + nombre_archivo_mat_fin + "',`url_archivo_mat`='" + url_archivo_mat_fin + //"`imagen_mat`='" + inputStream +
                                    "',`descripcion_sim`='" + descripcion_sim_fin + "',`semaforo`='" + semaforo_fin +
                                    "',`fecha`='" + fecha + "',`ultima_modif_sim`='" + ultima_modif_sim +
                                    "' WHERE `id_ensayo`=" + id_ensayo_end + ";";
                        
                        int count = st.executeUpdate(sql);
    //    out.println("Sintaxsys sql: " + sql);
    //    out.println("Count value: " + count);
                        if(count > 0){
                                        out.println("<div class=\"container mt-5\">");
                                        out.println("<div class=\"alert alert-success\" role=\"alert\"> Datos de Archivo Sim modificados con éxito en la BD! <br>"
                                                + " Los datos de n y r del Ensayo Id#: " + id_ensayo + " Categoría: " + ensayo_categoria + "<br>De la pieza: " + nombre_pieza + "<br> fueron modificados con éxito en la BD!</div> ");
                                        out.println("<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>");
                                        out.println("</did>");
                                        hidden="hidden";
                        } else {
                                        out.println("<div class=\"container mt-5\">");
                                        out.println("<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo modificar los datos de Archivo Sim en la BD. <br>"
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
                <h1>Editar Datos Archivo Sim</h1>
                <h5>Conexion a Base Datos Remota</h5>
                <p>Fecha: <%= date %></p>
            </header>

            <div class="container">
                <div class="row">
                    <div class="col-sm">
                        <form action="editarDatosSim.jsp" method="post">

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

                            <!-- Archivos sim -->
                            <div class="form-group" id="sim">
                                <b>Datos Archivos SIM - ID_sim: <%=id_archivos_sim%> - Id_ensayo: <%=id_ensayo%></b>


                                <div class="containerDatos4">    
                                    <div class="row gy-2 gx-3 align-items-center" id="form1">
                                        <div class="mb-3">
                                            <div class="form-group" id="form1">
                                                <label for="formFile" class="form-label">Seleccionar Archivo .afd</label>
                                                <input class="form-control" type="file" id="archivoSim" accept=".afd" onchange="processSelectedFiles(this);">
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <div class="input-group" id="url_archivoSim">
                                                <div class="input-group-text">URL Archivo .afd</div>
                                                <input type="text" class="form-control" id="urlArchivoSim" value="<%=url_archivo_sim%>" name="urlArchivoSim" placeholder="Copie y pegue la URL correspondiente al archivo .afd">
                                            </div>
                                        </div>
                                        <div class="input-group mb-3">
                                            <span class="input-group-text" id="basic-addon1">Nombre Archivo .afd</span>
                                            <input type="text" class="form-control" id="nombreArchivoSimT" value="<%=nombre_archivo_sim%>" readonly="readonly">
                                            <input type="hidden" class="form-control" id="nombreArchivoSim" name="nombreArchivoSim" value="<%=nombre_archivo_sim%>">
                                        </div>    
                                    </div>
                                </div>

                                <div class="containerDatos4">
                                    <div class="form-group" id="form1">
                                        <span class="input-group-text">Descripción de Ensayo Simulación</span>
                                        <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="descripcion_sim" aria-label="Descripcion"><%=descripcion_sim%></textarea>
                                    </div>
                                    <div class="containerDatos4">
                                        <div class="form-group" id="form1" onchange="processSelectedRadio();">
                                            <span class="input-group-text">Semáforo de Ensayo Simulación</span>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radio" value="Mejoro" id="flexRadioDefault1" <%=checkedmejor%>>
                                                <label class="form-check-label" for="flexRadioDefault1">Mejoró</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radio" value="Empeoro" id="flexRadioDefault2" <%=checkedpeor%>>
                                                <label class="form-check-label" for="flexRadioDefault2">Empeoró</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radio" value="Mejoro algunas zonas, Empeoro otras" id="flexRadioDefault3" <%=checkedmejorpeor%>>
                                                <label class="form-check-label" for="flexRadioDefault3">Mejoró algunas zonas, Empeoró otras</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radio" value="Sin cambios" id="flexRadioDefault4" <%=checkedsincambio%>>
                                                <label class="form-check-label" for="flexRadioDefault4">Sin cambios</label>
                                            </div>
                                            <input type="hidden" class="form-control" id="valorRadio" name="valorRadio" value="Mejoro">
                                        </div>
                                    </div>
                                </div>  

                                <div class="containerDatos4">
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
                                                <input type="text" class="form-control" id="urlArchivoMat" name="urlArchivoMat" value="<%=url_archivo_mat%>" placeholder="Copie y pegue la URL correspondiente al archivo .mat">
                                            </div>
                                        </div>
                                        <div class="input-group mb-3">
                                            <span class="input-group-text" id="basic-addon1">Nombre Archivo .mat</span>
                                            <input type="text" class="form-control" id="nombreArchivoMatT" value="<%=nombre_archivo_mat%>" readonly="readonly">
                                            <input type="hidden" class="form-control" id="nombreArchivoMat" name="nombreArchivoMat" value="<%=nombre_archivo_mat%>">
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
                <p class="footer">Developed by Germán Montalbetti ©2021</p>
        </div>                   
    </body>
</html>


