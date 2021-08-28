/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO.read;

import com.concredito.model.UsuariosModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ISC_G
 */
public class GetSession {
     public static UsuariosModel getSession(Connection connection, String correo, String password){
       UsuariosModel inicioSesionModel = new UsuariosModel();
       try {
            String sql =    " SELECT id, nombre, correo, password FROM dbconcredito.usuarios\n " +
                            " WHERE correo = ? AND password = ? ";
            PreparedStatement preparedStatement = connection.prepareStatement(sql); //Evitar inyeccion SQL
            preparedStatement.setString(1, correo);
            preparedStatement.setString(2, password);
            ResultSet result = preparedStatement.executeQuery();
            
            if (result.next()) {
                
                inicioSesionModel = new UsuariosModel();    
                inicioSesionModel.setId(result.getString("id"));
                inicioSesionModel.setCorreo(result.getString("correo"));
                inicioSesionModel.setNombre(result.getString("nombre"));
                inicioSesionModel.setPassword(result.getString("password"));
              

            } else {
                return null;
            }
            return inicioSesionModel;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
}
