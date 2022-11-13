
package etms.web.model;

import org.springframework.stereotype.Component;

import java.io.Serializable;

@Component
public class ProblemTag{
    /**
     * ProblemTag的默认构造函数
     */
    public ProblemTag()
    {
    }

    /**
     * ProblemTag的构造函数
     */
    public ProblemTag(String problemTagSlug, String problemTagName)
    {
        this.problemTagSlug = problemTagSlug;
        this.problemTagName = problemTagName;
    }

    /**
     * ProblemTag的构造函数
     */
    public ProblemTag(int problemTagId, String problemTagSlug, String problemTagName)
    {
        this(problemTagSlug, problemTagName);
        this.problemTagId = problemTagId;
    }

    /**
     * 获取试题分类的唯一标识符.
     *
     * @return 试题分类的唯一标识符
     */
    public long getProblemTagId()
    {
        return problemTagId;
    }

    /**
     * 设置试题分类的唯一标识符.
     *
     * @param problemTagId - 试题分类的唯一标识符
     */
    public void setProblemTagId(int problemTagId)
    {
        this.problemTagId = problemTagId;
    }

    /**
     * 获取试题分类的别名.
     *
     * @return 试题分类的别名
     */
    public String getProblemTagSlug()
    {
        return problemTagSlug;
    }

    /**
     * 设置试题分类的别名.
     *
     * @param problemTagSlug - 试题分类的别名
     */
    public void setProblemTagSlug(String problemTagSlug)
    {
        this.problemTagSlug = problemTagSlug;
    }

    /**
     * 获取试题分类的名称.
     *
     * @return 试题分类的名称
     */
    public String getProblemTagName()
    {
        return problemTagName;
    }

    /**
     * 设置试题分类的名称.
     *
     * @param problemTagName - 试题分类的名称
     */
    public void setProblemTagName(String problemTagName)
    {
        this.problemTagName = problemTagName;
    }

    public int hashCode()
    {
        return problemTagId;
    }

    /**
     * 判断课程类型是否相等
     * @param obj 课程类型
     * @return 表示是否相等的布尔值
     */
    public boolean equals(Object obj)
    {
        if (obj instanceof ProblemTag)
        {
            ProblemTag anotherTag = (ProblemTag) obj;
            return anotherTag.getProblemTagId() == problemTagId;
        }
        return false;
    }

    /**
     * 试题分类的唯一标识符.
     */
    private int problemTagId;

    /**
     * 试题分类的别名.
     */
    private String problemTagSlug;

    /**
     * 试题分类的名称.
     */
    private String problemTagName;

}
