package controller;

import model.Song;
import service.SongService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SongServlet", urlPatterns = "/NHPmp3")
public class SongServlet extends HttpServlet {
    SongService songService = new SongService();
    public void init() {
        this.songService = new SongService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Song> songs = songService.findAll();
        request.setAttribute("songs", songs);
        request.getRequestDispatcher("songs.jsp").forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = request.getParameter("song");
        String filePath = "assets/music/" + fileName + ".mp3";
        String name = request.getParameter("name");
        Song song = new Song(name, filePath);
        songService.create(song);
        response.sendRedirect(request.getContextPath() + "NHPmp3");
    }
}
