package controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import dao.SongDAO;
import dao.UploadDAO;
import dto.Pageable;
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

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
@WebServlet(name = "SongUserServlet", urlPatterns = "/list_songs")


public class SongUserServlet extends HttpServlet {
    private int TOTAL_ITEMS = 18;
    SongService songService = new SongService();
    AuthorService authorService = new AuthorService();
    CategoryService categoryService = new CategoryService();
    SingerService singerService = new SingerService();
    SongDAO songDAO = new SongDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            default:
                showSong(req,resp);
        }
    }

    private void showSong(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String search = req.getParameter("search");
        int page = 1;
        if(req.getParameter("page") != null){
            page = Integer.parseInt(req.getParameter("page"));
        }
        String sortBy = req.getParameter("sortBy");
        if(sortBy == null){
            sortBy = "asc";
        }
        String nameField = req.getParameter("nameField");
        if(nameField == null){
            nameField = "song.id";
        }
        int filterAuthor = 0;
        if (req.getParameter("author") != null && !Objects.equals(req.getParameter("author"), "")) {
            filterAuthor = Integer.parseInt(req.getParameter("author"));
        }

        int filterSinger = 0;
        if (req.getParameter("singer") != null && !Objects.equals(req.getParameter("singer"), "")) {
            filterSinger = Integer.parseInt(req.getParameter("singer"));
        }

        int filterCategory = 0;
        if (req.getParameter("category") != null && !Objects.equals(req.getParameter("category"), "")) {
            filterCategory = Integer.parseInt(req.getParameter("category"));
        }
        Pageable pageable = new Pageable(search,page,TOTAL_ITEMS,nameField,sortBy,filterAuthor,filterSinger,filterCategory);

        List<Song> songs = songDAO.showFilter(pageable, filterAuthor, filterSinger, filterCategory);
        req.setAttribute("authors",authorService.findAll());
        req.setAttribute("singers",singerService.findAll());
        req.setAttribute("categories",categoryService.findAll());
        req.setAttribute("pageable", pageable);
        req.setAttribute("songs", songs);
        req.getRequestDispatcher("/JSPhomeUser/songs.jsp").forward(req,resp);


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            default:
                showSong(req,resp);
        }
    }

    public static String convertListToJson(List<?> list) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(list);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }
}
