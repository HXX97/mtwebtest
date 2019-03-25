package com.hit.mtweb.utils.RowMappers;

import com.hit.mtweb.domain.User;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRowMapper implements RowMapper<User> {
    @Override
    public User mapRow(ResultSet resultSet, int i) throws SQLException {
        User user = new User();
        user.setUsername(resultSet.getString("username"));
        user.setWeb(resultSet.getString("web"));
        user.setEmail(resultSet.getString("email"));
        user.setAffiliation(resultSet.getString("affiliation"));
        return user;
    }
}
