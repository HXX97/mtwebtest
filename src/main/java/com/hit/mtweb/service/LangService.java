package com.hit.mtweb.service;

import com.hit.mtweb.dao.LangDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LangService {

    @Autowired
    LangDao langDao;

    public String queryFullByAbbr(String srcLangAbbr) {
        return langDao.queryFullByAbbr(srcLangAbbr);
    }
}
