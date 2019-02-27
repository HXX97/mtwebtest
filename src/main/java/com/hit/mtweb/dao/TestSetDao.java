package com.hit.mtweb.dao;

import com.hit.mtweb.domain.TestSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("testSetDao")
public class TestSetDao {
    @Autowired
    JdbcTemplate jdbcTemplate;

    public List<TestSet> getAllTestSets() {
        List<TestSet> testSetList = new ArrayList<>();
        String sql = "select * from testsets";
        for(Map map:jdbcTemplate.queryForList(sql)) {
            testSetList.add(TestSet.mapToTestSet(map));
        }
        return testSetList;
    }
}
