package etms.web.model;

import org.springframework.stereotype.Component;

/**
 * 课程与学生用户的对应类
 */
@Component
public class LessonParticipant
{
    /**
     * LessonParticipant默认构造函数
     */
    public LessonParticipant()
    {
    }

    /**
     *LessonParticipant构造函数
     * @param lessonId          课程
     * @param participantId  学生用户
     */
    public LessonParticipant(long lessonId, long participantId)
    {
        this.lessonId = lessonId;
        this.participantId = participantId;
    }

    /**
     * 获取课程
     * @return 课程对象
     */
    public long getLessonId()
    {
        return lessonId;
    }

    /**
     * 设置课程
     * @param lessonId 课程对象
     */
    public void setLesson(long lessonId)
    {
        this.lessonId = lessonId;
    }

    /**
     * 获取学生用户
     * @return 学生用户
     */
    public long getParticipantId()
    {
        return participantId;
    }

    /**
     * 设置学生用户
     * @param participantId 学生用户
     */
    public void setParticipantId(long participantId)
    {
        this.participantId = participantId;
    }

    /**
     *课程
     */
    private long lessonId;
    /**
     * 学生用户
     */
    private long participantId;
}
