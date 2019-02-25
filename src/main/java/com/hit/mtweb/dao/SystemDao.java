package com.hit.mtweb.dao;

import com.hit.mtweb.domain.MTSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("systemDao")
public class SystemDao {

    @Autowired
    JdbcTemplate jdbcTemplate;
    public boolean saveNewSystem(MTSystem system) {
        String sql = "insert into systems(name,software,sourcelang," +
                "targetlang,citation,website," +
                "notes,isConstraint,isPrimary,owner) " +
                "values(?,?,?,?,?,?,?,?,?,?)";

        try {
            jdbcTemplate.update(sql, system.getName(), system.getSoftware(), system.getSourcelang(),
                    system.getTargetlang(), system.getCitation(), system.getWebsite(),
                    system.getNotes(), system.getIsConstraint(), system.getIsPrimary(), system.getOwner());
        }catch (DataAccessException e){
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public List<MTSystem> queryByOwner(String username) {
        String sql = "select * from systems where owner = ?";
        List<MTSystem> systemList = new ArrayList<>();
        for(Map map:jdbcTemplate.queryForList(sql, username)) {
            systemList.add(MTSystem.mapToMTSystem(map));
        }
        return systemList;
    }
}
