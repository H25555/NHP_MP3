package dao;
import model.Author;
import model.Category;
import model.Singer;
import model.Song;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SongDAO extends ConnectionDatabase {
    private final String SELECT_USER = "SELECT s.*, a.`name` as name_author , c.`name` as type, sg.`name` as name_singer  FROM song s \n" +
            "LEFT JOIN author a ON s.id_author = a.id\n" +
            "LEFT JOIN category c ON s.id_category = c.id\n" +
            "LEFT JOIN singer sg ON s.id_singer = sg.id";
    private final String SELECT_USER_BY_ID = "SELECT s.*, a.`name` as name_author , c.`name` as type, sg.`name` as name_singer  FROM song s \n" +
            "LEFT JOIN author a ON s.id_author = a.id\n" +
            "LEFT JOIN category c ON s.id_category = c.id\n" +
            "LEFT JOIN singer sg ON s.id_singer = sg.id where s.id = ?;";
    private final String CREAT_USER = "INSERT INTO `song` (`name`, `id_author`, `id_category`, `id_singer`, `link_song`, `link_image`) VALUES (?, ?,?, ?, ?, ?);";
    private final String EDIT_USER = "UPDATE `song` SET `name` = ?, `id_author` = ?, `id_category` = ?, `id_singer` = ?, `link_song` = ?, `link_image` = ? WHERE (`id` = ?);";
    private final String DELETE_USER = "DELETE FROM `song` WHERE (`id` = ?);";

    public List<Song> findAll() {
        List<Song> songs = new ArrayList<>();
        // Step 1: tạo 1 kết nối xuống db để gọi câu lệnh SELECT or UPDATE, Delete, vv
        try (Connection connection = getConnection();

             // Step 2: truyền câu lênh mình muốn chạy nằm ở trong này (SELECT_USERS)
             PreparedStatement preparedStatement = connection
                     .prepareStatement(SELECT_USER)) {
            System.out.println(preparedStatement);
            // Step 3: tương đương vowis cái sét
            ResultSet rs = preparedStatement.executeQuery();

            // Step 4:
            //kiểm tra còn data hay không. còn thì cứ lấy bằng câu lệnh ở dưới
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("link_image");
                String song = rs.getString("link_song");
                int authorID = rs.getInt("id_author");
                String author = rs.getString("name_author");
                Author authors = new Author(authorID,author);
                int categoryID = rs.getInt("id_category");
                String type = rs.getString("type");
                Category category = new Category(categoryID,type);
                int singerID = rs.getInt("id_singer");
                String singers = rs.getString("name_singer");
                Singer singer = new Singer(singerID,singers);
                songs.add(new Song(id,name,authors,category,singer,song,image));

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return songs;
    }


    public Song findById(int id) {
        try (Connection connection = getConnection();

             // Step 2: truyền câu lênh mình muốn chạy nằm ở trong này (SELECT_USERS)
             PreparedStatement preparedStatement = connection
                     .prepareStatement(SELECT_USER_BY_ID);) {
            System.out.println(preparedStatement);
            preparedStatement.setInt(1, id);

            // Step 3: tương đương vowis cái sét
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int idSong = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("link_image");
                String song = rs.getString("link_song");
                int authorID = rs.getInt("id_author");
                String author = rs.getString("name_author");
                Author authors = new Author(authorID,author);
                int categoryID = rs.getInt("id_category");
                String type = rs.getString("type");
                Category category = new Category(categoryID,type);
                int singerID = rs.getInt("id_singer");
                String singers = rs.getString("name_singer");
                Singer singer = new Singer(singerID,singers);
                return new Song(idSong, name, song,image,authors,category,singer);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    public void createSong(Song song) {

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CREAT_USER)) {
            preparedStatement.setString(1, song.getName());
            preparedStatement.setInt(2,song.getAuthor().getId());
            preparedStatement.setInt(3,song.getCategory().getId());
            preparedStatement.setInt(4,song.getSinger().getId());
            preparedStatement.setString(5,song.getSong());
            preparedStatement.setString(6,song.getImage());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public void editSong(Song song){
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(EDIT_USER)) {
            preparedStatement.setString(1, song.getName());
            preparedStatement.setInt(2,song.getAuthor().getId());
            preparedStatement.setInt(3,song.getCategory().getId());
            preparedStatement.setInt(4,song.getSinger().getId());
            preparedStatement.setString(5,song.getSong());
            preparedStatement.setString(6,song.getImage());
            preparedStatement.setInt(7,song.getId());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public void deleteBook(int id) {

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER)) {
            preparedStatement.setInt(1, id);
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
