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
     * @param lesson    课程
     * @param user      学生用户
     */
    public LessonParticipant(Lesson lesson, User user)
    {
        this.lesson = lesson;
        this.user = user;
    }

    /**
     * 获取课程
     * @return 课程对象
     */
    public Lesson getLesson()
    {
        return lesson;
    }

    /**
     * 设置课程
     * @param lesson 课程对象
     */
    public void setLesson(Lesson lesson)
    {
        this.lesson = lesson;
    }

    /**
     * 获取学生用户
     * @return 学生用户
     */
    public User getUser()
    {
        return user;
    }

    /**
     * 设置学生用户
     * @param user 学生用户
     */
    public void setUser(User user)
    {
        this.user = user;
    }

    /**
     *课程
     */
    private Lesson lesson;
    /**
     * 学生用户
     */
    private User user;
}
