package com.hit.mtweb.dao;

import com.hit.mtweb.domain.User;
import com.hit.mtweb.utils.RowMappers.UserRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("userDao")
public class UserDao {
    @Autowired
    JdbcTemplate jdbcTemplate;

    public List<User> getAllUsers() {
        List<User> resultList = new ArrayList<>();
        String sql = "select * from users";
        for (Map map : jdbcTemplate.queryForList(sql)) {
            resultList.add(User.mapToUser(map));
        }
        ;
        return resultList;
    }

    public Boolean validateUserPWD(String username, String password) {
        String sql = "select * from users where username = ? and password = ?";
        if (jdbcTemplate.queryForList(sql, username, password).isEmpty()) {
            return false;
        } else {
            return true;
        }
    }

    public boolean saveUser(User user) {
        String sql = "insert into users values(?,?,?,?,?,?)";

        try {
            jdbcTemplate.update(sql,
                    user.getUsername(),
                    user.getEmail(),
                    user.getAffiliation(),
                    user.getWeb(),
                    user.getPassword(),
                    user.getPhone());
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public User getUserByName(String username) {
        String sql = "select * from users where username = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new UserRowMapper(), username);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public boolean updateInfo(User newUserInfo) {
        String sql = "update users set email=? , web = ? , affiliation = ? where username = ?";
        try {
            jdbcTemplate.update(sql, newUserInfo.getEmail(),
                    newUserInfo.getWeb(),
                    newUserInfo.getAffiliation(),
                    newUserInfo.getUsername());

            sql = "update submissions set affiliation = ? where submitter = ?";

            jdbcTemplate.update(sql,newUserInfo.getAffiliation(),newUserInfo.getUsername());
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean updatePWD(String username,String newP) {
        try{
            String sql = "update users set password=? where username= ?";
            jdbcTemplate.update(sql,newP,username);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
