package Servelets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import utiles.connection;
import java.sql.SQLException;

/* @author Germán Montalbetti © <gmontalbetti@prodismo.com> */
@WebServlet(name = "Usuarios", urlPatterns = {"/Usuarios"})
public class Usuarios extends HttpServlet {

    Statement st = null;
    ResultSet rs = null;

    String senalTipo = "";
    String senalStatus = "";

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
            try {
                Connection con = connection.conectar();
                st = con.createStatement();
                rs = st.executeQuery("SELECT * FROM `usuarios`;");

                while (rs.next()) {
                    out.print("<tr>"
                            + "<td scope=\"row\" class=\"text-center\"> <span class=\"badge rounded-pill bg-info text-dark\">" + rs.getInt("id_usuario") + "</span></td>"
                            + "<td>" + rs.getString("nombre_usuario") + "</td>"
                            + "<td>" + rs.getString("email") + "</td>"
                            + "<td>" + rs.getString("username") + "</td>");
                    if (rs.getString(6).equals("Administrador")){
                        senalTipo = "primary";
                    } else if (rs.getString(6).equals("Procesista")) {
                        senalTipo = "secondary";
                    } else if (rs.getString(6).equals("Proveedor")) {
                        senalTipo = "warning";
                    } else if (rs.getString(6).equals("Usuario")) {
                        senalTipo = "dark";
                    }      
                    out.print("<td> <span class=\"badge rounded-pill bg-" + senalTipo + "\">" + rs.getString("tipo_nivel") + "</span></td>");
                    if (rs.getString(7).equals("Activo")) {
                        senalStatus = "success";
                    } else if (rs.getString(7).equals("Inactivo")) {
                        senalStatus = "danger";
                    }
                    out.print("<td scope=\"row\" class=\"text-center\"> <span class=\"badge bg-" + senalStatus + "\">" + rs.getString("estatus") + "</span></td>"
                            + "<td>" + rs.getString("registrado_por") + "</td>"
                            + "<td class=\"text-right py-0 align-middle\">"
                            + "<div class=\"btn-group btn-group-sm\">"
                            + "<a class=\"btn btn-info\" title=\"Editar Datos Usuario\" href=\"editar.jsp?id=" + rs.getInt(1) + "&nombre=" + rs.getString(2) + "&email=" + rs.getString(3) + "&username=" + rs.getString(4) + "&estatus=" + rs.getString(7) + "\" class=\"btn btn-primary btn-sm\"> <i class=\"fa fa-pencil\" aria-hidden=\"true\" ></i> </a>"
                            + "<a class=\"btn btn-danger\" title=\"Borrar\" href=\"borrar.jsp?id=" + rs.getInt(1) + "&nombre=" + rs.getString(2) + "&email=" + rs.getString(3) + "&username=" + rs.getString(4) + "\" class=\"btn btn-danger btn-sm\"><i class=\"fa fa-trash\" aria-hidden=\"true\"></i> </a>"
                            + "</td>"
                            + "</tr>");
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
        try (PrintWriter out = response.getWriter()) {
            
            try {
                Connection con = connection.conectar();
                st = con.createStatement();
                rs = st.executeQuery("SELECT * FROM usuarios;");

                while (rs.next()) {
                    out.print("<tr>"
                            + "<th scope=\"row\" class=\"text-center\">" + rs.getInt("id_usuario") + "</th>"
                            + "<td>" + rs.getString("nombre_usuario") + "</td>"
                            + "<td>" + rs.getString("email") + "</td>"
                            + "<td>" + rs.getString("username") + "</td>");
                    if (rs.getString(6).equals("Administrador")){
                        senalTipo = "primary";
                    } else if (rs.getString(6).equals("Procesista")) {
                        senalTipo = "secondary";
                    } else if (rs.getString(6).equals("Proveedor")) {
                        senalTipo = "warning";
                    }    
                    out.print("<td> <span class=\"badge rounded-pill bg-" + senalTipo + "\">" + rs.getString("tipo_nivel") + "</span></td>");
                    if (rs.getString(7).equals("Activo")) {
                        senalStatus = "success";
                    } else if (rs.getString(7).equals("Inactivo")) {
                        senalStatus = "danger";
                    }
                    out.print("<td> <span class=\"badge bg-" + senalStatus + "\">" + rs.getString("estatus") + "</span></td>"
                            + "<td>" + rs.getString("registrado_por") + "</td>"
                            + "<td class=\"text-right py-0 align-middle\">"
                                    + "<div class=\"btn-group btn-group-sm\">"
                            + " <a class=\"btn btn-info\" title=\"Editar Datos Usuario\" href=\"editar.jsp?id=" + rs.getInt(1) + "&nombre=" + rs.getString(2) + "&email=" + rs.getString(3) + "&username=" + rs.getString(4) + "&estatus=" + rs.getString(7) + "\" class=\"btn btn-primary btn-sm\"> <i class=\"fa fa-pencil\" aria-hidden=\"true\" ></i> </a>"
                            + " <a class=\"btn btn-danger\" title=\"Borrar\" href=\"borrar.jsp?id=" + rs.getInt(1) + "&nombre=" + rs.getString(2) + "&email=" + rs.getString(3) + "&username=" + rs.getString(4) + "\" class=\"btn btn-danger btn-sm\"><i class=\"fa fa-trash\" aria-hidden=\"true\"></i> </a>"
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
