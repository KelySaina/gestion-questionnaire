package com.gq.servlet;

import com.gq.dao.EtudiantDAO;
import com.gq.model.Etudiant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "EtudiantServlet", urlPatterns = {"/etudiants", "/etudiants/*"})
public class EtudiantServlet extends HttpServlet {

    private final EtudiantDAO dao = new EtudiantDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        if (action == null) action = "/";
        try {
            switch (action) {
                case "/new":
                    req.setAttribute("etudiant", new Etudiant());
                    req.setAttribute("mode", "new");
                    req.getRequestDispatcher("/WEB-INF/views/etudiant_form.jsp").forward(req, resp);
                    return;
                case "/edit": {
                    Etudiant e = dao.findById(req.getParameter("id"));
                    if (e == null) { resp.sendRedirect(req.getContextPath() + "/etudiants"); return; }
                    req.setAttribute("etudiant", e);
                    req.setAttribute("mode", "edit");
                    req.getRequestDispatcher("/WEB-INF/views/etudiant_form.jsp").forward(req, resp);
                    return;
                }
                case "/delete":
                    dao.delete(req.getParameter("id"));
                    resp.sendRedirect(req.getContextPath() + "/etudiants");
                    return;
                case "/niveaux": {
                    Map<String, Integer> counts = dao.countByNiveau();
                    String n = req.getParameter("niveau");
                    if (n != null && !n.isEmpty()) {
                        req.setAttribute("niveau", n);
                        req.setAttribute("liste", dao.findByNiveau(n));
                    }
                    req.setAttribute("counts", counts);
                    req.getRequestDispatcher("/WEB-INF/views/etudiants_niveaux.jsp").forward(req, resp);
                    return;
                }
                default: {
                    String q = req.getParameter("q");
                    List<Etudiant> list = (q == null || q.isEmpty()) ? dao.findAll() : dao.search(q);
                    req.setAttribute("liste", list);
                    req.setAttribute("q", q);
                    req.getRequestDispatcher("/WEB-INF/views/etudiants_list.jsp").forward(req, resp);
                }
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String mode = req.getParameter("mode");
        Etudiant e = new Etudiant(
                req.getParameter("num_etudiant"),
                req.getParameter("nom"),
                req.getParameter("prenoms"),
                req.getParameter("niveau"),
                req.getParameter("adr_email"));
        try {
            if ("edit".equals(mode)) dao.update(e);
            else dao.insert(e);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
        resp.sendRedirect(req.getContextPath() + "/etudiants");
    }
}
