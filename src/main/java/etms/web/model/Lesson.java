package etms.web.model;


import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 课程类
 */
@Component
public class Lesson
{
    /**
     * Lesson默认构造函数
     */
    public Lesson()
    {

    }

    /**
     * Lesson构造函数
     * @param lessonId      课程id
     * @param lessonName    课程名
     * @param description   课程描述
     * @param startTime     课程开始时间
     * @param endTime       课程结束时间
     * @param lecturerId    讲师id
     */
    public Lesson(long lessonId, String lessonName, String description, Date startTime, Date endTime, long lecturerId)
    {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.description = description;
        this.startTime = startTime;
        this.endTime = endTime;
        this.lecturerId = lecturerId;
    }

    /**
     * 获取课程唯一标识符
     * @return 课程唯一标识符
     */
    public long getLessonId()
    {
        return lessonId;
    }

    /**
     * 设置课程唯一标识符
     * @param lessonId 课程唯一标识符
     */
    public void setLessonId(long lessonId)
    {
        this.lessonId = lessonId;
    }

    /**
     * 获取课程名
     * @return 课程名
     */
    public String getLessonName()
    {
        return lessonName;
    }

    /**
     * 设置课程名
     * @param lessonName 课程名
     */
    public void setLessonName(String lessonName)
    {
        this.lessonName = lessonName;
    }

    /**
     * 获取课程描述
     * @return 课程描述
     */
    public String getDescription()
    {
        return description;
    }

    /**
     * 设置课程描述
     * @param description 课程描述
     */
    public void setDescription(String description)
    {
        this.description = description;
    }

    /**
     * 获取课程起始时间
     * @return 课程起始时间
     */
    public Date getStartTime()
    {
        return startTime;
    }

    /**
     * 设置课程起始时间
     * @param startTime 课程起始时间
     */
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    /**
     * 获取课程结束时间
     * @return 课程结束时间
     */
    public Date getEndTime()
    {
        return endTime;
    }

    /**
     * 设置课程结束时间
     * @param endTime 课程结束时间
     */
    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    /**
     * 获取课程讲师唯一标识符
     * @return 课程讲师唯一标识符
     */
    public long getLecturerId()
    {
        return lecturerId;
    }

    /**
     * 设置课程讲师唯一标识符
     * @param lecturerId 课程讲师唯一标识符
     */
    public void setLecturerId(long lecturerId)
    {
        this.lecturerId = lecturerId;
    }

    @Override
    public String toString()
    {
        return "Lesson{" +
                "lessonId=" + lessonId +
                ", lessonName='" + lessonName + '\'' +
                ", description='" + description + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", lecturerId=" + lecturerId +
                '}';
    }

    /**
     * 课程唯一标识符
     */
    private long lessonId;
    /**
     * 课程名
     */
    private String lessonName;
    /**
     * 课程描述
     */
    private String description;
    /**
     * 课程开始时间
     */
    private Date startTime;
    /**
     * 课程结束时间
     */
    private Date endTime;
    /**
     * 课程讲师唯一标识符
     */
    private long lecturerId;
}
