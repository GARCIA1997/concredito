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
 * @author login
 */
public class DataBaseConnection {
    private Connection connection;
    private final String HOST = "localhost";
    private final String PORT = "3305";
    private final String DBNAME = "dbconcredito";
    private final String URLDB = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DBNAME+"?useTimeZone=true&serverTimezone=UTC&autoReconnect=true&useSSL=false";
    private final String USER = "root";
    private final String PASSWORD = "admin";
    
    public Connection getConnection() {
	return connection;
    }

    public void setConnection(Connection connection) {
	this.connection = connection;
    }
    
    public void createConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(URLDB, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
	} finally {
            System.out.println("Conexión creada correctamente");
        }
    }
    
    public void closeConnection() {
        try {
            connection.close();
            
            System.out.println("Conexión cerrsada correctamente");
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
