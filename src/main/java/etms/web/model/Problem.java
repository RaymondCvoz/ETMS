
package etms.web.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;

public class Problem
{
    /**
     * 试题的默认构造函数.
     */
    public Problem()
    {
    }

    /**
     * 试题构造函数
     * @param isPublic 试题是否公开
     * @param problemName 试题名称
     * @param description 试题描述
     * @param hint 试题提示
     * @param problemType 试题类型
     * @param answer 试题答案
     * @param score 试题满分
     */
    public Problem(
            boolean isPublic,
            String problemName,
            String description,
            String hint,
            int problemType,
            String answer,
            int score)
    {
        this.isPublic = isPublic;
        this.problemName = problemName;
        this.description = description;
        this.hint = hint;
        this.problemType = problemType;
        this.answer = answer;
        this.score = score;
    }

    /**
     * 试题类的构造函数
     * @param problemId 试题唯一标识符
     * @param isPublic 试题是否公开
     * @param problemName 实体名称
     * @param description 试题描述
     * @param hint 试题提示
     * @param problemType 试题类型
     * @param answer 试题答案
     * @param score 试题满分
     */
    public Problem(
            long problemId,
            boolean isPublic,
            String problemName,
            String description,
            String hint,
            int problemType,
            String answer,
            int score)
    {
        this.problemId = problemId;
        this.isPublic = isPublic;
        this.problemName = problemName;
        this.description = description;
        this.hint = hint;
        this.problemType = problemType;
        this.answer = answer;
        this.score = score;
    }

    /**
     * 获取试题唯一标识符.
     *
     * @return 试题唯一标识符
     */
    public long getProblemId()
    {
        return problemId;
    }

    /**
     * 设置试题唯一标识符.
     *
     * @param problemId - 试题唯一标识符
     */
    public void setProblemId(long problemId)
    {
        this.problemId = problemId;
    }

    /**
     * 获取试题是否公开的.
     *
     * @return 试题是否公开
     */
    public boolean isPublic()
    {
        return isPublic;
    }

    /**
     * 设置试题是否公开.
     *
     * @param isPublic - 试题是否公开
     */
    public void setPublic(boolean isPublic)
    {
        this.isPublic = isPublic;
    }

    /**
     * 获取试题名称.
     *
     * @return 试题名称
     */
    public String getProblemName()
    {
        return problemName;
    }

    /**
     * 设置试题名称.
     *
     * @param problemName - 试题名称
     */
    public void setProblemName(String problemName)
    {
        this.problemName = problemName;
    }

    /**
     * 获取试题包含的标签.
     *
     * @return 试题包含的标签
     */
    public List<ProblemTag> getProblemTags()
    {
        return problemTags;
    }

    /**
     * 设置试题包含的标签.
     *
     * @param problemTags - 试题包含的标签
     */
    public void setProblemTags(List<ProblemTag> problemTags)
    {
        this.problemTags = problemTags;
    }

    /**
     * 获取试题描述.
     *
     * @return 试题描述
     */
    public String getDescription()
    {
        return description;
    }

    /**
     * 设置试题描述.
     *
     * @param description - 试题描述
     */
    public void setDescription(String description)
    {
        this.description = description;
    }


    /**
     * 获取试题提示.
     *
     * @return 试题提示
     */
    public String getHint()
    {
        return hint;
    }

    /**
     * 设置试题提示.
     *
     * @param hint - 试题提示
     */
    public void setHint(String hint)
    {
        this.hint = hint;
    }

    /**
     * 获取试题类型
     * @return 试题类型
     */
    public int getProblemType()
    {
        return problemType;
    }

    /**
     * 设置试题类型
     * @param problemType 试题类型
     */
    public void setProblemType(int problemType)
    {
        this.problemType = problemType;
    }

    /**
     * 获取试题答案
     * @return 试题答案
     */
    public String getAnswer()
    {
        return answer;
    }

    /**
     * 设置试题答案
     * @param answer 试题答案
     */
    public void setAnswer(String answer)
    {
        this.answer = answer;
    }

    /**
     * 获取试题满分
     * @return 试题满分
     */
    public int getScore()
    {
        return score;
    }

    /**
     * 设置试题满分
     * @param score 试题满分
     */
    public void setScore(int score)
    {
        this.score = score;
    }

    /**
     * 试题的唯一标识符.
     */
    private long problemId;

    /**
     * 试题是否公开.
     */
    private boolean isPublic;

    /**
     * 试题名称.
     */
    private String problemName;

    /**
     * 试题包含的标签.
     */
    private List<ProblemTag> problemTags;


    /**
     * 试题描述.
     */
    @JsonIgnore
    private String description;

    /**
     * 试题提示.
     */
    @JsonIgnore
    private String hint;
    /**
     * 试题类型
     */
    private int problemType;
    /**
     * 试题答案
     */
    @JsonIgnore
    private String answer;

    /**
     * 试题满分
     */
    private int score;
}
