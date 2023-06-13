package service;

import dao.SongDAO;
import model.Song;

import java.util.List;

public class SongService implements BaseCRUDService<Song>{
    SongDAO songDAO = new SongDAO();
    @Override
    public void create(Song song) {
        songDAO.insertSong(song);
    }

    @Override
    public void edit(Song song) {

    }

    @Override
    public Song delete(int id) {
        return null;
    }

    @Override
    public List<Song> findAll() {
        return songDAO.findAll();
    }

    @Override
    public Song findById(int id) {
        return null;
    }
}
