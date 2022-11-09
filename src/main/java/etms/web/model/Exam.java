package etms.web.model;

import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class Exam
{
    /**
     * 测试默认构造函数
     */
    public Exam()
    {
    }

    /**
     * 测试构造函数
     * @param examName 测试名称
     * @param examNotes 测试备注
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @param examType 测试类型
     * @param examProblems 测试包含题目
     */
    public Exam(String examName, String examNotes, Date startTime, Date endTime, String examType, String examProblems)
    {
        this.examName = examName;
        this.examNotes = examNotes;
        this.startTime = startTime;
        this.endTime = endTime;
        this.examType = examType;
        this.examProblems = examProblems;
    }

    /**
     * 测试类构造函数
     * @param examId        测试唯一标识符
     * @param examName      测试名称
     * @param examNotes     测试备注
     * @param startTime     开始时间
     * @param endTime       结束时间
     * @param examType      测试类型
     * @param examProblems  测试包含的题目
     */
    public Exam(long examId, String examName, String examNotes, Date startTime, Date endTime, String examType, String examProblems)
    {
        this.examId = examId;
        this.examName = examName;
        this.examNotes = examNotes;
        this.startTime = startTime;
        this.endTime = endTime;
        this.examType = examType;
        this.examProblems = examProblems;
    }

    /**
     * 获取测试唯一标识符
     * @return 测试唯一标识符
     */
    public long getExamId()
    {
        return examId;
    }

    /**
     * 设置测试唯一标识符
     * @param examId 测试唯一标识符
     */
    public void setExamId(long examId)
    {
        this.examId = examId;
    }

    /**
     * 获取测试名称
     * @return 测试名称
     */
    public String getExamName()
    {
        return examName;
    }

    /**
     * 设置测试名称
     * @param examName 测试名称
     */
    public void setExamName(String examName)
    {
        this.examName = examName;
    }

    /**
     * 获取测试备注
     * @return 测试备注
     */
    public String getExamNotes()
    {
        return examNotes;
    }

    /**
     * 设置测试备注
     * @param examNotes 测试备注
     */
    public void setExamNotes(String examNotes)
    {
        this.examNotes = examNotes;
    }

    /**
     * 获取测试开始时间
     * @return 测试开始时间
     */
    public Date getStartTime()
    {
        return startTime;
    }

    /**
     * 设置测试开始时间
     * @param startTime 测试开始时间
     */
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    /**
     * 获取测试结束时间
     * @return 测试结束时间
     */
    public Date getEndTime()
    {
        return endTime;
    }

    /**
     * 设置测试结束时间
     * @param endTime 结束时间
     */
    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    /**
     * 获取测试类型
     * @return 测试类型
     */
    public String getExamType()
    {
        return examType;
    }

    /**
     * 设置测试类型
     * @param examType 测试类型
     */
    public void setExamType(String examType)
    {
        this.examType = examType;
    }

    /**
     *获取测试题目
     * @return 测试题目字符串
     */
    public String getExamProblems()
    {
        return examProblems;
    }

    /**
     * 设置测试题目
     * @param examProblems 测试题目字符串
     */
    public void setExamProblems(String examProblems)
    {
        this.examProblems = examProblems;
    }

    /**
     * toString
     * @return 测试toString
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
                ", examType='" + examType + '\'' +
                ", examProblems='" + examProblems + '\'' +
                '}';
    }

    /**
     * 测试唯一标识符
     */
    private long examId;
    /**
     * 测试名称
     */
    private String examName;
    /**
     * 测试备注
     */
    private String examNotes;
    /**
     * 测试开始时间
     */
    private Date startTime;
    /**
     * 测试结束时间
     */
    private Date endTime;
    /**
     * 测试类型
     */
    private String examType;
    /**
     * 测试题目
     */
    private String examProblems;

}
