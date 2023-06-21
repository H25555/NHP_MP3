package dao;

import model.History;
import model.Song;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class HistoryDAO extends ConnectionDatabase{
    private final String FIND_SONG_HISTORY ="SELECT count(*) FROM history where id_song = ? ;";
    private final String CREATE_HISTORY = "INSERT INTO history (`id_user`, `id_song`) VALUES (?, ?);";
//    private final String DELETE_HISTORY = "DELETE  FROM history WHERE (`id` = ?);";
    public int countSongHistory(int idsong){
        int views = 0;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(FIND_SONG_HISTORY)) {
            preparedStatement.setInt(1, idsong);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                views = rs.getInt("count(*)");
            }
    } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return views;
    }
    public void createViewHistory(History history){
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CREATE_HISTORY)) {
            preparedStatement.setInt(1, history.getUser().getId());
            preparedStatement.setInt(2, history.getSong().getId());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
