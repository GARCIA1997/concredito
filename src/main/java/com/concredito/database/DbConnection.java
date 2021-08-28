/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.concredito.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ISC_G
 */
public class DbConnection {
    private Connection connection;
    private final String urlDatabase = "jdbc:postgresql://localhost:5433/db_concreditos";
    private final String user = "postgres";
    private final String password = "12345";
    //private static String message;
    public Connection getConnection(){
        return connection;
    }
    public void setConnection (Connection connection){
        this.connection = connection;
    }
    public void createConection (){
        try{
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(urlDatabase, user, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
	} finally {
            System.out.println("Conexión creada correctamente");
        }
    }
    public void closeConnection() {
        try {
            connection.close();
            System.out.println("Conexión cerrada correctamente");
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
