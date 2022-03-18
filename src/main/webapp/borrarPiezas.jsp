<%-- 
    Document   : borrarPiezas
    Created on : 20/09/2021, 14:13:04
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
            
            try{
                Connection con = connection.conectar();
                Statement st = con.createStatement();
                String sql = "select * FROM piezas where id_pieza='"+ id_pieza + "'";
                ResultSet rs = st.executeQuery(sql);
            
                while (rs.next()){
                    out.print(" <div class=\"container mt-5\">"
                            + " <div class=\"alert alert-danger\" role=\"alert\"> Esta seguro de querer <b>eliminar</b> la pieza Id#: <b>" + rs.getInt(1) + "</b> - Nombre: <b>" + rs.getString("nombre_pieza") + "</b> ...?"
                            + " <br>Esto hará que borre los ensayos asosiados a esta pieza y todos los datos ingresados asociados a los ensayos correspondientes!!!<br>"
                            + " Esta acción <b>no se puede deshacer!!</b><br><br></div>"
                            + " <div class=\"d-grid gap-2 col-6 mx-auto\">"
                            + " <a href=\"piezas.jsp?id_pieza=" + rs.getInt(1) + "&nombre_pieza=" + rs.getString("nombre_pieza") + "&material_pieza=" + rs.getString(3) + "&espesor_pieza=" + rs.getBigDecimal(4) + "&numero_pieza=" + rs.getString(5) + "&descripcion_pieza=" + rs.getNString(7) + "\" class=\"btn btn-warning\"> <i class=\"bi bi-gear-wide-connected\" aria-hidden=\"true\" ></i> No, Cancelar  </a>"
                            + " <a href=\"borrarPiezasEnsayos.jsp?id_pieza=" + rs.getInt(1) + "&nombre_pieza=" + rs.getString("nombre_pieza") + "\" class=\"btn btn-danger\"> <i class=\"fa fa-trash\" aria-hidden=\"true\" ></i> Si, Eliminar </a>"
                            + " </div>"
                            + " </div>");
                }
            }
            catch(SQLException e){
                out.print("Error al tratar de eliminar registro de BD " + e);
            }
        %>
    </body>
</html>
