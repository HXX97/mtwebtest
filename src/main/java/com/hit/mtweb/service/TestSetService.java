package com.hit.mtweb.service;

import com.hit.mtweb.dao.TestSetDao;
import com.hit.mtweb.domain.TestSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TestSetService {
    @Autowired
    TestSetDao testSetDao;

    public List<TestSet> getAllTestSets() {
        return testSetDao.getAllTestSets();
    }

    public TestSet querySetById(String setId) {
        return testSetDao.querySetById(setId);
    }
}
