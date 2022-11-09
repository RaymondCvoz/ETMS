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
     * @param problem 题目
     * @param problemTag 题目类别
     */
    public ProblemTagRelationship(Problem problem, ProblemTag problemTag)
    {
        this.problem = problem;
        this.problemTag = problemTag;
    }

    /**
     * 获取题目
     * @return 题目
     */
    public Problem getProblem()
    {
        return problem;
    }

    /**
     * 设置题目
     * @param problem 题目
     */
    public void setProblem(Problem problem)
    {
        this.problem = problem;
    }

    /**
     * 获取题目类别
     * @return 题目类别
     */
    public ProblemTag getProblemTag()
    {
        return problemTag;
    }

    /**
     * 设置题目类别
     * @param problemTag 题目类别
     */
    public void setProblemTag(ProblemTag problemTag)
    {
        this.problemTag = problemTag;
    }

    /**
     * 题目
     */
    private Problem problem;
    /**
     * 题目类别
     */
    private ProblemTag problemTag;
}
