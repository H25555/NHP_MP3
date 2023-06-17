package dao;

import model.Like;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.*;
public class LikeDAO extends ConnectionDatabase{
    private final String COUNT_SONG_LIKE = "SELECT COUNT(*) FROM like WHERE id_song = ?";
    private final String CREATE_LIKE = "INSERT INTO `like` (`id_user`, `id_song`) VALUES (?, ?);";
    private final String DISLIKE = "DELETE  FROM like WHERE (`id` = ?);";
    public int countSongLike(int idsong){
        int likes = 0;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_SONG_LIKE)) {
            preparedStatement.setInt(1, idsong);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                likes = rs.getInt("COUNT(*)");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return likes;
    }
    public void createLike(Like like){
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CREATE_LIKE)) {
            preparedStatement.setInt(1, like.getUser().getId());
            preparedStatement.setInt(2, like.getSong().getId());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public void dislike(int id){
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DISLIKE)) {
            preparedStatement.setInt(1, id);
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
