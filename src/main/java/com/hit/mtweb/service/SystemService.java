package com.hit.mtweb.service;

import com.hit.mtweb.dao.SystemDao;
import com.hit.mtweb.domain.MTSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SystemService {

   @Autowired
   SystemDao systemDao;

    public boolean saveNewSystem(MTSystem system) {
        return systemDao.saveNewSystem(system);
    }

    public List<MTSystem> queryByOwner(String username) {
        return systemDao.queryByOwner(username);
    }
}
