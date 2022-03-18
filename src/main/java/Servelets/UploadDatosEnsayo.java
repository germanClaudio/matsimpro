package Servelets;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import utiles.connection;

/* @author Germán Montalbetti © <gmontalbetti@prodismo.com> */
@WebServlet(name = "UploadDatosEnsayo", urlPatterns = {"/UploadDatosEnsayo"})
@MultipartConfig(maxFileSize = 16177215)

public class UploadDatosEnsayo extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        int validacion = 0;
        ResultSet rs1 = null;
        Statement st1 = null;
            
        try {
            Connection con = connection.conectar();
            PreparedStatement pst1 = null;
            int id_ensayo = Integer.parseInt(request.getParameter("id_ensayo"));
            String estatus = request.getParameter("estatus");
                
            Statement st1 = con.createStatement();
            String sql = "select estatus from ensayos where id_ensayo = '" + id_ensayo + "'";
            pst1 = con.prepareStatement(sql); 
            rs1 = pst1.executeQuery();

                if (rs1.next() && estatus.equalsIgnoreCase("Datos Registrados") || (rs1.next() && estatus.equalsIgnoreCase("Datos Actualizados"))) {
                    out.println(  "<!DOCTYPE html>"
                                + "<html lang=\"en\">"
                                + "<head>"
                                + "<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"images/FondoSplash_2.ico\"/>"
                                + "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
                                + "<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU\" crossorigin=\"anonymous\">"
                                + "<link href=\"https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\" rel=\"stylesheet\" integrity=\"sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN\" crossorigin=\"anonymous\">"
                                + "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css\">"
                                + "<link rel=\"stylesheet\" href=\"css/estilo.css\"/>"
                                + "<meta http-equiv='refresh' content='6;URL=ensayos.jsp'>" //redirects after 6 seconds
                                + "<title>Carga de Datos Ensayo</title>"
                                + "</head>"
                                + "<body>"
                                + "<div class=\"container mt-5\">"
                                + "<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo registrar los datos en la BD. <br>"
                                + " Esto se debe a que el estatus del ensayo es: " + estatus + ", por lo que los datos de ensayo ya fueron registrados con anterioridad. <br>"
                                + " Si desea modificar los datos, utilice el link para Actualizar los mismos. </div>" 
                                + "<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                + "</did>"
                                + "</body>"
                                + "</html>");
                        rs1.close();
                        con.close();
                        validacion++;
                    }
        } catch (SQLException e) {
                out.print("Error al guardar datos de ensayo en BD " + e);
        } catch (ClassNotFoundException ex) {
                Logger.getLogger(UploadNuevaPieza.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if(validacion == 0){ //------------------------------------------------------------------
                Statement st=null;
                PreparedStatement pst = null;
                PreparedStatement pst2 = null;
                PreparedStatement pstmt = null;
                PreparedStatement pstmtr = null;
                PreparedStatement pstmtnr = null;
                PreparedStatement pstmtsim = null;
                ResultSet rs = null;

                int id_ensayo = Integer.parseInt(request.getParameter("id_ensayo"));
                String nombre = request.getParameter("nombre_pieza");
                String ensayo_categoria = request.getParameter("ensayo_categoria");
                String estatus = request.getParameter("estatus");
                int count=0, count2=0, count3=0, count4=0, count5=0;
                
            //Datos alargamiento----------------
                int a_porcentual = Integer.parseInt(request.getParameter("a_porcentual"));
                double ag_porcentual = Double.parseDouble(request.getParameter("ag_porcentual"));
                double ag_90_porcentual = Double.parseDouble(request.getParameter("ag_90_porcentual"));
                double a_50 = Double.parseDouble(request.getParameter("a_50"));
                double a_80 = Double.parseDouble(request.getParameter("a_80"));
                double a_80_90 = Double.parseDouble(request.getParameter("a_80_90"));
                double a_80_minimo = Double.parseDouble(request.getParameter("a_80_minimo"));
            //Datos Resistencia-----------------   
                int rm_max = Integer.parseInt(request.getParameter("rm_max"));
                int rm_min = Integer.parseInt(request.getParameter("rm_min"));
                int rm_medio = Integer.parseInt(request.getParameter("rm_medio"));
                int rm_90 = Integer.parseInt(request.getParameter("rm_90"));
                int rm_unico = Integer.parseInt(request.getParameter("rm_unico"));
                int sigma_02 = Integer.parseInt(request.getParameter("sigma_02"));
                int lim_elastico = Integer.parseInt(request.getParameter("lim_elastico"));
                int rp_max = Integer.parseInt(request.getParameter("rp_max"));
                int rp_min = Integer.parseInt(request.getParameter("rp_min"));
                int rp_promedio = Integer.parseInt(request.getParameter("rp_promedio"));
                int rp_unico = Integer.parseInt(request.getParameter("rp_unico"));
                int lim_fluencia_max = Integer.parseInt(request.getParameter("lim_fluencia_max"));
                int lim_fluencia_min = Integer.parseInt(request.getParameter("lim_fluencia_min"));
                int lim_fluencia_unico = Integer.parseInt(request.getParameter("lim_fluencia_unico"));
            //Datos n y r-----------------------
                double n_0 = Double.parseDouble(request.getParameter("n_0"));
                double n_45 = Double.parseDouble(request.getParameter("n_45"));
                double n_90 = Double.parseDouble(request.getParameter("n_90"));
                double r_0 = Double.parseDouble(request.getParameter("r_0"));
                double r_45 = Double.parseDouble(request.getParameter("r_45"));
                double r_90 = Double.parseDouble(request.getParameter("r_90"));
                double r_m = Double.parseDouble(request.getParameter("r_m"));
                double delta_r = Double.parseDouble(request.getParameter("delta_r"));
            //Datos Archivos Sim y mat----------
                String url_archivo_sim = request.getParameter("urlArchivoSim");
                String nombre_archivo_sim = request.getParameter("nombreArchivoSim");
                String nombre_archivo_mat = request.getParameter("nombreArchivoMat");
                String url_archivo_mat = request.getParameter("urlArchivoMat");
                
                InputStream inputStream = null;
                Part filePart = request.getPart("archivoMat");
                if (filePart!=null){
                    inputStream = filePart.getInputStream();
                }
                String descripcion_sim = request.getParameter("descripcion_sim");
                String id_semaforo = request.getParameter("valorRadio");
            //---------------------------------
                String fecha = request.getParameter("fecha_ensayo");
                String ultimamodificacion = request.getParameter("ultima_modificacion");
            
            //-------Alargamiento------------------------    
            try {
                Connection con = connection.conectar();
                st = con.createStatement();
                String sqla = "insert into alargamiento(id_alargamiento,id_ensayo,nombre_pieza,ensayo_categoria,a_porcentual,ag_porcentual,ag_90_porcentual,a_50,a_80,a_80_90,a_80_minimo,fecha_alargamiento,ultima_modif_alargamiento)" + "values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
                pstmt = con.prepareStatement(sqla);
                
                // Alargamiento-------------------    
                    pstmt.setInt(1, 0);
                    pstmt.setInt(2, id_ensayo);
                    pstmt.setString(3, nombre);
                    pstmt.setString(4, ensayo_categoria);
                    
                if (a_porcentual == 0) {
                    pstmt.setNull(5, java.sql.Types.INTEGER);
                } else {
                    pstmt.setInt(5, a_porcentual);
                }
                if (ag_porcentual == 0) {
                    pstmt.setNull(6, java.sql.Types.DOUBLE);
                } else {
                    pstmt.setDouble(6, ag_porcentual);
                }
                if (ag_90_porcentual == 0) {
                    pstmt.setNull(7, java.sql.Types.DOUBLE);
                } else {
                    pstmt.setDouble(7, ag_90_porcentual);
                }
                if (a_50 == 0) {
                    pstmt.setNull(8, java.sql.Types.DOUBLE);
                } else {
                    pstmt.setDouble(8, a_50);
                }
                if (a_80 == 0) {
                    pstmt.setNull(9, java.sql.Types.DOUBLE);
                } else {
                    pstmt.setDouble(9, a_80);
                }
                if (a_80_90 == 0) {
                    pstmt.setNull(10, java.sql.Types.DOUBLE);
                } else {
                    pstmt.setDouble(10, a_80_90);
                }
                if (a_80_minimo == 0) {
                    pstmt.setNull(11, java.sql.Types.DOUBLE);
                } else {
                    pstmt.setDouble(11, a_80_minimo);
                }
                    pstmt.setString(12, fecha);
                    pstmt.setString(13, ultimamodificacion);
                    
                    count = pstmt.executeUpdate();
                    st.close();
                    pstmt.close();
                    con.close();
                                 
            } catch (SQLException e) {
                out.print("Error al guardar datos de ensayo en BD " + e);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UploadNuevaPieza.class.getName()).log(Level.SEVERE, null, ex);
            }    
            
            //----Resistencia----------------------------
            try {
                Connection con = connection.conectar();
                st = con.createStatement();
                String sqlr = "insert into resistencia(id_resistencia,id_ensayo,nombre_pieza,ensayo_categoria,rm_max,rm_min,rm_medio,rm_90,rm_unico,sigma_02,lim_elastico,rp_max,rp_min,rp_promedio,rp_unico,lim_fluencia_max,lim_fluencia_min,lim_fluencia_unico,fecha_resistencia,ultima_modif_resistencia)" + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                pstmtr = con.prepareStatement(sqlr);
                //Resistencia-------------------------------------------
                    pstmtr.setInt(1, 0);
                    pstmtr.setInt(2, id_ensayo);
                    pstmtr.setString(3, nombre);
                    pstmtr.setString(4, ensayo_categoria);
                    if (rm_max == 0) {
                    pstmtr.setNull(5, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(5, rm_max);
                }
                if (rm_min == 0) {
                    pstmtr.setNull(6, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(6, rm_min);
                }
                if (rm_medio == 0) {
                    pstmtr.setNull(7, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(7, rm_medio);
                }
                if (rm_90 == 0) {
                    pstmtr.setNull(8, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(8, rm_90);
                }
                if (rm_unico == 0) {
                    pstmtr.setNull(9, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(9, rm_unico);
                }
                if (sigma_02 == 0) {
                    pstmtr.setNull(10, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(10, sigma_02);
                }
                if (lim_elastico == 0) {
                    pstmtr.setNull(11, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(11, lim_elastico);
                }
                if (rp_max == 0) {
                    pstmtr.setNull(12, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(12, rp_max);
                }
                if (rp_min == 0) {
                    pstmtr.setNull(13, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(13, rp_min);
                }
                if (rp_promedio == 0) {
                    pstmtr.setNull(14, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(14, rp_promedio);
                }
                if (rp_unico == 0) {
                    pstmtr.setNull(15, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(15, rp_unico);
                }
                if (lim_fluencia_max == 0) {
                    pstmtr.setNull(16, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(16, lim_fluencia_max);
                }
                if (lim_fluencia_min == 0) {
                    pstmtr.setNull(17, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(17, lim_fluencia_min);
                }
                if (lim_fluencia_unico == 0) {
                    pstmtr.setNull(18, java.sql.Types.INTEGER);
                } else {
                    pstmtr.setInt(18, lim_fluencia_unico);
                }
                    pstmtr.setString(19, fecha);
                    pstmtr.setString(20, ultimamodificacion);
              
                    count2 = pstmtr.executeUpdate();
                    st.close();
                    pstmtr.close();
                    con.close();
                    
            } catch (SQLException e) {
                out.print("Error al guardar datos de ensayo en BD " + e);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UploadNuevaPieza.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            //----Datos n y r--------------------------    
            try {
                Connection con = connection.conectar();
                st = con.createStatement();
                String sqlnr = "insert into datos_n_r(id_datos_n_r,id_ensayo,nombre_pieza,ensayo_categoria,n_0,n_45,n_90,r_0,r_45,r_90,r_m,delta_r,fecha_datos_n_r,ultima_modif_datos_nr)" + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                pstmtnr = con.prepareStatement(sqlnr);
                
                //Datos n y r ------------------------------- 
                    pstmtnr.setInt(1, 0);
                    pstmtnr.setInt(2, id_ensayo);
                    pstmtnr.setString(3, nombre);
                    pstmtnr.setString(4, ensayo_categoria);
                    if (n_0 == 0) {
                    pstmtnr.setNull(5, java.sql.Types.DOUBLE);
                } else {
                    pstmtnr.setDouble(5, n_0);
                }
                if (n_45 == 0) {
                    pstmtnr.setNull(6, java.sql.Types.DOUBLE);
                } else {
                    pstmtnr.setDouble(6, n_45);
                }
                if (n_90 == 0) {
                    pstmtnr.setNull(7, java.sql.Types.DOUBLE);
                } else {
                    pstmtnr.setDouble(7, n_90);
                }
                if (r_0 == 0) {
                    pstmtnr.setNull(8, java.sql.Types.DOUBLE);
                } else {
                    pstmtnr.setDouble(8, r_0);
                }
                if (r_45 == 0) {
                    pstmtnr.setNull(9, java.sql.Types.DOUBLE);
                } else {
                    pstmtnr.setDouble(9, r_45);
                }
                if (r_90 == 0) {
                    pstmtnr.setNull(10, java.sql.Types.DOUBLE);
                } else {
                    pstmtnr.setDouble(10, r_90);
                }
                if (r_m == 0) {
                    pstmtnr.setNull(11, java.sql.Types.DOUBLE);
                } else {
                    pstmtnr.setDouble(11, r_m);
                }
                    pstmtnr.setDouble(12, delta_r);
                    pstmtnr.setString(13, fecha);
                    pstmtnr.setString(14, ultimamodificacion);
                
                    count3 = pstmtnr.executeUpdate();
                    st.close();
                    pstmtnr.close();
                    con.close();
            } catch (SQLException e) {
                out.print("Error al guardar datos de ensayo en BD " + e);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UploadNuevaPieza.class.getName()).log(Level.SEVERE, null, ex);
            }
            //----Archivos Sim y Mat -----------------------
            try {
                Connection con = connection.conectar();
                st = con.createStatement();
                String sqlsim = "insert into archivos_sim(id_archivos_sim,id_ensayo,nombre_pieza,ensayo_categoria,url_archivo_sim,nombre_archivo_sim,nombre_archivo_mat,url_archivo_mat,imagen_mat,descripcion_sim,semaforo,fecha,ultima_modif_sim)" + "values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
                pstmtsim = con.prepareStatement(sqlsim);
                //Archivos Sim y mat -------------------------
                    pstmtsim.setInt(1, 0);
                    pstmtsim.setInt(2, id_ensayo);
                    pstmtsim.setString(3, nombre);
                    pstmtsim.setString(4, ensayo_categoria);
                    pstmtsim.setString(5, url_archivo_sim);
                    pstmtsim.setString(6, nombre_archivo_sim);
                    pstmtsim.setString(7, nombre_archivo_mat);
                    pstmtsim.setString(8, url_archivo_mat);
                    
                    if(inputStream!= null){
                            pstmtsim.setBinaryStream(9, inputStream, (int) filePart.getSize());
                    } else {
                            pstmtsim.setNull(9, java.sql.Types.BLOB);
                    }
                    pstmtsim.setString(10, descripcion_sim);
                    pstmtsim.setString(11, id_semaforo);
                    pstmtsim.setString(12, fecha);
                    pstmtsim.setString(13, ultimamodificacion);
                    
                    count4 = pstmtsim.executeUpdate();
                    st.close();
                    pstmtsim.close();
                    con.close();
            } catch (SQLException e) {
                out.print("Error al guardar datos de ensayo en BD " + e);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UploadNuevaPieza.class.getName()).log(Level.SEVERE, null, ex);
            }
               //--Estatus ensayo------------------------------
            try {
                Connection con = connection.conectar();
                st = con.createStatement();
                String sqlest = "update ensayos set estatus=? where id_ensayo = '" + id_ensayo + "'";
                pst2 = con.prepareStatement(sqlest);
                // Estatus ensayo-------------------    
                    pst2.setString(1, "Datos Registrados");
                    count5 = pst2.executeUpdate(); 
                    st.close();
                    pst2.close();
                    con.close();
            } catch (SQLException e) {
                out.print("Error al guardar datos de ensayo en BD " + e);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UploadNuevaPieza.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            if (count>=0 || count2>=0 || count3>=0 || count4>=0 || count5>=0){ //&&
                    out.println(  "<!DOCTYPE html>"
                                + "<html lang=\"en\">"
                                + "<head>"
                                + "<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"images/FondoSplash_2.ico\"/>"
                                + "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
                                + "<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU\" crossorigin=\"anonymous\">"
                                + "<link href=\"https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\" rel=\"stylesheet\" integrity=\"sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN\" crossorigin=\"anonymous\">"
                                + "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css\">"
                                + "<link rel=\"stylesheet\" href=\"css/estilo.css\"/>"
                                //+ "<meta http-equiv='refresh' content='5;URL=ensayos.jsp'>"//redirects after 5 seconds
                                + "<title>Carga de Datos de Ensayo exitosa</title>"    
                                + "</head>"
                                + "<body>"
                                + "<div class=\"container mt-5\">"
                                + "<div class=\"alert alert-success\" role=\"alert\"> Datos ingresados con éxito a la BD! <br>"
                                + " El ensayo categoria: " + ensayo_categoria + "<br>De la pieza: " + nombre + "<br>Fecha: " + fecha + "<br> Fue ingresado con éxito a la BD!" + "<br>Por el Usuario: " + ultimamodificacion + "</div> "
                                + "<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                + "</did>"
                                + "</body>"
                                + "</html>");
            } else {
                    out.println(  "<!DOCTYPE html>"
                                + "<html lang=\"en\">"
                                + "<head>"
                                + "<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"images/FondoSplash_2.ico\"/>"
                                + "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
                                + "<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU\" crossorigin=\"anonymous\">"
                                + "<link href=\"https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\" rel=\"stylesheet\" integrity=\"sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN\" crossorigin=\"anonymous\">"
                                + "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css\">"
                                + "<link rel=\"stylesheet\" href=\"css/estilo.css\"/>"
                                + "<meta http-equiv='refresh' content='6;URL=ensayos.jsp'>"//redirects after 6 seconds
                                + "<title>Carga de Datos Ensayo</title>"
                                + "</head>"
                                + "<body>"
                                + "<div class=\"container mt-5\">"
                                + "<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo registrar los datos en la BD. <br>"
                                + "Esto puede ser debido a que los datos de ensayo ya fueron registrados con anterioridad o se ingreso algún dato erroneo. <br>"
                                + "Verifique la información ingresada e intentelo nuevamente por favor.</div>"
                                + "<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                + "</did>"
                                + "</body>"
                                + "</html>");
                }
            }
    
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
            }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
