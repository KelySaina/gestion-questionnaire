package com.gq.dao;

import com.gq.model.Qcm;
import com.gq.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QcmDAO {

    private Qcm map(ResultSet rs) throws SQLException {
        Qcm q = new Qcm();
        q.setNumQuest(rs.getInt("num_quest"));
        q.setQuestion(rs.getString("question"));
        q.setReponse1(rs.getString("reponse1"));
        q.setReponse2(rs.getString("reponse2"));
        q.setReponse3(rs.getString("reponse3"));
        q.setReponse4(rs.getString("reponse4"));
        q.setBonneReponse(rs.getInt("bonne_reponse"));
        return q;
    }

    public List<Qcm> findAll() throws SQLException {
        List<Qcm> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM QCM ORDER BY num_quest");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public Qcm findById(int id) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM QCM WHERE num_quest = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    /** Tire 10 questions au hasard (ou moins s'il y en a moins). */
    public List<Qcm> randomTen() throws SQLException {
        List<Qcm> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM QCM ORDER BY RAND() LIMIT 10");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public int insert(Qcm q) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "INSERT INTO QCM(question,reponse1,reponse2,reponse3,reponse4,bonne_reponse) VALUES(?,?,?,?,?,?)",
                Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, q.getQuestion());
            ps.setString(2, q.getReponse1());
            ps.setString(3, q.getReponse2());
            ps.setString(4, q.getReponse3());
            ps.setString(5, q.getReponse4());
            ps.setInt(6, q.getBonneReponse());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    public void update(Qcm q) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                "UPDATE QCM SET question=?,reponse1=?,reponse2=?,reponse3=?,reponse4=?,bonne_reponse=? WHERE num_quest=?")) {
            ps.setString(1, q.getQuestion());
            ps.setString(2, q.getReponse1());
            ps.setString(3, q.getReponse2());
            ps.setString(4, q.getReponse3());
            ps.setString(5, q.getReponse4());
            ps.setInt(6, q.getBonneReponse());
            ps.setInt(7, q.getNumQuest());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM QCM WHERE num_quest = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
