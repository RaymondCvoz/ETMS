package etms.web.model;

import org.springframework.stereotype.Component;

@Component
public class ExamParticipant
{
    /**
     * 测试用户对应关系默认构造函数
     */
    public ExamParticipant()
    {
    }

    /**
     * 测试用户对应关系构造函数
     * @param exam 测试对象
     * @param user 用户对象
     */
    public ExamParticipant(Exam exam, User user)
    {
        this.exam = exam;
        this.user = user;
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
     * 获取用户
     * @return 用户
     */
    public User getUser()
    {
        return user;
    }

    /**
     * 设置用户
     * @param user 用户
     */
    public void setUser(User user)
    {
        this.user = user;
    }

    /**
     * 测试对象
     */
    private Exam exam;
    /**
     * 用户对象
     */
    private User user;
}
