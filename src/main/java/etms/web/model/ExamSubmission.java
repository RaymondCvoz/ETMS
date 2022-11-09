package etms.web.model;

import org.springframework.stereotype.Component;

@Component
public class ExamSubmission
{
    /**
     * 测试提交默认构造函数
     */
    public ExamSubmission()
    {
    }

    /**
     * 测试提交构造函数
     * @param exam 测试
     * @param submission 提交
     */
    public ExamSubmission(Exam exam, Submission submission)
    {
        this.exam = exam;
        this.submission = submission;
    }

    /**
     * 获取测试
     * @return 测试
     */
    public Exam getExam()
    {
        return exam;
    }

    /**
     * 设置测试
     * @param exam 测试
     */
    public void setExam(Exam exam)
    {
        this.exam = exam;
    }

    /**
     * 获取提交
     * @return 提交
     */
    public Submission getSubmission()
    {
        return submission;
    }

    /**
     * 设置提交
     * @param submission 提交
     */
    public void setSubmission(Submission submission)
    {
        this.submission = submission;
    }

    /**
     * 测试
     */
    private Exam exam;
    /**
     * 提交
     */
    private Submission submission;
}
