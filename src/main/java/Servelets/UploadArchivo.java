package Servelets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.sql.*;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import utiles.connection;

/*@author Germán Montalbetti © <gmontalbetti@prodismo.com> */
@WebServlet(name = "UploadArchivo", urlPatterns = {"/UploadArchivo"})
@MultipartConfig(maxFileSize = 16177215)

public class UploadArchivo extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
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
            int id_pieza2 = Integer.parseInt(request.getParameter("id_pieza"));
            String ensayo_categoriacons = request.getParameter("ensayo_categoria");

            Connection con = connection.conectar();
            String sql2 = "select id_ensayo from `ensayos` where id_pieza = " + id_pieza2 + " and ensayo_categoria ='" + ensayo_categoriacons + "'";

            PreparedStatement pre12 = con.prepareStatement(sql2);

            ResultSet rs2 = pre12.executeQuery();

            if (rs2.next() == false) {
                InputStream inputStream = null;

                Random rand = new Random();
                int n = rand.nextInt(9999) + 1;
                String idTemp = (String.valueOf(n));

                String title = "Norma_material";
                Part filePart = request.getPart("norma_material");

                if (filePart != null) {
                    System.out.println(filePart.getName());
                    System.out.println(filePart.getSize());
                    System.out.println(filePart.getContentType());

                    inputStream = filePart.getInputStream();
                }

                int id_pieza = Integer.parseInt(request.getParameter("id_pieza"));
                String nombre_pieza = request.getParameter("nombre_pieza");
                String ensayo_categoria = request.getParameter("ensayo_categoria");
                String descripcion = request.getParameter("ensayo_descripcion");
                String estatus = request.getParameter("estatus");
                String fecha = request.getParameter("fecha_ensayo");
                String ultimamodificacion = request.getParameter("ultima_modificacion");

                try {
                    String sql = "insert into ensayos(id_ensayo,id_pieza,nombre_pieza,ensayo_categoria,ensayo_descripcion,estatus,norma_material,fecha_ensayo,ultima_modificacion)" + "values(?,?,?,?,?,?,?,?,?)";
                    PreparedStatement pstmt = con.prepareStatement(sql);

                    pstmt.setInt(1, 0);
                    pstmt.setInt(2, id_pieza);
                    pstmt.setString(3, nombre_pieza);
                    pstmt.setString(4, ensayo_categoria);
                    pstmt.setString(5, descripcion);
                    pstmt.setString(6, estatus);
                    if (inputStream != null) {
                        pstmt.setBinaryStream(7, inputStream, (int) filePart.getSize());
                    } else {
                        pstmt.setNull(7, java.sql.Types.BLOB);
                    }
                    pstmt.setString(8, fecha);
                    pstmt.setString(9, ultimamodificacion);

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
                                    //+ "<meta http-equiv='refresh' content='5;URL=ensayos.jsp'>");//redirects after 5 seconds
                                    + "<title>Carga de Ensayo</title>"
                                    + "</head>"
                                    + "<body>"
                                    + "<div class=\"container mt-5\">"
                                    + "<div class=\"alert alert-success\" role=\"alert\"> Datos ingresados con éxito a la BD! <br>"
                                    + " El ensayo: " + ensayo_categoria + " fue ingresado con éxito para la pieza: " + nombre_pieza + " </div>"
                                    + "<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                    + "</did>"
                                    + "</body>"
                                    + "</html>");

                    } else {
                        out.println(" <div class=\"alert alert-danger\" role=\"alert\"> No se pudo ingresar Datos a la BD!  </div>");
                    }
                    con.close();
                    //request.getRequestDispatcher("ensayos.jsp").forward(request, response);                            
                } catch (SQLException e) {
                    out.print("Error al guardar Ensayo en BD " + e);
                }
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
                            //+ "<meta http-equiv='refresh' content='5;URL=ensayos.jsp'>"//redirects after 5 seconds
                            + "<title>Carga de Ensayo</title>"
                            + "</head>"
                            + "<body>");
                String ensayo_categoria = request.getParameter("ensayo_categoria");
                String nombre_pieza = request.getParameter("nombre_pieza");
                out.println(  "<div class=\"container mt-5\">"
                            + "<div class=\"alert alert-danger\" role=\"alert\"> No se pudo registrar los datos en la BD. <br>"
                            + "Esto es debido a que el ensayo: " + ensayo_categoria + " ya existe, para la pieza: " + nombre_pieza
                            + ". Verifique los datos ingresados e intentelo nuevamente por favor.<br></div>"
                            + "<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                            + "</did>"
                            + "</body>"
                            + "</html>");
            }
            rs2.close();
            con.close();
        } catch (SQLException e) {
            out.println(e.getMessage());

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UploadArchivo.class.getName()).log(Level.SEVERE, null, ex);
            out.println(ex.getMessage());
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
