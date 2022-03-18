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
import utiles.connection;
import java.sql.*;
import java.sql.SQLException;

/* @author Germán Montalbetti © <gmontalbetti@prodismo.com> */
@WebServlet(name = "PiezasRegistradasBuscar", urlPatterns = {"/PiezasRegistradasBuscar"})
@MultipartConfig
public class PiezasRegistradasBuscar extends HttpServlet {

    Statement st = null;
    ResultSet rs = null;

    Blob image = null;
    byte[] img = null;
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
                String sql = "select * from piezas where nombre_pieza LIKE" + "'%" + nombuscar + "%' or id_pieza LIKE '%" + nombuscar + "%' or numero_pieza LIKE '%" + nombuscar + "%' or material_pieza LIKE '%" + nombuscar + "%'";
                rs = st.executeQuery(sql);

                while (rs.next()) {
                    out.print("<tr>"
                            + "<td> <span class=\"badge rounded-pill bg-secondary\">" + rs.getInt("id_pieza") + "</span></td>"
                            + "<td>" + rs.getString("nombre_pieza") + "</td>"
                            + "<td>" + rs.getString("material_pieza") + "</td>"
                            + "<td scope=\"row\" class=\"text-center\"> <span class=\"badge rounded-pill bg-dark\">" + rs.getBigDecimal("espesor_pieza") + "</td>"
                            + "<td>" + rs.getString("numero_pieza") + "</td>"
                            + "<td> <img src=\"./retrieve.jsp?id_pieza=" + rs.getInt("id_pieza") + "\"width=110px height=90px/>" + "</td>"
                            /*+ "<td> <img src=\"retrieve.jsp?id_pieza=" + rs.getInt("id_pieza") + "\">" + "</td>"*/
                            + "<td>" + rs.getString("descripcion_pieza") + "</td>"
                            + "<td>" + rs.getString("ultima_modificacion") + "</td>"
                            + "<td class=\"text-right py-0 align-middle\">"
                            + "<div class=\"btn-group btn-group-sm\">"
                            + "<a title=\"Editar\" href=\"editarPiezas.jsp?id_pieza=" + rs.getInt(1) + "&nombre_pieza=" + rs.getString("nombre_pieza") + "&material_pieza=" + rs.getString(3) + "&espesor_pieza=" + rs.getBigDecimal(4) + "&numero_pieza=" + rs.getString(5) + "&descripcion_pieza=" + rs.getNString(7) + "\" class=\"btn btn-primary btn-sm\"> <i class=\"fa fa-pencil\" aria-hidden=\"true\" ></i> </a>"
                            + "<a title=\"Agregar Ensayo\" href=\"crearnuevoensayo.jsp?id_pieza=" + rs.getInt(1) + "&nombre_pieza=" + rs.getString("nombre_pieza") + "\" class=\"btn btn-success btn-sm\"> <i class=\"bi bi-clipboard-plus\"></i> </a>"
                            + "<a title=\"Borrar\" href=\"borrarPiezas.jsp?id_pieza=" + rs.getInt(1) + "\" class=\"btn btn-danger btn-sm\"> <i class=\"fa fa-trash\" aria-hidden=\"true\"></i> </a>"
                            + "</div>"
                            + "</td>"
                            + "</tr>"
                    );
                }
                rs.close();
                con.close();
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
