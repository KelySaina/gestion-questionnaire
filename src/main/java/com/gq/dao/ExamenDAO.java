package com.gq.dao;

import com.gq.model.Examen;
import com.gq.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExamenDAO {

    private Examen map(ResultSet rs) throws SQLException {
        Examen e = new Examen();
        e.setNumExam(rs.getInt("num_exam"));
        e.setNumEtudiant(rs.getString("num_etudiant"));
        e.setAnneeUniv(rs.getString("annee_univ"));
        e.setNote(rs.getInt("note"));
        Timestamp t = rs.getTimestamp("date_exam");
        if (t != null) e.setDateExam(t.toString());
        try { e.setNomEtudiant(rs.getString("nom")); } catch (SQLException ignored) {}
        try { e.setPrenomsEtudiant(rs.getString("prenoms")); } catch (SQLException ignored) {}
        try { e.setNiveauEtudiant(rs.getString("niveau")); } catch (SQLException ignored) {}
        return e;
    }

    public int insert(Examen ex) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "INSERT INTO EXAMEN(num_etudiant,annee_univ,note) VALUES(?,?,?)",
                Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, ex.getNumEtudiant());
            ps.setString(2, ex.getAnneeUniv());
            ps.setInt(3, ex.getNote());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Examen> listAll() throws SQLException {
        List<Examen> list = new ArrayList<>();
        String sql = "SELECT ex.*, et.nom, et.prenoms, et.niveau " +
                     "FROM EXAMEN ex JOIN ETUDIANT et ON et.num_etudiant = ex.num_etudiant " +
                     "ORDER BY ex.date_exam DESC";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    /** Classement par moyenne decroissante. */
    public List<Examen> ranking() throws SQLException {
        List<Examen> list = new ArrayList<>();
        String sql = "SELECT 0 AS num_exam, ex.num_etudiant, MAX(ex.annee_univ) AS annee_univ, " +
                     "ROUND(AVG(ex.note)) AS note, MAX(ex.date_exam) AS date_exam, " +
                     "et.nom, et.prenoms, et.niveau " +
                     "FROM EXAMEN ex JOIN ETUDIANT et ON et.num_etudiant = ex.num_etudiant " +
                     "GROUP BY ex.num_etudiant, et.nom, et.prenoms, et.niveau " +
                     "ORDER BY AVG(ex.note) DESC, et.nom ASC";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }
}
