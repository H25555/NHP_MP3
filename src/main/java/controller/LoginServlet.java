package controller;

import model.User;
import service.UserService;
import utils.PasswordEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;



@WebServlet(name = "loginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    UserService userService = new UserService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        User user = userService.findByUsername(username);
        if(user != null && PasswordEncoder.check(password, user.getPassword())){
            HttpSession session = req.getSession();
            session.setAttribute("role", user.getRole().getName());
            session.setAttribute("user",user);
            resp.sendRedirect("/home");
            return;
        }
        req.setAttribute("errors", "Login Failed");
        req.getRequestDispatcher("JSPuser/login.jsp")
                .forward(req,resp);
    }

    private void showLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("JSPuser/login.jsp")
                .forward(req,resp);
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("JSPuser/login.jsp")
                .forward(req,resp);
    }


}
