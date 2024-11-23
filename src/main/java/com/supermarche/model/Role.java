package com.supermarche.model;

public enum Role {
    CAISSIER,
    ADMIN,
    RESPONSABLECATEGORIE;

    public static Role fromString(String role) {
        try {
            return Role.valueOf(role.toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Valeur de rôle non valide : " + role);
        }
    }
}
