package com.supermarche.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    // Instance unique du Singleton
    private static DatabaseConnection instance;

    // Connexion JDBC
    private Connection connection;

    // Informations de connexion
    private static final String URL = "jdbc:mysql://localhost:3306/projet_fed_s3";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    // Constructeur privé pour empêcher l'instanciation directe
    private DatabaseConnection() {
        try {
            // Charger le driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Établir la connexion
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connexion établie avec succès !");
        } catch (ClassNotFoundException e) {
            System.err.println("Driver JDBC introuvable !");
            throw new RuntimeException(e);
        } catch (SQLException e) {
            System.err.println("Erreur lors de la connexion à la base de données !");
            throw new RuntimeException(e);
        }
    }

    // Méthode publique pour obtenir l'instance unique du Singleton
    public static DatabaseConnection getInstance() {
        if (instance == null) {
            synchronized (DatabaseConnection.class) { // Assure un accès thread-safe
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }
        return instance;
    }

    // Retourne l'objet Connection pour les opérations JDBC
    public Connection getConnection() {
        return connection;
    }

    // Méthode pour fermer la connexion (optionnel)
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Connexion fermée avec succès !");
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la fermeture de la connexion !");
            throw new RuntimeException(e);
        }
    }
}
