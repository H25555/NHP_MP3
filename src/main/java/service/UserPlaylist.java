package service;

import dao.UserDAO;
import dto.Pageable;
import model.User;

import java.util.List;

public class UserPlaylist {
    UserDAO userDAO = new UserDAO();
    public List<User> findAll(Pageable pageable){
        return userDAO.findAll(pageable);
    }
    public User findById(int id){
        return userDAO.findById(id);
    }
}
