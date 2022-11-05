package etms.web.model;

import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class Exam
{

    public Exam()
    {
    }

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

    public long getExamId()
    {
        return examId;
    }

    public void setExamId(long examId)
    {
        this.examId = examId;
    }

    public String getExamName()
    {
        return examName;
    }

    public void setExamName(String examName)
    {
        this.examName = examName;
    }

    public String getExamNotes()
    {
        return examNotes;
    }

    public void setExamNotes(String examNotes)
    {
        this.examNotes = examNotes;
    }

    public Date getStartTime()
    {
        return startTime;
    }

    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }

    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    public String getExamType()
    {
        return examType;
    }

    public void setExamType(String examType)
    {
        this.examType = examType;
    }

    public String getExamProblems()
    {
        return examProblems;
    }

    public void setExamProblems(String examProblems)
    {
        this.examProblems = examProblems;
    }

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

    private long examId;
    private String examName;
    private String examNotes;
    private Date startTime;
    private Date endTime;
    private String examType;
    private String examProblems;

}
