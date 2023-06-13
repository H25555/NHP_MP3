package dao;

import dto.Pageable;
import model.Role;
import model.User;
import service.RoleService;

import java.util.ArrayList;
import java.util.List;

import java.sql.*;

public class UserDAO extends ConnectionDatabase {
    private final String CHECK_LOGIN = "SELECT * FROM nhp_mp3.user where user_name = ? and password = ?;";
    private final String SELECT_USERS = "SELECT user.*, role.`name` as role_name " +
            "FROM user LEFT JOIN role " +
            "ON user.role = role.id WHERE\n" +
            "    lower(user.`name`) LIKE ? OR lower(user.password) LIKE ? \n" +
            "        OR lower(role.`name`) LIKE ? ORDER BY ? ?  LIMIT ? OFFSET ? ;";
    private final String SELECT_USERS_BY_ID = "SELECT user.*, role.`name` as role_name " +
            "FROM user LEFT JOIN role " +
            "ON user.id_role = " +
            "role.id where user.id = ?;";

    private final String INSERT_USER = "INSERT INTO `user` (`name`, `password`, `role`) " +
            "VALUES (?, ?, ?);";

    private final String UPDATE_USER = "UPDATE `user` " +
            "SET `name` = ?, `password` = ?, role = ? WHERE (`id` = ?);";

    private final String DELETE_USER = "DELETE FROM `user` WHERE (`id` = ?);";
    private String SELECT_ALL_USERS = "SELECT \n" +
            "    user.*, role.`name` as role_name \n" +
            "FROM\n" +
            "    user\n" +
            "        LEFT JOIN\n" +
            "    role ON users.id_role = role.id\n" +
            "WHERE\n" +
            "    lower(user.`name`) LIKE '%s' OR lower(user.password) LIKE '%s' \n" +
            "        OR lower(role.`name`) LIKE '%s' order by %s %s LIMIT %d OFFSET %d  ;\n";


    private final String TOTAL_USERS = "SELECT \n" +
            "    COUNT(1) as total \n" +
            "FROM\n" +
            "    user\n" +
            "        LEFT JOIN\n" +
            "    role ON user.role = role.id\n" +
            "WHERE\n" +
            "    lower(user.`name`) LIKE ? OR lower(user.password) LIKE ?\n" +
            "        OR lower(role.`name`) LIKE ? ;";
    RoleService roleService = new RoleService();
    public List<User> findAll(Pageable pageable) {
        List<User> users = new ArrayList<>();
        String search = pageable.getSearch();
        if(search == null){
            search = "";
        }
        search = "%" + search + "%";
        // Step 1: tạo 1 kết nối xuống db để gọi câu lệnh SELECT or UPDATE, Delete, vv
        try (Connection connection = getConnection();

             // Step 2: truyền câu lênh mình muốn chạy nằm ở trong này (SELECT_USERS)
             PreparedStatement preparedStatement = connection
                     .prepareStatement(String
                             .format(SELECT_ALL_USERS, search, search, search,
                                     pageable.getNameField(), pageable.getSortBy(),
                                     pageable.getTotalItems(),(pageable.getPage() - 1) * pageable.getTotalItems()))) {
            System.out.println(preparedStatement);
//            preparedStatement.setString(1, search);
//            preparedStatement.setString(2, search);
//            preparedStatement.setString(3, search);
//            preparedStatement.setInt(6, pageable.getTotalItems());
//            preparedStatement.setInt(7, (pageable.getPage() - 1) * pageable.getTotalItems());
//            preparedStatement.setString(4, pageable.getNameField());
//            preparedStatement.setString(5, pageable.getSortBy());

            // Step 3: tương đương vowis cái sét
            ResultSet rs = preparedStatement.executeQuery();


            // Step 4:
            //kiểm tra còn data hay không. còn thì cứ lấy bằng câu lệnh ở dưới
            while (rs.next()) {
                //(truyên vào tên cột)
                int id = rs.getInt("id");
                //(truyên vào tên cột)
                String name = rs.getString("name");
                //(truyên vào tên cột)
                String password = rs.getString("password");
                String roleName = rs.getString("role_name");
                int roleId = rs.getInt("id_role");
                users.add(new User(id, name, password, new Role(roleId, roleName)));
            }

            // cụm lấy tổng số trang
            PreparedStatement statementTotalUsers =connection.prepareStatement(TOTAL_USERS);
            statementTotalUsers.setString(1, search);
            statementTotalUsers.setString(2, search);
            statementTotalUsers.setString(3, search);
            ResultSet rsTotalUser = statementTotalUsers.executeQuery();
            while (rsTotalUser.next()){
                double totalUsers = rsTotalUser.getDouble("total");
                double totalItems = Double.parseDouble(pageable.getTotalItems() + "");
                int totalPages = (int)
                        Math.ceil(totalUsers/totalItems);
                pageable.setTotalPage(totalPages);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return users;
    }
    public User findById(int id) {
        try (Connection connection = getConnection();

             // Step 2: truyền câu lênh mình muốn chạy nằm ở trong này (SELECT_USERS)
             PreparedStatement preparedStatement = connection
                     .prepareStatement(SELECT_USERS_BY_ID);) {
            System.out.println(preparedStatement);
            preparedStatement.setInt(1, id);

            // Step 3: tương đương vowis cái sét
            ResultSet rs = preparedStatement.executeQuery();

            // Step 4:
            //kiểm tra còn data hay không. còn thì cứ lấy bằng câu lệnh ở dưới
            while (rs.next()) {
                //(truyên vào tên cột)
                int idCus = rs.getInt("id");
                //(truyên vào tên cột)
                String name = rs.getString("name");
                //(truyên vào tên cột)
                String email = rs.getString("email");
                String roleName = rs.getString("role_name");
                int roleId = rs.getInt("id_role");
                return new User(idCus, name, email, new Role(roleId, roleName));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    public void updateUser(User user){
        try (Connection connection = getConnection();
             //UPDATE `users` " +
             //            "SET `name` = ?, `email` = ?, role_id = ? WHERE (`id` = ?);";
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setInt(3, user.getRole().getId());
            preparedStatement.setInt(4, user.getId());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public void deleteUser(int id) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER)) {
            preparedStatement.setInt(1, id);
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public User login(String username, String password){
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CHECK_LOGIN)) {
            System.out.println(preparedStatement);
            preparedStatement.setString(1,username);
            preparedStatement.setString(2,password);
            // Step 3: tương đương vowis cái sét
            ResultSet rs = preparedStatement.executeQuery();

            // Step 4:
            //kiểm tra còn data hay không. còn thì cứ lấy bằng câu lệnh ở dưới\
            while(rs.next()){
                return new User(rs.getInt("id"),rs.getString("user_name"),rs.getString("password"),roleService.findById(rs.getInt("id_role")));

            }


        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
}
