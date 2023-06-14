package service;

import dao.SongDAO;
import model.Song;

import java.util.List;


public class SongService {
    SongDAO songDAO = new SongDAO();

    public List<Song> findAll(){
        return songDAO.findAll();
    }
    public Song findByID(int id){
        return songDAO.findById(id);

    }

    public void createSong(Song song){
        songDAO.createSong(song);
    }
    public void editSong(Song song){
        songDAO.editSong(song);
    }
    public void deleteSong(int id){
        songDAO.deleteBook(id);
    }
}
