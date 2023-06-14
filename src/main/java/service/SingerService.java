package service;

import dao.SingerDAO;
import model.Singer;

import java.util.List;

public class SingerService {
    SingerDAO singerDAO = new SingerDAO();

    public List<Singer> findAll(){
        return singerDAO.findAll();
    }
    public Singer findByID(int id){
        return singerDAO.findById(id);
    }
}
