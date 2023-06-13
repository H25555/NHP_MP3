package controller;


import model.User;
import service.UserService;

import model.Role;
import model.User;
import service.RoleService;
import service.UserService;
import utils.PasswordEncoder;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import java.io.IOException;

//@WebServlet(name = "loginServlet", urlPatterns = "/user")
//public class UserServlet extends HttpServlet {
//    UserService userService = new UserService();
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String action = req.getParameter("action");
//        if (action == null) {
//            action = "";
//        }
//        switch (action) {
//            case "login":
//                showLogin(req, resp);
//                break;
//            case "signup":
//                showSignup(req, resp);
//                break;
//            case "logout":
//                showLogout(req, resp);
//                break;
//            case "myAccount":
//                showMyAccount(req, resp);
//                break;
//            default:
//        }
//    }
//
//    private void showMyAccount(HttpServletRequest req, HttpServletResponse resp) {
//    }
//
//    private void showLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        HttpSession session = req.getSession();
//        session.removeAttribute("user");
//        resp.sendRedirect("home");
//    }
//
//    private void showSignup(HttpServletRequest req, HttpServletResponse resp) {
//    }
//
//    private void showLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.getRequestDispatcher("/login.jsp").forward(req,resp);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String action = req.getParameter("action");
//        if (action == null) {
//            action = "";
//        }
//        switch (action) {
//            case "login":
//                checkLogin(req, resp);
//                break;
//            case "updateInfo":
//                updateInfo(req, resp);
//                break;
//            case "signup":
//                signup(req, resp);
//                break;


//
//@WebServlet(urlPatterns = "/admin/users")
//public class UserServlet extends HttpServlet {
//    RoleService roleService = new RoleService();
//    UserService userService = new UserService();
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String action = req.getParameter("action");
//        if (action == null){
//            action = "";
//        }
//        switch (action){
//            case "create":
//                createUser(req,resp);
//        }
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String action = req.getParameter("action");
//        if (action == null){
//            action = "";
//        }
//        switch (action){
//            case "create":
//            showCreate(req,resp);
//
//            default:
//        }
//    }
//
//
//    private void signup(HttpServletRequest req, HttpServletResponse resp) {
//    }
//
//    private void updateInfo(HttpServletRequest req, HttpServletResponse resp) {
//
//    }
//
//    private void checkLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String username = req.getParameter("username");
//        String password = req.getParameter("password");
//        User user = userService.login(username,password);
//        if (user == null) {
////            req.setAttribute("error", "Tài khoản không tồn tại hoặc mật khẩu không đúng !");
//            req.getRequestDispatcher("/signin.jsp").forward(req, resp);
////            response.sendRedirect("user?action=login");
//        } else {
//            HttpSession session = req.getSession();
//            session.setAttribute("user",user);
//            resp.sendRedirect("/home");
//        }
//
//    private void showCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.setAttribute("roles",roleService.findAll());
//        req.getRequestDispatcher("/create.jsp").forward(req,resp);
//    }
//
//    private void createUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String username = req.getParameter("username");
//        String password = PasswordEncoder.encode(req.getParameter("password"));
//        int roleId = Integer.parseInt(req.getParameter("role_id"));
//        Role role = roleService.findById(roleId);
//        User user = new User(username,password,role);
//        userService.createUser(user);
//        req.setAttribute("user", user);
//        req.setAttribute("message", "Created");
//        req.setAttribute("roles", roleService.findAll());
//        req.getRequestDispatcher("/create.jsp").forward(req,resp);
//
//    }
//}
