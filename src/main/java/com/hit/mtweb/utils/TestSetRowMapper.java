package com.hit.mtweb.utils;

import com.hit.mtweb.domain.TestSet;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TestSetRowMapper implements RowMapper<TestSet> {
    @Override
    public TestSet mapRow(ResultSet resultSet, int i) throws SQLException {
        TestSet testSet = new TestSet();
        testSet.setTestsetid(String.valueOf(resultSet.getInt("testsetid")));
        testSet.setName(resultSet.getString("name"));
        testSet.setOrigin(resultSet.getString("origin"));
        testSet.setDomain(resultSet.getString("domain"));
        testSet.setRelated_corpora(resultSet.getString("related_corpora"));
        testSet.setCitation(resultSet.getString("citation"));
        testSet.setNotes(resultSet.getString("notes"));
        testSet.setSetups(resultSet.getString("setups"));
        testSet.setSrcurl(resultSet.getString("srcurl"));

        return testSet;
    }
}
