package com.gq.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Petit fournisseur de connexion JDBC. Lit /db.properties dans le classpath
 * ou les variables d'environnement DB_URL / DB_USER / DB_PASSWORD.
 */
public final class DBUtil {

    private static String url;
    private static String user;
    private static String password;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Properties p = new Properties();
            try (InputStream is = DBUtil.class.getResourceAsStream("/db.properties")) {
                if (is != null) p.load(is);
            }
            url = env("DB_URL", p.getProperty("db.url",
                    "jdbc:mysql://localhost:3306/gestion_questionnaires?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true"));
            user = env("DB_USER", p.getProperty("db.user", "root"));
            password = env("DB_PASSWORD", p.getProperty("db.password", ""));
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    private DBUtil() {}

    private static String env(String key, String fallback) {
        String v = System.getenv(key);
        return (v == null || v.isEmpty()) ? fallback : v;
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}
