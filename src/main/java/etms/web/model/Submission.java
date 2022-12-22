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
     * @param problem 题目
     * @param user 用户
     * @param submitTime 提交时间
     * @param judgeScore 得分
     * @param submissionContext 提交内容
     */
    public Submission(Problem problem, User user, Date submitTime, int judgeScore, String submissionContext)
    {
        this.problem = problem;
        this.user = user;
        this.submitTime = submitTime;
        this.judgeScore = judgeScore;
        this.submissionContext = submissionContext;
    }

    /**
     * 提交信息类构造函数
     * @param submissionId 提交信息唯一标识符
     * @param problem 题目
     * @param user 用户
     * @param submitTime 提交时间
     * @param judgeScore 得分
     * @param submissionContext 提交内容
     */
    public Submission(long submissionId, Problem problem, User user, Date submitTime, int judgeScore, String submissionContext)
    {
        this.submissionId = submissionId;
        this.problem = problem;
        this.user = user;
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
    public Problem getProblem()
    {
        return problem;
    }

    /**
     * 设置题目唯一标识符
     * @param problem 题目
     */
    public void setProblem(Problem problem)
    {
        this.problem = problem;
    }

    /**
     * 获取用户唯一标识符
     * @return 用户唯一标识符
     */
    public User getUser()
    {
        return user;
    }

    /**
     * 设置用户唯一标识符
     * @param user 用户
     */
    public void setUser(User user)
    {
        this.user = user;
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
     * 获取提交题目唯一标识符
     * @return 提交题目唯一标识符
     */
    public long getProblemId()
    {
        return this.problem.getProblemId();
    }
    /**
     * 提交信息唯一标识符
     */


    private long submissionId;
    /**
     * 题目唯一标识符
     */
    private Problem problem;
    /**
     * 用户唯一标识符
     */
    private User user;
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
