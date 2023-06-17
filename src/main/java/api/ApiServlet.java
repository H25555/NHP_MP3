package api;

import dao.LikeDAO;
import model.History;
import model.Like;
import model.Song;
import model.User;
import service.HistoryService;
import service.SongService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet(urlPatterns = "/api")
public class ApiServlet extends HttpServlet {
    HistoryService historyService = new HistoryService();
    SongService songService = new SongService();
    LikeDAO likeDAO = new LikeDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String action = req.getParameter("action");
       if(action == null){
           action ="";
       }
       switch (action){
           case "view":
               getView(req,resp);
           case "like":
               getLike(req,resp);

       }

    }

    private void getLike(HttpServletRequest req, HttpServletResponse resp) {
        int songid = Integer.parseInt(req.getParameter("id"));
        Song song = songService.findByID(songid);
        User user = (User) req.getSession().getAttribute("user");
        System.out.println(user.getId());
        Like like = new Like(user,song);
        if (likeDAO.checkLiked(user.getId(),songid)){
            likeDAO.dislike(user.getId());
        }else {
            likeDAO.createLike(like);
        }

    }

    private void getView(HttpServletRequest req, HttpServletResponse resp) {
        int songid = Integer.parseInt(req.getParameter("id"));
        Song song = songService.findByID(songid);
        User user = (User) req.getSession().getAttribute("user");
        History history = new History(user,song);
        historyService.createViewHistory(history);
    }
}
