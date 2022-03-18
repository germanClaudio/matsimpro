package Servelets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.sql.SQLException;
import utiles.connection;

/** @author Germán Montalbetti © <gmontalbetti@prodismo.com> */

@WebServlet(name = "EnsayosRegistrados", urlPatterns = {"/EnsayosRegistrados"})
@MultipartConfig
public class EnsayosRegistradosBuscar extends HttpServlet {
    Statement st = null;
    ResultSet rs = null;

    Blob norma_material = null;
    byte[] norma = null;
    ServletOutputStream sos = null;
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
            try {
                String nombuscar = request.getParameter("txtbuscar");
                Connection con = connection.conectar();
                st = con.createStatement();
                String sql = "select * from ensayos where nombre_pieza LIKE" + "'%"+nombuscar+"%' or ensayo_categoria LIKE '%"+nombuscar+"%' or estatus LIKE '%"+nombuscar+"%'";
                rs = st.executeQuery(sql);
                
                while (rs.next()) {
                    out.print("<tr>"
                            + "<td scope=\"row\" class=\"text-center\"> <span class=\"badge rounded-pill bg-secondary\">" + rs.getInt("id_ensayo") + "</span></td>"
                            + "<td scope=\"row\" class=\"text-center\"> <span class=\"badge rounded-pill bg-primary\">" + rs.getInt("id_pieza") + "</span></td>"
                            + "<td scope=\"row\" class=\"text-center\"> <img src=\"./retrieve.jsp?id_pieza=" + rs.getInt("id_pieza") + "\"width=100px height=80px/>" + "</td>"
                            + "<td>" + rs.getString("nombre_pieza") + "</td>"
                            + "<td>" + rs.getString("ensayo_categoria") + "</td>"
                            + "<td>" + rs.getNString("ensayo_descripcion") + "</td>"
                            + "<td>" + rs.getString("estatus") + "</td>"
                            + "<td>" + rs.getDate("fecha_ensayo") + "</td>"
                            + "<td>" + rs.getString("ultima_modificacion") + "</td>"
                            + "<td class=\"text-right py-0 align-middle\">"
                            + "<div class=\"btn-group btn-group-sm\">"        
                            + "<a title=\"Descargar Norma\" href=\"download.jsp?id_ensayo=" + rs.getInt(1) + "&nombre_pieza=" + rs.getString(3) + "&ensayo_categoria=" + rs.getString(4) + "\" class=\"btn btn-info btn-sm\" style=\"margin: 2px;\"> <i class=\"fa fa-cloud-download\" aria-hidden=\"true\"></i></a>"        
                            + "<a title=\"Agregar Datos de Ensayo\" href=\"cargarDatosEnsayo.jsp?id_ensayo=" + rs.getInt(1) + "&nombre_pieza=" + rs.getString(3) + "&ensayo_categoria=" + rs.getString(4) + "&estatus=" + rs.getString(6) + "\" class=\"btn btn-success btn-sm\" style=\"margin: 2px;\"> <i class=\"bi bi-pencil-square\" aria-hidden=\"true\"></i></a>"
                            + "<a title=\"Ver Datos de Ensayo\" href=\"datosensayos.jsp?id_ensayo=" + rs.getInt(1) + "&nombre_pieza=" + rs.getString(3) + "&ensayo_categoria=" + rs.getString(4) + "&estatus=" + rs.getString(6) + "\" class=\"btn btn-dark btn-sm\" style=\"margin: 2px;\"> <i class=\"bi bi-eye\" aria-hidden=\"true\"></i></a>"
                            + "<a title=\"Borrar Ensayo\" href=\"borrarDatosEnsayoConfirm.jsp?id_ensayo=" + rs.getInt(1) + "&nombre_pieza=" + rs.getString(3) + "&ensayo_categoria=" + rs.getString(4) + "&estatus=" + rs.getString(6) + "\" class=\"btn btn-danger btn-sm\" style=\"margin: 2px;\"> <i class=\"bi bi-eraser\" aria-hidden=\"true\"></i></a>"
                            + "</div>"
                            + "</td>"
                            + "</tr>");
                }
            } catch (SQLException e) {
                out.print("Error al cargar BD " + e);
            } catch (ClassNotFoundException ex) {
                out.print("Error al cargar BD, no se encuentra clase mysql " + ex);
                //Logger.getLogger(Usuarios.class.getName()).log(Level.SEVERE, null, ex);
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
        processRequest(request, response);
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
