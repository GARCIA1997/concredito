/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.concredito.controller;

import DAO.read.GetProspectos;
import DAO.set.SetProspecto;
import DAO.read.GetDetalleProspecto;
import DAO.read.GetProspectosEvaluar;
import DAO.update.UpdateProspecto;
import com.concredito.database.DataBaseConnection;
import com.concredito.model.ProspectoModel;
import com.concredito.model.UsuariosModel;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author ISC_G
 */
public class ProspectosController {
    private DataBaseConnection connection;

    @RequestMapping("prospectos.htm")
    public ModelAndView prospectos (HttpServletRequest req, HttpServletResponse res){
        HttpSession session = req.getSession();        
        Enumeration<String> attributesNames = session.getAttributeNames();        
        if (attributesNames.hasMoreElements()) {
            connection = new DataBaseConnection();
            connection.createConnection();

            //llenar listas
            List<ProspectoModel> listProspectos = GetProspectos.getProspectos(connection.getConnection());
            int countListProspectos = listProspectos != null ? listProspectos.size() : 0;
            //Cerrar conexión de la Base de DatosmonitoreoReporteModel   GetMonitoreoReportes.getReportes
            connection.closeConnection();
            ModelAndView mav = new ModelAndView();
            mav.addObject("listProspectos", listProspectos);
            mav.addObject("countListProspectos", countListProspectos);
            mav.setViewName("prospectos");
            return mav;
        }
            return new ModelAndView("redirect:/inicioSesion.htm");        
    }
    @RequestMapping("agregar_prospectos.htm")
    public ModelAndView agregar_prospectos (){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("agregar_prospectos");
        return mav;
    }
    @RequestMapping( value = "set_prospecto.htm", method = RequestMethod.POST)
    public void set_prospecto (HttpServletRequest req, HttpServletResponse res) throws IOException{
        PrintWriter out = res.getWriter();
        
        int result = 500;
        //Declaramos las variables a recibir para el insert
        String nombre           =   req.getParameter("nombre");
        String apellido_paterno =   req.getParameter("apellido_paterno");
        String apellido_materno =   req.getParameter("apellido_materno");
        String calle            =   req.getParameter("calle");
        String numero           =   req.getParameter("numero");
        String colonia          =   req.getParameter("colonia");
        String codigo_postal    =   req.getParameter("codigo_postal");
        String telefono         =   req.getParameter("telefono");
        String rfc              =   req.getParameter("rfc");
        String documentos       =   "";
        String status           =   "EN";
        
        HttpSession session = req.getSession();        
        Enumeration<String> attributesNames = session.getAttributeNames(); 
        //Validamos si hay sesion iniciada
        if (attributesNames.hasMoreElements()) {
            UsuariosModel usuariosModel =(UsuariosModel) session.getAttribute("user_session");
            
            String id_usuario = usuariosModel.getId(); 
            
            ProspectoModel prospecto = new ProspectoModel();
            
            prospecto.setNombre(nombre);
            prospecto.setApellido_paterno(apellido_paterno);
            prospecto.setApellido_materno(apellido_materno);
            prospecto.setCalle(calle);
            prospecto.setNumero(numero);
            prospecto.setColonia(colonia);
            prospecto.setCodigo_postal(codigo_postal);
            prospecto.setTelefono(telefono);
            prospecto.setRfc(rfc);
            prospecto.setDocumentos(documentos);
            prospecto.setStatus(status);
            
            //Instanciar y crear conexion a la bd
            connection = new DataBaseConnection();
            connection.createConnection();
                result = SetProspecto.setProspecto(connection.getConnection(), prospecto);
            connection.closeConnection();
                System.out.println(result);
            if(result != 0){
                 out.print(result);
                out.close();
            } else{
                result = 0005;
                 out.print(result);
                out.close();
            } 
        }
         out.print(result);
                out.close();
    }
    @RequestMapping ("getDetalleProspecto.htm")
    public void getDetalleProspecto (HttpServletRequest req, HttpServletResponse res) throws IOException{
        PrintWriter out = res.getWriter();
        String id   = req.getParameter("id");

        HttpSession session = req.getSession();        
        Enumeration<String> attributesNames = session.getAttributeNames();        
        if (attributesNames.hasMoreElements()) {
            connection = new DataBaseConnection();
            connection.createConnection();

            //llenar listas

            ProspectoModel DetalleProspecto   =  GetDetalleProspecto.getDetalleProspecto(connection.getConnection(), id);
            //Cerrar conexión de la Base de DatosmonitoreoReporteModel   GetMonitoreoReportes.getReportes
            connection.closeConnection();
            String jsonDetalleProspecto = new Gson().toJson(DetalleProspecto);
            out.print(jsonDetalleProspecto);
        }
    }
    @RequestMapping("evaluar.htm")
    public ModelAndView evaluar (HttpServletRequest req, HttpServletResponse res){
        HttpSession session = req.getSession();        
        Enumeration<String> attributesNames = session.getAttributeNames();        
        if (attributesNames.hasMoreElements()) {
            connection = new DataBaseConnection();
            connection.createConnection();

            //llenar listas
            List<ProspectoModel> listProspectos = GetProspectosEvaluar.getProspectos(connection.getConnection());
            int countListProspectos = listProspectos != null ? listProspectos.size() : 0;
            //Cerrar conexión de la Base de DatosmonitoreoReporteModel   GetMonitoreoReportes.getReportes
            connection.closeConnection();
            ModelAndView mav = new ModelAndView();
            mav.addObject("listProspectos", listProspectos);
            mav.addObject("countListProspectos", countListProspectos);
            mav.setViewName("evaluar");
            return mav;
        }
            return new ModelAndView("redirect:/inicioSesion.htm");        
    }
    @RequestMapping( value = "update_prospecto.htm", method = RequestMethod.POST)
    public void update_prospecto (HttpServletRequest req, HttpServletResponse res) throws IOException{
        PrintWriter out = res.getWriter();
        
        int result = 500;
        //Declaramos las variables a recibir para el insert
        String    id           =   req.getParameter("id");
        String comentario   =   req.getParameter("comentario");
        String estado       =   req.getParameter("estado");
        
        HttpSession session = req.getSession();        
        Enumeration<String> attributesNames = session.getAttributeNames(); 
        //Validamos si hay sesion iniciada
        if (attributesNames.hasMoreElements()) {
            UsuariosModel usuariosModel =(UsuariosModel) session.getAttribute("user_session");
            
            String id_usuario = usuariosModel.getId(); 
            
            ProspectoModel prospecto = new ProspectoModel();
            
            prospecto.setId(Integer.parseInt(id));
            prospecto.setComentario(comentario);
            prospecto.setStatus(estado);
            
            //Instanciar y crear conexion a la bd
            connection = new DataBaseConnection();
            connection.createConnection();
                result = UpdateProspecto.updateProspecto(connection.getConnection(), prospecto);
            connection.closeConnection();
                System.out.println(result);
            if(result != 0){
                 out.print(result);
                out.close();
            } else{
                result = 0005;
                 out.print(result);
                out.close();
            } 
        }
         out.print(result);
                out.close();
    }
  

}

