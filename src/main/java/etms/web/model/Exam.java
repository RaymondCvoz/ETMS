package etms.web.model;

import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class Exam
{
    /**
     * 考试默认构造函数
     */
    public Exam()
    {
    }

    /**
     * 考试构造函数
     * @param examName 考试名称
     * @param examNotes 考试备注
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @param examMode 考试类型
     * @param examProblems 考试包含题目
     */
    public Exam(String examName, String examNotes, Date startTime, Date endTime, String examMode, String examProblems)
    {
        this.examName = examName;
        this.examNotes = examNotes;
        this.startTime = startTime;
        this.endTime = endTime;
        this.examMode = examMode;
        this.examProblems = examProblems;
    }

    /**
     * 考试类构造函数
     * @param examId        考试唯一标识符
     * @param examName      考试名称
     * @param examNotes     考试备注
     * @param startTime     开始时间
     * @param endTime       结束时间
     * @param examMode      考试类型
     * @param examProblems  考试包含的题目
     */
    public Exam(long examId, String examName, String examNotes, Date startTime, Date endTime, String examMode, String examProblems)
    {
        this.examId = examId;
        this.examName = examName;
        this.examNotes = examNotes;
        this.startTime = startTime;
        this.endTime = endTime;
        this.examMode = examMode;
        this.examProblems = examProblems;
    }

    /**
     * 获取考试唯一标识符
     * @return 考试唯一标识符
     */
    public long getExamId()
    {
        return examId;
    }

    /**
     * 设置考试唯一标识符
     * @param examId 考试唯一标识符
     */
    public void setExamId(long examId)
    {
        this.examId = examId;
    }

    /**
     * 获取考试名称
     * @return 考试名称
     */
    public String getExamName()
    {
        return examName;
    }

    /**
     * 设置考试名称
     * @param examName 考试名称
     */
    public void setExamName(String examName)
    {
        this.examName = examName;
    }

    /**
     * 获取考试备注
     * @return 考试备注
     */
    public String getExamNotes()
    {
        return examNotes;
    }

    /**
     * 设置考试备注
     * @param examNotes 考试备注
     */
    public void setExamNotes(String examNotes)
    {
        this.examNotes = examNotes;
    }

    /**
     * 获取考试开始时间
     * @return 考试开始时间
     */
    public Date getStartTime()
    {
        return startTime;
    }

    /**
     * 设置考试开始时间
     * @param startTime 考试开始时间
     */
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    /**
     * 获取考试结束时间
     * @return 考试结束时间
     */
    public Date getEndTime()
    {
        return endTime;
    }

    /**
     * 设置考试结束时间
     * @param endTime 结束时间
     */
    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    /**
     * 获取考试类型
     * @return 考试类型
     */
    public String getExamMode()
    {
        return examMode;
    }

    /**
     * 设置考试类型
     * @param examMode 考试类型
     */
    public void setExamMode(String examMode)
    {
        this.examMode = examMode;
    }

    /**
     *获取考试题目
     * @return 考试题目字符串
     */
    public String getExamProblems()
    {
        return examProblems;
    }

    /**
     * 设置考试题目
     * @param examProblems 考试题目字符串
     */
    public void setExamProblems(String examProblems)
    {
        this.examProblems = examProblems;
    }

    /**
     * toString
     * @return 考试toString
     */
    @Override
    public String toString()
    {
        return "Exam{" +
                "examId=" + examId +
                ", examName='" + examName + '\'' +
                ", examNotes='" + examNotes + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", examMode='" + examMode + '\'' +
                ", examProblems='" + examProblems + '\'' +
                '}';
    }

    /**
     * 考试唯一标识符
     */
    private long examId;
    /**
     * 考试名称
     */
    private String examName;
    /**
     * 考试备注
     */
    private String examNotes;
    /**
     * 考试开始时间
     */
    private Date startTime;
    /**
     * 考试结束时间
     */
    private Date endTime;
    /**
     * 考试类型
     */
    private String examMode;
    /**
     * 考试题目
     */
    private String examProblems;

    /**
     * 竞赛状态. 分别表示未开始、进行中和已结束.
     */
    public enum EXAM_STATUS
    {
        READY,
        LIVE,
        DONE
    }
}
