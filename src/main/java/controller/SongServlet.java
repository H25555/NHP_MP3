package controller;


import model.Song;
import service.SongService;

import javax.servlet.RequestDispatcher;

import model.Author;
import model.Category;
import model.Singer;
import model.Song;
import service.AuthorService;
import service.CategoryService;
import service.SingerService;
import service.SongService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "SongServlet", urlPatterns = "/songs")

public class SongServlet extends HttpServlet {
    SongService songService = new SongService();
    AuthorService authorService = new AuthorService();
    CategoryService categoryService = new CategoryService();
    SingerService singerService = new SingerService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            case "create":
                showSreateSong(req,resp);
                break;
            default:
                showSong(req,resp);
        }
    }

    private void showSreateSong(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Song> songs = songService.findAll();
        req.setAttribute("songs", songs);
        List<Author> authors = authorService.findAll();
        List<Category> categories = categoryService.findAll();
        List<Singer> singers = singerService.findAll();
        req.setAttribute("authors",authors);
        req.setAttribute("categorys",categories);
        req.setAttribute("singers",singers);
        req.getRequestDispatcher("createSong.jsp").forward(req,resp);
    }
    public void createSong(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        int IDAuthor = Integer.parseInt(request.getParameter("author"));
        Author author = authorService.findByID(IDAuthor);
        int IDCategory = Integer.parseInt(request.getParameter("category"));
        Category category = categoryService.findByID(IDCategory);
        int IDSinger = Integer.parseInt(request.getParameter("singer"));
        Singer singer = singerService.findByID(IDSinger);
        String song1 = request.getParameter("song");
        String image = request.getParameter("image");
        Song song = new Song(name,author,category,singer,song1,image);
        songService.createSong(song);
        request.setAttribute("mesage","Thêm nhạc thành công");
        request.setAttribute("song",song);
        request.setAttribute("author",author);
        request.setAttribute("category",category);
        request.setAttribute("singer",singer);
        request.getRequestDispatcher("createSong.jsp").forward(request,response);



    }

    private void showSong(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Song> songs = songService.findAll();
        List<Author> authors = authorService.findAll();
        List<Category> categorys = categoryService.findAll();
        List<Singer> singers = singerService.findAll();
        req.setAttribute("songs", songs);
        req.setAttribute("authors",authors);
        req.setAttribute("categorys",categorys);
        req.setAttribute("singers",singers);
        req.getRequestDispatcher("song.jsp").forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String fileName = req.getParameter("song");
//        String filePath = "assets/music/" + fileName + ".mp3";
//        String name = req.getParameter("name");
//        Song song = new Song(name, filePath);
//        resp.sendRedirect(req.getContextPath() + "songs");
        String action = req.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            case "create":
                createSong(req,resp);
                break;
            default:
                showSong(req,resp);
        }
    }

}
