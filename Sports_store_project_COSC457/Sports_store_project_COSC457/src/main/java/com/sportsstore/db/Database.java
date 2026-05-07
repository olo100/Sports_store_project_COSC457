package com.sportsstore.db;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Singleton-style helper for opening JDBC connections.
 *
 * <p>Loads connection settings from {@code db.properties}. The lookup order is:
 * <ol>
 *   <li>Current working directory</li>
 *   <li>Directory containing the jar ({@code target/})</li>
 *   <li>Parent of that directory (project root in a Maven layout)</li>
 *   <li>Classpath (bundled inside the jar, if any)</li>
 * </ol>
 */
public final class Database {

    private static Properties props;

    private Database() {}

    private static synchronized Properties load() {
        if (props != null) return props;
        Properties p = new Properties();
        // 1. Current working directory
        File external = new File("db.properties");
        // 2. Next to the jar, and its parent (project root in a Maven target/ layout)
        if (!external.exists()) {
            try {
                File jarDir = new File(Database.class.getProtectionDomain()
                        .getCodeSource().getLocation().toURI()).getParentFile();
                for (File candidate : new File[]{
                        new File(jarDir, "db.properties"),
                        new File(jarDir.getParentFile(), "db.properties")}) {
                    if (candidate.exists()) { external = candidate; break; }
                }
            } catch (Exception ignored) {}
        }
        try {
            if (external.exists()) {
                try (InputStream in = new FileInputStream(external)) {
                    p.load(in);
                }
            } else {
                try (InputStream in = Database.class.getResourceAsStream("/db.properties")) {
                    if (in != null) p.load(in);
                }
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to read db.properties", e);
        }
        // Sensible defaults so the app at least tries something.
        p.putIfAbsent("db.host", "localhost");
        p.putIfAbsent("db.port", "3306");
        p.putIfAbsent("db.name", "sports_storedb");
        p.putIfAbsent("db.user", "root");
        p.putIfAbsent("db.password", "");
        p.putIfAbsent("db.params", "useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
        props = p;
        return p;
    }

    /** Returns a fresh connection. Caller must close it (try-with-resources recommended). */
    public static Connection getConnection() throws SQLException {
        Properties p = load();
        String url = String.format(
                "jdbc:mysql://%s:%s/%s?%s",
                p.getProperty("db.host"),
                p.getProperty("db.port"),
                p.getProperty("db.name"),
                p.getProperty("db.params"));
        return DriverManager.getConnection(url, p.getProperty("db.user"), p.getProperty("db.password"));
    }

    /** Quick connection check, useful for the splash/login screen. */
    public static boolean testConnection() {
        try (Connection c = getConnection()) {
            return c.isValid(3);
        } catch (SQLException e) {
            return false;
        }
    }

    public static String describeTarget() {
        Properties p = load();
        return String.format("%s@%s:%s/%s",
                p.getProperty("db.user"),
                p.getProperty("db.host"),
                p.getProperty("db.port"),
                p.getProperty("db.name"));
    }
}
