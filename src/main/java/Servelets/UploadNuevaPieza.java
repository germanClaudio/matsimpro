package Servelets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import java.sql.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import utiles.connection;

/*@author Germán Montalbetti © <gmontalbetti@prodismo.com> */
@WebServlet(name = "UploadNuevaPieza", urlPatterns = {"/UploadNuevaPieza"})
@MultipartConfig(maxFileSize = 16177215)

public class UploadNuevaPieza extends HttpServlet {

    Statement st = null;
    ResultSet rs = null;

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
        
        try (PrintWriter out = response.getWriter()) {
            
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
        PrintWriter out = response.getWriter();

        try {
            Connection con = connection.conectar();
            InputStream inputStream = null;
            //String title = "Imagen_pieza";
            Part filePart = request.getPart("imagen_pieza");

            if (filePart != null) {
                System.out.println(filePart.getName());
                System.out.println(filePart.getSize());
                System.out.println(filePart.getContentType());
                inputStream = filePart.getInputStream();
            }

            String nombre = request.getParameter("nombre_pieza");
            String material = request.getParameter("material_pieza");
            double espesor = Double.parseDouble(request.getParameter("espesor_pieza"));
            String numero = request.getParameter("numero_pieza");
            String descripcion = request.getParameter("descripcion_pieza");
            String ultimaModificacion = request.getParameter("ultima_modificacion");

            String sql = "insert into piezas(id_pieza,nombre_pieza,material_pieza,espesor_pieza,numero_pieza,imagen_pieza,descripcion_pieza,ultima_modificacion)" + "values(?,?,?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, 0);
            pstmt.setString(2, nombre);
            pstmt.setString(3, material);
            pstmt.setDouble(4, espesor);
            pstmt.setString(5, numero);
                if (inputStream != null) {
                    pstmt.setBinaryStream(6, inputStream, (int) filePart.getSize());
                } else {
                    pstmt.setNull(6, java.sql.Types.BLOB);
                }
            pstmt.setString(7, descripcion);
            pstmt.setString(8, ultimaModificacion);

            int count = pstmt.executeUpdate();
                if (count >= 0) {
                    out.println(  "<!DOCTYPE html>"
                                + "<html>"
                                + "<head>"
                                + "<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"images/FondoSplash_2.ico\"/>"
                                + "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
                                + "<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU\" crossorigin=\"anonymous\">"
                                + "<link href=\"https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\" rel=\"stylesheet\" integrity=\"sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN\" crossorigin=\"anonymous\">"
                                + "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css\">"
                                + "<link rel=\"stylesheet\" href=\"css/estiloNuevaPieza.css\"/>"
                                //out.println("<meta http-equiv='refresh' content='5;URL=ensayos.jsp'>");//redirects after 5 seconds
                                + "<title>Carga de Pieza exitosa</title>"
                                + "</head>"
                                + "<body>"
                                + "<div class=\"container mt-5\">"
                                + "<div class=\"alert alert-success\" role=\"alert\"> Datos ingresados con éxito a la BD! <br>"
                                + " La pieza: " + nombre + "<br>N°: " + numero + "<br>Espesor: " + espesor + " mm.<br>Material: " + material + "<br> fue ingresada con éxito a la BD!</div> "
                                + "<a href=\"piezas.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                + "</did>"
                                + "</body>"
                                + "</html>");

                } else {
                    out.println(  "<!DOCTYPE html>"
                                + "<html>"
                                + "<head>"
                                + "<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"images/FondoSplash_2.ico\"/>"
                                + "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
                                + "<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU\" crossorigin=\"anonymous\">"
                                + "<link href=\"https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\" rel=\"stylesheet\" integrity=\"sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN\" crossorigin=\"anonymous\">"
                                + "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css\">"
                                + "<link rel=\"stylesheet\" href=\"css/estilo.css\"/>"
                                + "<meta http-equiv='refresh' content='5;URL=ensayos.jsp'>"  //redirects after 5 seconds
                                + "<title>Error Carga de Pieza</title>"
                                + "</head>"
                                + "<body>"
                                + "<div class=\"container mt-5\">"
                                + "<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo registrar los datos en la BD. <br>"
                                + " Esto puede ser debido a que la pieza ya existe o se ingreso algún dato erroneo. <br>"
                                + " Verifique la información ingresada e intentelo nuevamente por favor. </div>"
                                + "<a href=\"piezas.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                + "</did>"
                                + "</body>"
                                + "</html>");
                }
                pstmt.close();
                con.close();
                //request.getRequestDispatcher("piezas.jsp").forward(request, response);                            
        } catch (SQLException e) {
            out.print("Error al guardar pieza en BD " + e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UploadNuevaPieza.class.getName()).log(Level.SEVERE, null, ex);
        }
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
