package dao;

import model.Like;
import model.Song;
import model.User;
import service.SongService;
import service.UserService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.*;
public class LikeDAO extends ConnectionDatabase{
    UserService userService = new UserService();
    SongService songService = new SongService();
    private final String COUNT_SONG_LIKE = "SELECT COUNT(*) FROM `like` WHERE id_song = ?";
    private final String CREATE_LIKE = "INSERT INTO `like` (`id_user`, `id_song`) VALUES (?, ?);";
    private final String DISLIKE = "DELETE  FROM `like` WHERE (`id_user` = ?);";
    private final String CHECK_LIKED = "SELECT * FROM nhp_mp3.like where id_user = ? and id_song = ?;";
    private final String SELECT_LIKE_BY_USERID = "SELECT * FROM `like` WHERE id_user = ?";
    public int countSongLike(int idsong){
        int likes = 0;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_SONG_LIKE)) {
            preparedStatement.setInt(1, idsong);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
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
    public boolean checkLiked(int idUser, int idSong){
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CHECK_LIKED)) {
            preparedStatement.setInt(1, idUser);
            preparedStatement.setInt(2, idSong);

            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int idlike = rs.getInt("id");
                int iduser = rs.getInt("id_user");
                int idsong = rs.getInt("id_song");
                User user = userService.findById(iduser);
                Song song = songService.findByID(idsong);
                Like like = new Like(idlike,user,song);
                if (like != null ){
                    return true;
                }
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
//    public Like findByUserId(int idUser){
//        try (Connection connection = getConnection();
//             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_SONG_LIKE)) {
//            preparedStatement.setInt(1, idUser);
//            ResultSet rs = preparedStatement.executeQuery();
//            while (rs.next()) {
//                int id =
//            }
//
//        } catch (SQLException e) {
//            System.out.println(e.getMessage());
//        }
//        return null;
//    }
}
