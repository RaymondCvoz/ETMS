package etms.web.model;

import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class Submission
{
    /**
     * 提交信息默认构造函数
     */
    public Submission()
    {
    }

    /**
     * 提交信息构造函数
     * @param problemId 题目唯一标识符
     * @param uid 用户唯一标识符
     * @param submitTime 提交时间
     * @param judgeScore 得分
     * @param submissionContext 提交内容
     */
    public Submission(long problemId, long uid, Date submitTime, int judgeScore, String submissionContext)
    {
        this.problemId = problemId;
        this.uid = uid;
        this.submitTime = submitTime;
        this.judgeScore = judgeScore;
        this.submissionContext = submissionContext;
    }

    /**
     * 提交信息类构造函数
     * @param submissionId 提交信息唯一标识符
     * @param problemId 题目唯一标识符
     * @param uid 用户唯一标识符
     * @param submitTime 提交时间
     * @param judgeScore 得分
     * @param submissionContext 提交内容
     */
    public Submission(long submissionId, long problemId, long uid, Date submitTime, int judgeScore, String submissionContext)
    {
        this.submissionId = submissionId;
        this.problemId = problemId;
        this.uid = uid;
        this.submitTime = submitTime;
        this.judgeScore = judgeScore;
        this.submissionContext = submissionContext;
    }

    /**
     * 获取提交信息唯一标识符
     * @return 提交信息唯一标识符
     */
    public long getSubmissionId()
    {
        return submissionId;
    }

    /**
     * 设置提交信息唯一标识符
     * @param submissionId 提交信息唯一标识符
     */
    public void setSubmissionId(long submissionId)
    {
        this.submissionId = submissionId;
    }

    /**
     * 获取题目唯一标识符
     * @return 题目唯一标识符
     */
    public long getProblemId()
    {
        return problemId;
    }

    /**
     * 设置题目唯一标识符
     * @param problemId 题目唯一标识符
     */
    public void setProblemId(long problemId)
    {
        this.problemId = problemId;
    }

    /**
     * 获取用户唯一标识符
     * @return 用户唯一标识符
     */
    public long getUid()
    {
        return uid;
    }

    /**
     * 设置用户唯一标识符
     * @param uid 用户唯一标识符
     */
    public void setUid(long uid)
    {
        this.uid = uid;
    }

    /**
     * 获取提交时间
     * @return 提交时间
     */
    public Date getSubmitTime()
    {
        return submitTime;
    }

    /**
     * 设置提交时间
     * @param submitTime 提交时间
     */
    public void setSubmitTime(Date submitTime)
    {
        this.submitTime = submitTime;
    }

    /**
     * 获取得分
     * @return 得分
     */
    public int getJudgeScore()
    {
        return judgeScore;
    }

    /**
     * 设置得分
     * @param judgeScore 得分
     */
    public void setJudgeScore(int judgeScore)
    {
        this.judgeScore = judgeScore;
    }

    /**
     * 获取提交内容
     * @return 提交内容
     */
    public String getSubmissionContext()
    {
        return submissionContext;
    }

    /**
     * 设置提交内容
     * @param submissionContext 提交内容
     */
    public void setSubmissionContext(String submissionContext)
    {
        this.submissionContext = submissionContext;
    }

    /**
     * 提交信息唯一标识符
     */
    private long submissionId;
    /**
     * 题目唯一标识符
     */
    private long problemId;
    /**
     * 用户唯一标识符
     */
    private long uid;
    /**
     * 提交时间
     */
    private Date submitTime;
    /**
     * 得分
     */
    private int judgeScore;
    /**
     * 提交内容
     */
    private String submissionContext;
}
