package com.gq.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

/**
 * Envoi d'email via l'API HTTP ks-mailer (nodemailer-api).
 *
 * Endpoint : POST https://ks-mailer.vercel.app/api/send
 * Body JSON: { "from", "to", "subject", "message" }
 *
 * Configurable par /mail.properties (classpath) ou variables d'environnement :
 *   MAIL_API_URL  (defaut: https://ks-mailer.vercel.app/api/send)
 *   MAIL_FROM     (adresse expediteur affichee)
 */
public final class MailUtil {

    private static final Properties P = new Properties();

    static {
        try (InputStream is = MailUtil.class.getResourceAsStream("/mail.properties")) {
            if (is != null) P.load(is);
        } catch (Exception ignored) {}
    }

    private MailUtil() {}

    private static String cfg(String key, String def) {
        String env = System.getenv(key.toUpperCase().replace('.', '_'));
        if (env != null && !env.isEmpty()) return env;
        return P.getProperty(key, def);
    }

    public static void send(String to, String subject, String body) throws IOException {
        final String apiUrl = cfg("mail.api.url", "https://ks-mailer.vercel.app/api/send");
        final String from   = cfg("mail.from", "no-reply@example.com");

        String json = "{"
                + "\"from\":\""    + escape(from)    + "\","
                + "\"to\":\""      + escape(to)      + "\","
                + "\"subject\":\"" + escape(subject) + "\","
                + "\"message\":\"" + escape(body)    + "\""
                + "}";

        HttpURLConnection conn = (HttpURLConnection) new URL(apiUrl).openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setConnectTimeout(10_000);
        conn.setReadTimeout(20_000);
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setRequestProperty("Accept", "application/json");

        byte[] payload = json.getBytes(StandardCharsets.UTF_8);
        conn.setFixedLengthStreamingMode(payload.length);
        try (OutputStream os = conn.getOutputStream()) {
            os.write(payload);
        }

        int code = conn.getResponseCode();
        InputStream stream = (code >= 200 && code < 300) ? conn.getInputStream() : conn.getErrorStream();
        StringBuilder resp = new StringBuilder();
        if (stream != null) {
            try (BufferedReader br = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8))) {
                String line;
                while ((line = br.readLine()) != null) resp.append(line);
            }
        }
        if (code < 200 || code >= 300) {
            throw new IOException("Mailer API HTTP " + code + " : " + resp);
        }
    }

    private static String escape(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder(s.length() + 8);
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '"':  sb.append("\\\""); break;
                case '\\': sb.append("\\\\"); break;
                case '\b': sb.append("\\b");  break;
                case '\f': sb.append("\\f");  break;
                case '\n': sb.append("\\n");  break;
                case '\r': sb.append("\\r");  break;
                case '\t': sb.append("\\t");  break;
                default:
                    if (c < 0x20) sb.append(String.format("\\u%04x", (int) c));
                    else sb.append(c);
            }
        }
        return sb.toString();
    }
}
