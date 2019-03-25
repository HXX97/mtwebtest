package com.hit.mtweb.utils.RowMappers;

import com.hit.mtweb.domain.MTSystem;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MTSystemRowMapper implements RowMapper<MTSystem> {

    @Override
    public MTSystem mapRow(ResultSet resultSet, int i) throws SQLException {

        MTSystem mtSystem = new MTSystem();

        mtSystem.setSystemid(resultSet.getString("systemid"));
        mtSystem.setName(resultSet.getString("name"));
        mtSystem.setSoftware(resultSet.getString("software"));
        mtSystem.setSourcelang(resultSet.getString("sourcelang"));
        mtSystem.setTargetlang(resultSet.getString("targetlang"));
        mtSystem.setCitation(resultSet.getString("citation"));
        mtSystem.setWebsite(resultSet.getString("website"));
        mtSystem.setNotes(resultSet.getString("notes"));
        mtSystem.setIsConstraint(resultSet.getBoolean("isConstraint"));
        mtSystem.setIsPrimary(resultSet.getBoolean("isPrimary"));
        mtSystem.setOwner(resultSet.getString("owner"));

        return mtSystem;
    }
}
