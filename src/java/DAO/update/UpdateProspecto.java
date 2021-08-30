/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO.update;

import com.concredito.model.ProspectoModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author ISC_G
 */
public class UpdateProspecto {
    public static int updateProspecto(Connection connection, ProspectoModel prospecto){
        int result = 505;
        try{
            String sql ="UPDATE `dbconcredito`.`prospectos`\n" +
                        "   SET\n" +
                        "   `estatus` =?,\n" +
                        "   `comentario` =? \n" +
                        "    WHERE `id` = ?";
                                        
            PreparedStatement preparedStatement = connection.prepareStatement(sql); //Evitar inyeccion SQL
            preparedStatement.setString(1, prospecto.getStatus() );
            preparedStatement.setString(2, prospecto.getComentario() );
            preparedStatement.setInt(3, prospecto.getId());

            System.out.println(preparedStatement);
        result = preparedStatement.executeUpdate();

        }catch (SQLException e){
            System.out.println(e.getMessage());
            result = 505;

        }
        return result;
    }
}
