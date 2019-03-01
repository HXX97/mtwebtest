package com.hit.mtweb.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

@Repository("langdao")
public class LangDao {
    @Autowired
    JdbcTemplate jdbcTemplate;

    public String queryFullByAbbr(String srcLangAbbr) {
        String sql = "select * from langmap where abbr = ?";
        return jdbcTemplate.query(sql, new ResultSetExtractor<String>() {
            @Override
            public String extractData(ResultSet resultSet) throws DataAccessException, SQLException {
                if(resultSet.next()) {
                    return resultSet.getString("full");
                }else{
                    return null;
                }
            }
        }, srcLangAbbr);
    }
}
