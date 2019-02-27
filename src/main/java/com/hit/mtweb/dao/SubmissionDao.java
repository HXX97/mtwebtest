package com.hit.mtweb.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("submissionDao")
public class SubmissionDao {

    @Autowired
    JdbcTemplate jdbcTemplate;


}
