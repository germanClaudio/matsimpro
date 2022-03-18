<%-- 
    Document   : download
    Created on : 23/09/2021, 08:28:32
    Author     : Germán Montalbetti © <gmontalbetti@prodismo.com>
--%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page language="java"%>
<%@ page session="true"%>
<%@ page import="com.mysql.cj.jdbc.Driver"%>
<%@ page import="utiles.connection"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/estiloIndex.css"/>
        <title>DownLoad File</title>
    </head>
    <%
        HttpSession sesion = request.getSession();
            if( sesion.getAttribute("login")==null || sesion.getAttribute("login").equals("0")){
                response.sendRedirect("login.jsp");
            }
           
        try{
            int id_ensayo2 = Integer.parseInt(request.getParameter("id_ensayo"));
            Connection con = connection.conectar();
            
            String sql2 = "select id_ensayo from `ensayos` where id_ensayo = " + id_ensayo2 + " and ensayo_categoria ='Material Norma'";
            PreparedStatement pre12 = con.prepareStatement(sql2);
            ResultSet rs2 = pre12.executeQuery();

                    if(rs2.next()){
                        try{
                            int id_ensayo = Integer.parseInt(request.getParameter("id_ensayo"));
                            String categoria = request.getParameter("ensayo_categoria");
                            String nombre = request.getParameter("nombre_pieza");

                            FileOutputStream output = null;
                            InputStream input = null;

                            String sql = "select nombre_pieza,ensayo_categoria,norma_material from `ensayos` where id_ensayo ='" + id_ensayo + "'";
                            PreparedStatement pre1 = con.prepareStatement(sql);

                            ResultSet rs1 = pre1.executeQuery();
                            output = new FileOutputStream(new File("D:/Datos/Desktop/Norma_pieza_"+ nombre + "(" + categoria + ")" + ".pdf")); //D:/Datos/Downloads/Descargas/

                            while(rs1.next()){

                               input = rs1.getBinaryStream("norma_material");
                               int r = 0;

                                while ((r = input.read()) != -1) {
                                    output.write(r); 
                                }
                                    out.println(  "<div class=\"container mt-5\">"
                                                + " <div class=\"alert alert-success\" role=\"alert\"> El Archivo Norma_pieza: "+ nombre +".pdf se guardó correctamente en la dirección D:/Datos/Desktop (En el escritorio, para ser exactos.) </div>"
                                                + "<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                                + "</div>");
                            }
                            input.close();
                            output.flush();
                            output.close();
                            rs1.close();
                            con.close();

                            } catch(SQLException e){
                              out.println(e.getMessage());              
                            }
                    }else{
                        out.println(  "<div class=\"container mt-5\">"
                                    + "<div class=\"alert alert-danger\" role=\"alert\"> No se pudo descargar el archivo desde la BD o el archivo NO existe! <br>"
                                    + " Recuerde que solo puede descargar archivos de Categoria Ensayos: \"Material Norma\" </div> "
                                    + "<a href=\"ensayos.jsp\" class=\"btn btn-secondary\" id=\"form1\">Volver <i class=\"fa fa-arrow-circle-left\" aria-hidden=\"true\"></i></a>"
                                    + "</div>");
                    }
            rs2.close();
            con.close();        
            
        }catch(SQLException e){
            out.println(e.getMessage());
        }
    %>
</html>
