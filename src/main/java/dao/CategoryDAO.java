package dao;

import model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO extends  ConnectionDatabase{
    private final String SELECT_USER = "SELECT * FROM category;";
    private final String SELECT_USER_BY_ID = "SELECT * FROM category where id = ?;";

    public List<Category> findAll(){
        List<Category> categorys = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection
                     .prepareStatement(SELECT_USER)) {
            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int id = rs.getInt("id");
                String name = rs.getString("name");
                categorys.add(new Category(id, name));
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return categorys;
    }
    public Category findById(int id) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection
                     .prepareStatement(SELECT_USER_BY_ID);) {
            System.out.println(preparedStatement);
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idCus = rs.getInt("id");
                String name = rs.getString("name");
                return new Category(idCus, name);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
}
