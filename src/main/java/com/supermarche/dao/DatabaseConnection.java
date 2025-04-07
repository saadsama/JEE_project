package com.supermarche.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.ConcurrentLinkedQueue;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/projet_fed_s3";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    private static final int MAX_CONNECTIONS = 10;
    private static ConcurrentLinkedQueue<Connection> connectionPool = new ConcurrentLinkedQueue<>();

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Préchauffer le pool de connexions
            for (int i = 0; i < MAX_CONNECTIONS; i++) {
                connectionPool.offer(createNewConnection());
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver JDBC introuvable", e);
        }
    }

    private static Connection createNewConnection() throws RuntimeException {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            throw new RuntimeException("Erreur de connexion à la base", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        Connection conn = connectionPool.poll();
        if (conn == null || conn.isClosed()) {
            conn = createNewConnection();
        }
        return conn;
    }

    public static void returnConnection(Connection conn) {
        if (conn != null) {
            try {
                if (!conn.isClosed()) {
                    connectionPool.offer(conn);
                }
            } catch (SQLException e) {
                // Log error
            }
        }
    }

    // Fermeture de toutes les connexions du pool
    public static void closeAllConnections() {
        for (Connection conn : connectionPool) {
            try {
                if (!conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                // Log error
            }
        }
        connectionPool.clear();
    }
}