<%-- 
    Document   : borrarPiezasEnsayos
    Created on : 06/10/2021, 11:27:23
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utiles.connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/estiloIndex.css"/>
        <title>Eliminar Piezas - Ensayos</title>
    </head>
    <body>
        <%  
            int id_pieza = Integer.parseInt(request.getParameter("id_pieza"));
            String nombre_pieza = request.getParameter("nombre_pieza");
            
            try{
                Connection con = connection.conectar();
                Statement st = con.createStatement();
                String sql = "select * FROM piezas where id_pieza='"+ id_pieza + "'";
                ResultSet rs = st.executeQuery(sql);
                
                if(rs.next()){
                    st.executeUpdate("delete FROM alargamiento where nombre_pieza='"+ nombre_pieza + "'");
                    st.executeUpdate("delete FROM resistencia where nombre_pieza='"+ nombre_pieza + "'");
                    st.executeUpdate("delete FROM datos_n_r where nombre_pieza='"+ nombre_pieza + "'");
                    st.executeUpdate("delete FROM archivos_sim where nombre_pieza='"+ nombre_pieza + "'");
                    st.executeUpdate("delete FROM ensayos where id_pieza='"+ id_pieza + "'");
                    st.executeUpdate("delete FROM piezas where id_pieza='"+ id_pieza + "'");
                
                            out.print("<div class=\"container mt-5\"> "
                                    + " <div class=\"alert alert-danger\" role=\"alert\"> <b> Se ha eliminado la pieza: " + nombre_pieza + " <br> </b>"
                                    + " y todos los ensayos y datos asociados a esta pieza!!!<br><br></div>"
                                    + " <div class=\"d-grid gap-2 col-6 mx-auto\">"
                                    + " <a href=\"piezas.jsp\" class=\"btn btn-success\"> <i class=\"bi bi-gear-wide-connected\" aria-hidden=\"true\" ></i> Aceptar </a>"
                                    + " </div>"
                                    + " </div>");
//                request.getRequestDispatcher("piezas.jsp").forward(request, response);          
                } else {
                    out.println("<div class=\"container mt-5\">"
                              + "<div class=\"alert alert-danger\" role=\"alert\"> Upsssss... No se pudo eliminar todos los datos de la BD. <br>"
                              + " Esto puede ser debido a que la pieza ya fue eliminada con anterioridad o se ingreso algún dato erroneo. <br>"
                              + " Verifique la información ingresada e intentelo nuevamente por favor. </div> "
                              + "<a href=\"piezas.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                              + "</did>");
                }
                con.close();
            }
            catch(SQLException e){
                out.print("Error al tratar de eliminar registro de BD " + e);
            }
        %>
    </body>
</html>

