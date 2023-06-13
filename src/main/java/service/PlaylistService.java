package service;

import dao.PlaylistDAO;
import model.Playlist;

public class PlaylistService {
    PlaylistDAO playlistDAO = new PlaylistDAO();
    public void createPlaylist(Playlist playlist){
        playlistDAO.createPlaylist(playlist);
    }

}
