package dao;

import model.Playlist;

import java.sql.*;

public class PlaylistDAO extends ConnectionDatabase {
    static String CREATE_PLAYLIST = "INSERT INTO `playlist` (`name`, `id_user`) VALUES (?, ?);";
    public void createPlaylist(Playlist playlist){
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CREATE_PLAYLIST)) {
            preparedStatement.setString(1, playlist.getName());
            preparedStatement.setInt(2, playlist.getUser().getId());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
