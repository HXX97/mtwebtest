package com.hit.mtweb.service;

import com.hit.mtweb.dao.SubmissionDao;
import com.hit.mtweb.dao.SystemDao;
import com.hit.mtweb.domain.MTSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SystemService {

    @Autowired
    SystemDao systemDao;

    @Autowired
    SubmissionDao submissionDao;

    public boolean saveNewSystem(MTSystem system) {
        return systemDao.saveNewSystem(system);
    }

    public List<MTSystem> queryByOwner(String username) {
        return systemDao.queryByOwner(username);
    }

    public MTSystem queryById(String systemid) {
        return systemDao.queryById(systemid);
    }

    public boolean deleteById(String systemid) {


        return submissionDao.deleteBySysId(systemid)&&systemDao.deleteById(systemid);
    }

    public boolean updateById(MTSystem mtSystem) {
        return systemDao.updateById(mtSystem);
    }
}
