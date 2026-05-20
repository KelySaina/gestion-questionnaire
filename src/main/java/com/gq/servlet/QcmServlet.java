package com.gq.servlet;

import com.gq.dao.QcmDAO;
import com.gq.model.Qcm;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "QcmServlet", urlPatterns = {"/qcm", "/qcm/*"})
public class QcmServlet extends HttpServlet {

    private final QcmDAO dao = new QcmDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        if (action == null) action = "/";
        try {
            switch (action) {
                case "/new":
                    req.setAttribute("qcm", new Qcm());
                    req.setAttribute("mode", "new");
                    req.getRequestDispatcher("/WEB-INF/views/qcm_form.jsp").forward(req, resp);
                    return;
                case "/edit": {
                    Qcm q = dao.findById(Integer.parseInt(req.getParameter("id")));
                    if (q == null) { resp.sendRedirect(req.getContextPath() + "/qcm"); return; }
                    req.setAttribute("qcm", q);
                    req.setAttribute("mode", "edit");
                    req.getRequestDispatcher("/WEB-INF/views/qcm_form.jsp").forward(req, resp);
                    return;
                }
                case "/delete":
                    dao.delete(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/qcm");
                    return;
                default:
                    req.setAttribute("liste", dao.findAll());
                    req.getRequestDispatcher("/WEB-INF/views/qcm_list.jsp").forward(req, resp);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Qcm q = new Qcm();
        String mode = req.getParameter("mode");
        if ("edit".equals(mode)) q.setNumQuest(Integer.parseInt(req.getParameter("num_quest")));
        q.setQuestion(req.getParameter("question"));
        q.setReponse1(req.getParameter("reponse1"));
        q.setReponse2(req.getParameter("reponse2"));
        q.setReponse3(req.getParameter("reponse3"));
        q.setReponse4(req.getParameter("reponse4"));
        q.setBonneReponse(Integer.parseInt(req.getParameter("bonne_reponse")));
        try {
            if ("edit".equals(mode)) dao.update(q);
            else dao.insert(q);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
        resp.sendRedirect(req.getContextPath() + "/qcm");
    }
}
