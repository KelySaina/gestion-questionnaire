package com.gq.dao;

import com.gq.model.Etudiant;
import com.gq.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class EtudiantDAO {

    private Etudiant map(ResultSet rs) throws SQLException {
        return new Etudiant(
                rs.getString("num_etudiant"),
                rs.getString("nom"),
                rs.getString("prenoms"),
                rs.getString("niveau"),
                rs.getString("adr_email"));
    }

    public List<Etudiant> findAll() throws SQLException {
        List<Etudiant> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM ETUDIANT ORDER BY nom, prenoms");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public Etudiant findById(String num) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM ETUDIANT WHERE num_etudiant = ?")) {
            ps.setString(1, num);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    /** Recherche par numero OU nom avec LIKE. */
    public List<Etudiant> search(String terme) throws SQLException {
        List<Etudiant> list = new ArrayList<>();
        String like = "%" + (terme == null ? "" : terme) + "%";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "SELECT * FROM ETUDIANT WHERE num_etudiant LIKE ? OR nom LIKE ? ORDER BY nom")) {
            ps.setString(1, like);
            ps.setString(2, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public List<Etudiant> findByNiveau(String niveau) throws SQLException {
        List<Etudiant> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "SELECT * FROM ETUDIANT WHERE niveau = ? ORDER BY nom, prenoms")) {
            ps.setString(1, niveau);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    /** Map niveau -> effectif. */
    public Map<String, Integer> countByNiveau() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        for (String n : new String[]{"L1","L2","L3","M1","M2"}) map.put(n, 0);
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "SELECT niveau, COUNT(*) AS eff FROM ETUDIANT GROUP BY niveau");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("niveau"), rs.getInt("eff"));
        }
        return map;
    }

    public void insert(Etudiant e) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "INSERT INTO ETUDIANT(num_etudiant,nom,prenoms,niveau,adr_email) VALUES(?,?,?,?,?)")) {
            ps.setString(1, e.getNumEtudiant());
            ps.setString(2, e.getNom());
            ps.setString(3, e.getPrenoms());
            ps.setString(4, e.getNiveau());
            ps.setString(5, e.getAdrEmail());
            ps.executeUpdate();
        }
    }

    public void update(Etudiant e) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "UPDATE ETUDIANT SET nom=?,prenoms=?,niveau=?,adr_email=? WHERE num_etudiant=?")) {
            ps.setString(1, e.getNom());
            ps.setString(2, e.getPrenoms());
            ps.setString(3, e.getNiveau());
            ps.setString(4, e.getAdrEmail());
            ps.setString(5, e.getNumEtudiant());
            ps.executeUpdate();
        }
    }

    public void delete(String num) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM ETUDIANT WHERE num_etudiant = ?")) {
            ps.setString(1, num);
            ps.executeUpdate();
        }
    }
}
