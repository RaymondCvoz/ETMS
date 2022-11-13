package etms.web.model;

import org.springframework.stereotype.Component;

@Component
public class ProblemTagRelationship
{
    /**
     * 题目类别对应关系默认构造函数
     */
    public ProblemTagRelationship()
    {

    }

    /**
     * 题目类别对应关系构造函数
     * @param problemId 题目唯一标识符
     * @param problemTagId 题目类别唯一标识符
     */
    public ProblemTagRelationship(long problemId,
                                  int problemTagId,
                                  String problemTagSlug,
                                  String problemTagName)
    {
        this.problemId = problemId;
        this.problemTagId = problemTagId;
        this.problemTagSlug = problemTagSlug;
        this.problemTagName = problemTagName;
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
     * @param problemTagId 题目唯一标识符
     */
    public void setProblemTagId(int problemTagId)
    {
        this.problemTagId = problemTagId;
    }
    /**
     * 设置题目
     * @param problemId 题目
     */
    public void setProblemId(long problemId)
    {
        this.problemId = problemId;
    }

    /**
     * 获取题目类别
     * @return 题目类别
     */
    public int getProblemTagId()
    {
        return problemTagId;
    }

    /**
     * 设置题目类别
     * @param problemTagId 题目类别唯一标识符
     */
    public void setProblemTag(int problemTagId)
    {
        this.problemTagId = problemTagId;
    }


    /**
     * 获取题目类别别名
     * @return 题目类别别名
     */
    public String getProblemTagSlug()
    {
        return problemTagSlug;
    }

    /**
     * 设置题目类别别名
     * @param problemTagSlug 题目类别别名
     */
    public void setProblemTagSlug(String problemTagSlug)
    {
        this.problemTagSlug = problemTagSlug;
    }

    /**
     * 获取题目类别名称
     * @return 题目类别名称
     */
    public String getProblemTagName()
    {
        return problemTagName;
    }

    /**
     * 设置题目类别名称
     * @param problemTagName 题目类别名称
     */
    public void setProblemTagName(String problemTagName)
    {
        this.problemTagName = problemTagName;
    }

    /**
     * 题目唯一标识符
     */
    private long problemId;
    /**
     * 题目类别唯一标识符
     */
    private int problemTagId;

    /**
     * 试题标签的别名.
     */
    private String problemTagSlug;

    /**
     * 试题标签的名称.
     */
    private String problemTagName;
}
