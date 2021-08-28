/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.concredito.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.ModelAndView;

/**
 *
 * @author ISC_G
 */
public class ProspectosController {
    @RequestMapping("prospectos.htm")
    public ModelAndView inicioSesion (){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("prospectos");
        return mav;
    }
}
