package com.hit.mtweb.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

@Repository("trackDao")
public class TrackDao {

    @Autowired
    JdbcTemplate jdbcTemplate;


    public String getDirection(String track){
        String sql = "select direction from tracks where track = ?";
        return jdbcTemplate.query(sql,new ResultSetExtractor<String>() {
            @Override
            public String extractData(ResultSet resultSet) throws SQLException, DataAccessException {
                if(resultSet.next()){
                    return resultSet.getString("direction");
                }
                return null;
            }
        },track);
    }


}
