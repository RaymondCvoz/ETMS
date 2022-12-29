package etms.web.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ExamParticipant
{
    /**
     * 考试用户对应关系默认构造函数
     */
    public ExamParticipant()
    {
    }

    /**
     * 考试用户对应关系构造函数
     * @param exam 考试对象
     * @param user 用户对象
     */
    public ExamParticipant(Exam exam, User user)
    {
        this.exam = exam;
        this.user = user;
    }

    /**
     * 获取考试
     * @return 考试
     */
    public Exam getExam()
    {
        return exam;
    }

    /**
     * 设置考试
     * @param exam 考试
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
     * 考试对象
     */
    @Autowired
    private Exam exam;
    /**
     * 用户对象
     */
    @Autowired
    private User user;
}
