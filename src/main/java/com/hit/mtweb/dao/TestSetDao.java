package com.hit.mtweb.dao;

import com.hit.mtweb.domain.TestSet;
import com.hit.mtweb.utils.RowMappers.TestSetRowMapper;
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
        String sql = "select * from testsets  order by isPrimarySet DESC";
        for (Map map : jdbcTemplate.queryForList(sql)) {
            testSetList.add(TestSet.mapToTestSet(map));
        }
        return testSetList;
    }

    public TestSet querySetById(String setId) {
        String sql = "select * from testsets where testsetid = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new TestSetRowMapper(), setId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TestSet queryByTrack(String track) {
        String sql = "select * from testsets where track = ? and isPrimarySet = 1";
        try{
            return jdbcTemplate.queryForObject(sql,new TestSetRowMapper(),track);
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }


    }

    public List<TestSet> getNotPrimaryTestSets() {
        String sql = "select * from testsets where isPrimarySet = 0";
        List<TestSet> testSetList = new ArrayList<>();
        for (Map map : jdbcTemplate.queryForList(sql)) {
            testSetList.add(TestSet.mapToTestSet(map));
        }
        return testSetList;
    }
}
