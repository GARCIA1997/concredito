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

/**
 *
 * @author ISC_G
 */
public class GetDetalleProspecto {
    public static ProspectoModel getDetalleProspecto (Connection connection, String id){
       ProspectoModel prospecto = new ProspectoModel();
       try {
            String sql =    " SELECT pr.comentario,\n" +
                            "	 pr.nombre, \n" +
                            "	 pr.apellido_paterno, \n" +
                            "    pr.apellido_materno,\n" +
                            "    es.nombre AS status,\n" +
                            "    pr.calle,\n" +
                            "    pr.numero,\n" +
                            "    pr.codigo_postal,\n" +
                            "    pr.colonia,\n" +
                            "    pr.telefono,\n" +
                            "    pr.rfc,\n" +
                            "    pr.id,\n" +
                            "    pr.documetos\n" +
                            "   FROM dbconcredito.prospectos AS pr\n" +
                            "   INNER JOIN dbconcredito.cat_estados AS es ON es.id = pr.estatus\n" +
                            "   WHERE pr.id = ? ";
            PreparedStatement preparedStatement = connection.prepareStatement(sql); //Evitar inyeccion SQL
            preparedStatement.setString(1, id);
            ResultSet result = preparedStatement.executeQuery();
            
            if (result.next()) {
                
                prospecto = new ProspectoModel();    
                prospecto.setNombre(result.getString("nombre"));
                prospecto.setApellido_paterno(result.getString("apellido_paterno"));
                prospecto.setApellido_materno(result.getString("apellido_materno"));
                prospecto.setCalle(result.getString("calle"));
                prospecto.setNumero(result.getString("numero"));
                prospecto.setCodigo_postal(result.getString("codigo_postal"));
                prospecto.setColonia(result.getString("colonia"));
                prospecto.setTelefono(result.getString("telefono"));
                prospecto.setRfc(result.getString("rfc"));
                prospecto.setDocumentos(result.getString("documetos"));
                prospecto.setStatus(result.getString("status"));
                prospecto.setComentario(result.getString("comentario"));
                prospecto.setId(result.getInt("id"));

            } else {
                return null;
            }
            return prospecto;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
}
