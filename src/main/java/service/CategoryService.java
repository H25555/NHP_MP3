package service;

import dao.CategoryDAO;
import model.Category;

import java.util.List;

public class CategoryService {
    CategoryDAO categoryDAO = new CategoryDAO();

    public List<Category> findAll(){
        return categoryDAO.findAll();
    }
    public Category findByID(int id){
        return categoryDAO.findById(id);
    }
}
