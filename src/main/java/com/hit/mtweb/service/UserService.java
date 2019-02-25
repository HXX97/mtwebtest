package com.hit.mtweb.service;

import com.hit.mtweb.dao.UserDao;
import com.hit.mtweb.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userService")
public class UserService {
    @Autowired
    UserDao userDao;

    public User getUserByName(String username) {
        return userDao.getUserByName(username);
    }

    public List<User> getAllUsers(){
        return userDao.getAllUsers();
    }

    public boolean validateUserByPWD(String username,String password){
        return userDao.validateUserPWD(username,password);
    }

    public boolean saveUser(User user){
        return userDao.saveUser(user);
    }


    public boolean updateInfo(User newUserInfo) {
        return userDao.updateInfo(newUserInfo);
    }
}
