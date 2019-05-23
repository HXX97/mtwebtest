package com.hit.mtweb.dao;

import com.hit.mtweb.domain.Submission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.*;

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
                "ICT," +
                "submitter," +
                "isConstraint," +
                "state,"+
                "affiliation) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

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
                submission.getICT(),
                submission.getSubmitter(),
                submission.getIsConstraint(),
                submission.getState(),
                submission.getAffiliation());

    }


    public void updateSubmissionBySub(Submission submission){

        String sql = "update submissions set " +
                "BLEU_SBP=?," +
                "BLEU_NIST=?," +
                "TER=?," +
                "METEOR=?," +
                "NIST=?," +
                "GTM=?," +
                "mWER=?," +
                "mPER=?," +
                "ICT=?," +
                "state=? where systemid=? and time=?";

        //System.out.println(sql);

        jdbcTemplate.update(sql,submission.getBLEU_SBP(),
                submission.getBLEU_NIST(),
                submission.getTER(),
                submission.getMETEOR(),
                submission.getNIST(),
                submission.getGTM(),
                submission.getMWER(),
                submission.getMPER(),
                submission.getICT(),
                submission.getState(),
                submission.getSystemid(),
                submission.getTime());
    }


    public List<Submission> queryBySysId(String systemid) {
        List<Submission> submissionList = new ArrayList<>();
        String sql = "select * from submissions where systemid = ? order by time desc";
        for (Map map : jdbcTemplate.queryForList(sql, systemid)) {
            submissionList.add(Submission.mapToSubmission(map));
        }
        return submissionList;
    }

    public List<Submission> queryByTrack(String track) {
        List<Submission> submissionList = new ArrayList<>();
        String sql = "select * from submissions where track = ? order by time desc";
        for (Map map : jdbcTemplate.queryForList(sql, track)) {
            submissionList.add(Submission.mapToSubmission(map));
        }
        return submissionList;
    }

    public boolean deleteBySysId(String systemid) {

        String sql = "delete from submissions where systemid = ?";
        try {
            jdbcTemplate.update(sql, systemid);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public List<Submission> queryByOwnerNTrack(String username, String track) {
        List<Submission> submissionList = new ArrayList<>();
        String sql = "select * from submissions where submitter = ? and track = ? order by time desc";
        for (Map map : jdbcTemplate.queryForList(sql, username, track)) {
            submissionList.add(Submission.mapToSubmission(map));
        }
        return submissionList;
    }

    public List<Submission> queryByTrackSortMetric(String track, String metric) {
        List<Submission> submissionList = new ArrayList<>();

        //根据metric降序，每个systemid只根据该metric取最高分


        //先取到所有的systemid
        Set<String> systemidSet = new HashSet<>();

        String sql = "select distinct systemid from submissions where track = ? and state= ?";
        List<Map<String, Object>> systemIdmaps = jdbcTemplate.queryForList(sql, track,"success");
        for (Map m : systemIdmaps) {
            systemidSet.add(String.valueOf(m.get("systemid")));
        }

        //取到每个id的最好成绩,加入到List中
        sql = "select * from submissions where systemid = ? and track = ? and state= ? order by ifnull(cast(" + metric + " as decimal(10,4)),0) desc,time desc limit 1";
        for (String systemid : systemidSet) {
            List<Map<String, Object>> maps = jdbcTemplate.queryForList(sql, Integer.valueOf(systemid), track,"success");
            for (Map map : maps) {
                submissionList.add(Submission.mapToSubmission(map));
            }
        }

        //将结果list排序
        Collections.sort(submissionList, new Comparator<Submission>() {
            @Override
            public int compare(Submission o1, Submission o2) {

                Double diff = Double.valueOf(o2.getBLEU_SBP())-Double.valueOf(o1.getBLEU_SBP());
                if(diff.equals(0.0)) return 0;
                else return diff<0.0?-1:1;

            }
        });

        return submissionList;
    }
}
