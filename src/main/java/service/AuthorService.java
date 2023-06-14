package service;

import dao.AuthorDAO;
import model.Author;

import java.util.List;

public class AuthorService {
    AuthorDAO authorDAO = new AuthorDAO();

    public List<Author> findAll(){
        return authorDAO.findAll();
    }
    public Author findByID(int id){
        return authorDAO.findById(id);
    }
}
