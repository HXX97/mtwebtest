package com.hit.mtweb.dao;

import com.hit.mtweb.domain.Submission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("submissionDao")
public class SubmissionDao {

    @Autowired
    JdbcTemplate jdbcTemplate;


    public void saveSubmission(Submission submission) {
        String sql = "insert into submissions(" +
                "systemid," +
                "systemname," +
                "testsetid," +
                "testset," +
                "file," +
                "notes," +
                "BLEU," +
                "BLEU_cased," +
                "IGNORE_BLEU," +
                "IGNORE_BLEU_cased," +
                "IGNORE_BLEU_cased_norm," +
                "TER," +
                "BEER," +
                "charac_ter," +
                "time," +
                "srclang," +
                "tgtlang," +
                "track," +
                "BLEU_SBP," +
                "BLEU_NIST," +
                "METEOR," +
                "NIST," +
                "GTM," +
                "mWER," +
                "mPER," +
                "ICT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        jdbcTemplate.update(sql,
                submission.getSystemid(),
                submission.getSystemName(),
                submission.getTestsetid(),
                submission.getTestset(),
                submission.getFile(),
                submission.getNotes(),
                submission.getBLEU(),
                submission.getBLEU_cased(),
                submission.getIGNORE_BLEU(),
                submission.getIGNORE_BLEU_cased(),
                submission.getIGNORE_BLEU_cased_norm(),
                submission.getTER(),
                submission.getBEER(),
                submission.getCharac_ter(),
                submission.getTime(),
                submission.getSrclang(),
                submission.getTgtlang(),
                submission.getTrack(),
                submission.getBLEU_SBP(),
                submission.getBLEU_NIST(),
                submission.getMETEOR(),
                submission.getNIST(),
                submission.getGTM(),
                submission.getMWER(),
                submission.getMPER(),
                submission.getICT());

    }

    public List<Submission> queryBySysId(String systemid) {
        List<Submission> submissionList = new ArrayList<>();
        String sql = "select * from submissions where systemid = ?";
        for (Map map : jdbcTemplate.queryForList(sql, systemid)) {
            submissionList.add(Submission.mapToSubmission(map));
        }
        return submissionList;
    }

    public List<Submission> queryByTrack(String track) {
        List<Submission> submissionList = new ArrayList<>();
        String sql = "select * from submissions where track = ?";
        for (Map map : jdbcTemplate.queryForList(sql, track)) {
            submissionList.add(Submission.mapToSubmission(map));
        }
        return submissionList;
    }

    public boolean deleteBySysId(String systemid) {

        String sql = "delete from submissions where systemid = ?";
        try {
            jdbcTemplate.update(sql, systemid);
        } catch (DataAccessException e){
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
