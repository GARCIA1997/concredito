/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.concredito.controller;

import DAO.read.GetSession;
import com.concredito.database.DataBaseConnection;
import com.concredito.model.UsuariosModel;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.portlet.ModelAndView;

/**
 *
 * @author ISC_G
 */
public class InicioSesionController {
    //variable de la conexión a base de datos
    private DataBaseConnection connection;

    //Metodo para mostrar la pantalla de login    
    @RequestMapping("inicioSesion.htm")
    public ModelAndView inicioSesion (){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("inicioSesion");
        return mav;
    }
    //Metodo para validar el inicio de sesión
    @RequestMapping(value="iniciar_sesion.htm", method = RequestMethod.POST)
    public void iniciar_sesion(HttpServletRequest req, HttpServletResponse res) throws IOException {
        PrintWriter out = res.getWriter();
        
        //Recibimos las variables para iniciar Sesion
        String correo   = req.getParameter("correo");
        String password = req.getParameter("password");
        
        //Instanciar y crear conexión a la bd
        connection = new DataBaseConnection();
        connection.createConnection();
        
        //LLENAMOS una lista con el modelo de usuarios 
        System.out.println(connection.getConnection());
        System.out.println("//-----------------------------//");
        UsuariosModel usuariosModel = GetSession.getSession(connection.getConnection(), correo, password);
        
        //Cerrar conexión de la Base de Datos
        connection.closeConnection();
        if (usuariosModel != null) {
            HttpSession session = req.getSession(true); // Request for session
            session.setAttribute("user_session",  usuariosModel); // Here you set your values to the session
            //Exito    
            out.print(200);
        } else {
            //Usuario no encontrado en base de datos
            out.print(404);
        }
        out.close();
    }
}
