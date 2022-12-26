
package etms.web.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;

public class Lesson
{
    /**
     * 课程的默认构造函数.
     */
    public Lesson()
    {
    }

    /**
     * 课程构造函数
     * @param lessonName 课程名称
     * @param description 课程描述
     */
    public Lesson(
            String lessonName,
            String description)
    {
        this.lessonName = lessonName;
        this.description = description;
    }

    /**
     * 课程类的构造函数
     * @param lessonId 课程唯一标识符
     * @param lessonName 课程名称
     * @param description 课程描述
     */
    public Lesson(
            long lessonId,
            String lessonName,
            String description)
    {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.description = description;
    }

    /**
     * 获取课程唯一标识符.
     *
     * @return 课程唯一标识符
     */
    public long getLessonId()
    {
        return lessonId;
    }

    /**
     * 设置课程唯一标识符.
     *
     * @param lessonId - 课程唯一标识符
     */
    public void setLessonId(long lessonId)
    {
        this.lessonId = lessonId;
    }
    

    /**
     * 获取课程名称.
     *
     * @return 课程名称
     */
    public String getLessonName()
    {
        return lessonName;
    }

    /**
     * 设置课程名称.
     *
     * @param lessonName - 课程名称
     */
    public void setLessonName(String lessonName)
    {
        this.lessonName = lessonName;
    }
    

    /**
     * 获取课程描述.
     *
     * @return 课程描述
     */
    public String getDescription()
    {
        return description;
    }

    /**
     * 设置课程描述.
     *
     * @param description - 课程描述
     */
    public void setDescription(String description)
    {
        this.description = description;
    }
    
    /**
     * 课程的唯一标识符.
     */
    private long lessonId;

    /**
     * 课程名称.
     */
    private String lessonName;
    
    /**
     * 课程描述.
     */
    @JsonIgnore
    private String description;
    
}
