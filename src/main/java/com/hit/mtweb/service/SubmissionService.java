package com.hit.mtweb.service;

import com.hit.mtweb.dao.SubmissionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SubmissionService {

    @Autowired
    SubmissionDao submissionDao;

}
