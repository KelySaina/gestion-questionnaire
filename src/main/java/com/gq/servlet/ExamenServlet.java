package com.gq.servlet;

import com.gq.dao.EtudiantDAO;
import com.gq.dao.ExamenDAO;
import com.gq.dao.QcmDAO;
import com.gq.model.Etudiant;
import com.gq.model.Examen;
import com.gq.model.Qcm;
import com.gq.util.MailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ExamenServlet", urlPatterns = {"/examen", "/examen/*"})
public class ExamenServlet extends HttpServlet {

    private final EtudiantDAO etudiantDAO = new EtudiantDAO();
    private final QcmDAO qcmDAO = new QcmDAO();
    private final ExamenDAO examenDAO = new ExamenDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        if (action == null) action = "/";
        try {
            switch (action) {
                case "/start":
                    req.setAttribute("etudiants", etudiantDAO.findAll());
                    req.setAttribute("anneeUniv", anneeUnivCourante());
                    req.getRequestDispatcher("/WEB-INF/views/examen_start.jsp").forward(req, resp);
                    return;
                case "/notes":
                    req.setAttribute("liste", examenDAO.listAll());
                    req.getRequestDispatcher("/WEB-INF/views/examen_notes.jsp").forward(req, resp);
                    return;
                case "/classement":
                    req.setAttribute("liste", examenDAO.ranking());
                    req.getRequestDispatcher("/WEB-INF/views/examen_classement.jsp").forward(req, resp);
                    return;
                default:
                    resp.sendRedirect(req.getContextPath() + "/examen/start");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        if (action == null) action = "/";
        try {
            switch (action) {
                case "/passer":
                    passer(req, resp);
                    return;
                case "/soumettre":
                    soumettre(req, resp);
                    return;
                default:
                    resp.sendRedirect(req.getContextPath() + "/examen/start");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void passer(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String num = req.getParameter("num_etudiant");
        String annee = req.getParameter("annee_univ");
        Etudiant et = etudiantDAO.findById(num);
        if (et == null) {
            req.setAttribute("erreur", "Etudiant introuvable.");
            req.setAttribute("etudiants", etudiantDAO.findAll());
            req.setAttribute("anneeUniv", anneeUnivCourante());
            req.getRequestDispatcher("/WEB-INF/views/examen_start.jsp").forward(req, resp);
            return;
        }
        List<Qcm> questions = qcmDAO.randomTen();
        HttpSession session = req.getSession();
        Map<Integer, Integer> bonnes = new HashMap<>();
        List<Integer> ids = new ArrayList<>();
        for (Qcm q : questions) {
            bonnes.put(q.getNumQuest(), q.getBonneReponse());
            ids.add(q.getNumQuest());
        }
        session.setAttribute("exam.bonnes", bonnes);
        session.setAttribute("exam.ids", ids);
        session.setAttribute("exam.num_etudiant", et.getNumEtudiant());
        session.setAttribute("exam.annee", annee);

        req.setAttribute("etudiant", et);
        req.setAttribute("annee", annee);
        req.setAttribute("questions", questions);
        req.getRequestDispatcher("/WEB-INF/views/examen_passer.jsp").forward(req, resp);
    }

    @SuppressWarnings("unchecked")
    private void soumettre(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        Map<Integer, Integer> bonnes = (Map<Integer, Integer>) session.getAttribute("exam.bonnes");
        List<Integer> ids = (List<Integer>) session.getAttribute("exam.ids");
        String num = (String) session.getAttribute("exam.num_etudiant");
        String annee = (String) session.getAttribute("exam.annee");
        if (bonnes == null || ids == null || num == null) {
            resp.sendRedirect(req.getContextPath() + "/examen/start");
            return;
        }
        int score = 0;
        for (Integer id : ids) {
            String r = req.getParameter("q_" + id);
            if (r != null) {
                try {
                    int choisi = Integer.parseInt(r);
                    if (choisi == bonnes.get(id)) score++;
                } catch (NumberFormatException ignored) {}
            }
        }
        Examen ex = new Examen();
        ex.setNumEtudiant(num);
        ex.setAnneeUniv(annee);
        ex.setNote(score);
        examenDAO.insert(ex);

        Etudiant et = etudiantDAO.findById(num);
        String emailStatut = "OK";
        try {
            String body = "Bonjour " + et.getPrenoms() + " " + et.getNom() + ",\n\n" +
                    "Vous avez obtenu la note de " + score + "/10 a l'examen " + annee + ".\n\n" +
                    "Cordialement,\nGestion des Questionnaires";
            MailUtil.send(et.getAdrEmail(), "Votre note d'examen " + annee, body);
        } catch (Exception mailErr) {
            emailStatut = "Echec envoi email: " + mailErr.getMessage();
            getServletContext().log("Mail error", mailErr);
        }

        // nettoyage session
        session.removeAttribute("exam.bonnes");
        session.removeAttribute("exam.ids");
        session.removeAttribute("exam.num_etudiant");
        session.removeAttribute("exam.annee");

        req.setAttribute("etudiant", et);
        req.setAttribute("note", score);
        req.setAttribute("annee", annee);
        req.setAttribute("emailStatut", emailStatut);
        req.getRequestDispatcher("/WEB-INF/views/examen_resultat.jsp").forward(req, resp);
    }

    private String anneeUnivCourante() {
        Calendar c = Calendar.getInstance();
        int y = c.get(Calendar.YEAR);
        int m = c.get(Calendar.MONTH); // 0-based
        // annee universitaire = sept -> aout
        if (m >= Calendar.SEPTEMBER) return y + "-" + (y + 1);
        return (y - 1) + "-" + y;
    }
}
