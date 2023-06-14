package controller;

import model.Song;
import service.DemoSongService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SongServlet", urlPatterns = "/NHPmp3")
public class DemoSongServlet extends HttpServlet {
    DemoSongService demoSongService = new DemoSongService();
    public void init() {
        this.demoSongService = new DemoSongService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Song> songs = demoSongService.findAll();
        request.setAttribute("songs", songs);
        request.getRequestDispatcher("songs.jsp").forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = request.getParameter("song");
        String filePath = "assets/music/" + fileName + ".mp3";
        String name = request.getParameter("name");
        Song song = new Song(name, filePath);
        demoSongService.create(song);
        response.sendRedirect(request.getContextPath() + "NHPmp3");
    }
}
