package controller;


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

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;




@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
@WebServlet(name = "SongServlet", urlPatterns = "/admin/songs")


public class SongServlet extends HttpServlet {
    private int TOTAL_ITEMS = 5;
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
            case "create":
                showSreateSong(req,resp);
                break;
            case "edit":
                showEditSong(req,resp);
                break;
            case "delete" :
                deleteSong(req,resp);
                break;
            default:
                showSong(req,resp);
        }
    }

    private void showEditSong(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Song song = songService.findByID(id);
        req.setAttribute("song", song);
        List<Author> authors = authorService.findAll();
        List<Category> categories = categoryService.findAll();
        List<Singer> singers = singerService.findAll();
        req.setAttribute("authors",authors);
        req.setAttribute("categorys",categories);
        req.setAttribute("singers",singers);
        req.getRequestDispatcher("/editSong.jsp").forward(req,resp);
    }
    public void editSong(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int IDAuthor = Integer.parseInt(request.getParameter("author"));
        Author author = authorService.findByID(IDAuthor);
        int IDCategory = Integer.parseInt(request.getParameter("category"));
        Category category = categoryService.findByID(IDCategory);
        int IDSinger = Integer.parseInt(request.getParameter("singer"));
        Singer singer = singerService.findByID(IDSinger);
        String song1 = request.getParameter("song");
        String image = request.getParameter("image");
        Song song = new Song(id,name,author,category,singer,song1,image);
        songService.editSong(song);
        request.setAttribute("message","Update thành công");
        request.setAttribute("song",song);
        request.setAttribute("author",author);
        request.setAttribute("category",category);
        request.setAttribute("singer",singer);
        request.getRequestDispatcher("/editSong.jsp").forward(request,response);

    }

    private void showSreateSong(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Author> authors = authorService.findAll();
        List<Category> categories = categoryService.findAll();
        List<Singer> singers = singerService.findAll();

        req.setAttribute("authors", authors);
        req.setAttribute("categorys", categories);
        req.setAttribute("singers", singers);
        req.getRequestDispatcher("/createSong.jsp").forward(req, resp);
        resp.sendRedirect(req.getContextPath() + "/songs");

    }
    public void createSong(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        int IDAuthor = Integer.parseInt(request.getParameter("author"));
        Author author = authorService.findByID(IDAuthor);
        int IDCategory = Integer.parseInt(request.getParameter("category"));
        Category category = categoryService.findByID(IDCategory);
        int IDSinger = Integer.parseInt(request.getParameter("singer"));
        Singer singer = singerService.findByID(IDSinger);


        String UPLOAD_DIR = "assets/music/";
        Part filePart = request.getPart("filePart");
        String fileName = getFileName(filePart);

        if (filePart != null && !fileName.isEmpty()) {
            String filePath = UPLOAD_DIR + fileName;
            saveFileToServer(filePart, filePath);
            Song song = new Song(name, author, category, singer, filePath, null);
            songDAO.saveSongToDatabase(song);
            response.getWriter().println("Upload and create successful!");
        } else {
            response.getWriter().println("Upload failed!");
        }

        // Rest of your code
    }

    private void saveFileToServer(Part filePart, String filePath) throws IOException {
        Path destination = Paths.get(filePath);
        Files.copy(filePart.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
    }




    private void showSong(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String filterAuthor = req.getParameter("author");
//        String filterSinger = req.getParameter("singer");
//        String filterCategory = req.getParameter("category");
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
        Pageable pageable = new Pageable(search,page,TOTAL_ITEMS,nameField,sortBy);
//        pageable.setFilterAuthor(filterAuthor);
//        pageable.setFilterSinger(filterSinger);
//        pageable.setFilterCategory(filterCategory);
//
//        req.setAttribute("filterAuthor", filterAuthor);
//        req.setAttribute("filterSinger", filterSinger);
//        req.setAttribute("filterCategory", filterCategory);
        req.setAttribute("pageable", pageable);
        req.setAttribute("songs", songService.findAll(pageable));
        req.getRequestDispatcher("/admin.jsp").forward(req,resp);


    }
    public void deleteSong(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        songService.deleteSong(id);
        showSong(request,response);
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
            case "edit":
                editSong(req,resp);
                break;
            default:
                showSong(req,resp);
        }
    }
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "/");
            }
        }
        return null;
    }

}
