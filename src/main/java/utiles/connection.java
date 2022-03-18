package utiles;

import java.awt.HeadlessException;
import java.sql.*;
//import com.mysql.cj.jdbc.Driver;

/* @author Germán Montalbetti © <gmontalbetti@prodismo.com> */

public class connection {
    public static Connection conectar() throws ClassNotFoundException{
        
        try {
              String url = "jdbc:mysql://www.prodismo.com:3306/cadcam1_materiales";
              String usuario = "cadcam1_german"; 
              String pass = "12345";
              
              Class.forName("com.mysql.cj.jdbc.Driver");
              Connection con = DriverManager.getConnection(url, usuario, pass);
                   return con;
                   
        } catch (HeadlessException | SQLException e) {
            
            System.out.println("Error de conexion a DB: " + e);
            
        }
        return (null);
    }
}

