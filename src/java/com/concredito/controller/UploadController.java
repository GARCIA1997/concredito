/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.concredito.controller;


import java.io.File;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author ISC_G
 */
public class UploadController {
    
    //Metodo para validar el inicio de sesión
    
    @RequestMapping(value = "singleFileUpload.htm", method = RequestMethod.POST)        
    public ResponseEntity<?> singleFileUpload( @RequestParam("file") MultipartFile file ) {

        String fileName = file.getOriginalFilename();
        try {
          file.transferTo( new File("C:\\Users\\ISC_G\\OneDrive\\Alejandro\\Documentos\\NetBeansProjects\\concredito\\web\\resources\\files\\" + fileName));
        } catch (Exception e) {
          return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } 
        return ResponseEntity.ok("resources/files/" + fileName);
    }
}
