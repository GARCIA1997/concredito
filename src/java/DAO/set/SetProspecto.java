/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO.set;

import com.concredito.model.ProspectoModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author ISC_G
 */
public class SetProspecto {
    public static int setProspecto(Connection connection, ProspectoModel prospecto){
        int result = 505;
        try{
            String sql ="INSERT INTO `dbconcredito`.`prospectos`\n" +
                        "   (\n" +
                        "   `nombre`,\n" +
                        "   `apellido_paterno`,\n" +
                        "   `calle`,\n" +
                        "   `numero`,\n" +
                        "   `colonia`,\n" +
                        "   `codigo_postal`,\n" +
                        "   `telefono`,\n" +
                        "   `rfc`,\n" +
                        "   `estatus`,\n" +
                        "   `documetos`,\n" +
                        "   `apellido_materno`)\n" +
                        "   VALUES\n" +
                        "   (?,\n" +
                        "       ?,\n" +
                        "       ?,\n" +
                        "       ?,\n" +
                        "       ?,\n" +
                        "       ?,\n" +
                        "       ?,\n" +
                        "       ?,\n" +
                        "       ?\n";
                if(prospecto.getDocumentos().isEmpty()){
                    sql     += ", NULL ";
                }else{
                    sql     += ", ?"; 
                }
                if(prospecto.getApellido_materno().isEmpty()){
                    sql     += ", NULL); ";
                }else{
                    sql     += ", ?);"; 
                }
                int CI = 9;
            PreparedStatement preparedStatement = connection.prepareStatement(sql); //Evitar inyeccion SQL
            preparedStatement.setString(1, prospecto.getNombre() );
            preparedStatement.setString(2, prospecto.getApellido_paterno());
            preparedStatement.setString(3, prospecto.getCalle() );
            preparedStatement.setString(4, prospecto.getNumero());
            preparedStatement.setString(5, prospecto.getColonia());
            preparedStatement.setString(6, prospecto.getCodigo_postal());
            preparedStatement.setString(7, prospecto.getTelefono());
            preparedStatement.setString(8, prospecto.getRfc());    
            preparedStatement.setString(9, prospecto.getStatus());       
            if(!prospecto.getDocumentos().isEmpty()){
                CI++;
                preparedStatement.setString(CI, prospecto.getDocumentos());
            }
            if(!prospecto.getApellido_materno().isEmpty()){
                CI++;
                preparedStatement.setString(CI, prospecto.getApellido_materno());
            }
                            System.out.println(preparedStatement);

        result = preparedStatement.executeUpdate();

        }catch (SQLException e){
            System.out.println(e.getMessage());
            result = 505;

        }
        return result;
    }
}
