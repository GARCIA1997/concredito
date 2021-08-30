/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO.read;

import com.concredito.model.ProspectoModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ISC_G
 */
public class GetProspectosEvaluar {
     public static List<ProspectoModel>  getProspectos(Connection connection){
       List<ProspectoModel>  Prospectos = new ArrayList<>();
       try {
            String sql ="SELECT pr.id,\n" +
                        "	pr.nombre, \n" +
                        "	pr.apellido_paterno, \n" +
                        "    pr.apellido_materno,\n" +
                        "    es.nombre AS status\n" +
                        "   FROM dbconcredito.prospectos AS pr\n" +
                        "   INNER JOIN dbconcredito.cat_estados AS es ON es.id = pr.estatus\n" +
                        "   WHERE pr.estatus = 'EN' " ;
                            
            PreparedStatement preparedStatement = connection.prepareStatement(sql); //Evitar inyeccion SQL
            ResultSet result = preparedStatement.executeQuery();
            
            while (result.next()) {
                ProspectoModel prospecto = new ProspectoModel();
                prospecto = new ProspectoModel();
                prospecto.setId(result.getInt("id"));
                prospecto.setNombre(result.getString("nombre"));
                prospecto.setApellido_paterno(result.getString("apellido_paterno"));
                prospecto.setApellido_materno(result.getString("apellido_materno"));
                prospecto.setStatus(result.getString("status"));
                
                Prospectos.add(prospecto);
            }
            return Prospectos;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
}
