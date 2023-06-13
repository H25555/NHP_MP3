package dao;

import model.Song;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SongDAO {
    private String url = "jdbc:mysql://localhost:3306/nhp_mp3_db";
    private String username = "root";
    private String password = "050401";
    private final String SELECT_SONG = "SELECT song.* FROM song";
    private final String INSERT_SONG = "INSERT INTO song(name, link_song) VALUES (?, ?)";
    protected Connection getConnection() {
        Connection connection = null;
        try {
            java.lang.Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
    public void insertSong(Song song) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SONG)) {
            preparedStatement.setString(1, song.getName());
            preparedStatement.setString(2, song.getSong());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public List<Song> findAll() {
        List<Song> songs = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection
                     .prepareStatement(SELECT_SONG);) {
            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String song = rs.getString("link_song");

                songs.add(new Song(id, name, song));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return songs;
    }

}
