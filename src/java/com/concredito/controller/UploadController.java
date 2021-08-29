/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.concredito.controller;


import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author ISC_G
 */
public class UploadController {
    private static String UPLOADED_FOLDER = "/web/resources/files//";
    
    //Metodo para validar el inicio de sesión
    @PostMapping("singleFileUpload.htm")
    public String singleFileUpload(@RequestParam("file") MultipartFile file,RedirectAttributes redirectAttributes) {
         System.out.println(file);
        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            return  "504";
         }
        try {
            // Get the file and save it somewhere
            byte[] bytes = file.getBytes();
            Path path = Paths.get(UPLOADED_FOLDER + file.getOriginalFilename());
            Files.write(path, bytes);
        } catch (IOException e) {
            e.printStackTrace();
            return"505";
        }
        return "200";
    }
}
