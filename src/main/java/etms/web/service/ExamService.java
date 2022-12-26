
package etms.web.service;

import etms.web.mapper.ExamParticipantMapper;
import etms.web.mapper.ExamMapper;
import etms.web.mapper.ExamSubmissionMapper;
import etms.web.mapper.ProblemMapper;
import etms.web.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 考试的业务逻辑层.
 *
 */
@Service
@Transactional
public class ExamService
{
    /**
     * 获取考试列表.
     *
     * @param keyword - 考试的关键词
     * @return 包含Exam的List对象
     */
    public List<Exam> getExams(String keyword)
    {
        return examMapper.getExams(keyword);
    }

    /**
     * 通过考试的唯一标识符获取考试的详细信息.
     *
     * @param examId - 考试的唯一标识符
     * @return 包含考试信息的Exam对象
     */
    public Exam getExam(long examId)
    {
        return examMapper.getExam(examId);
    }

    /**
     * 获取考试的试题列表.
     *
     * @param problemIdList - 包含考试试题ID列表的List对象
     * @return 包含试题信息的List对象
     */
    public List<Problem> getProblemsOfExams(List<Long> problemIdList)
    {
        List<Problem> problems = new ArrayList<>();
        for (long problemId : problemIdList)
        {
            Problem p = problemMapper.getProblem(problemId);

            if (p != null)
            {
                problems.add(p);
            }
        }
        return problems;
    }


    /**
     * 获取考试记录.
     *
     * @param examId - 考试的唯一标识符
     * @return 包含考生和提交记录信息的Map对象
     */
    public Map<String, Object> getLeaderBoard(long examId)
    {
        Map<String, Object> result = new HashMap<>(3, 1);
        List<ExamParticipant> participants =
                examParticipantMapper.getParticipantsOfExam(examId);
        Map<Long, Map<Long, Submission>> submissions =
                getSubmissionsGroupByParticipant(examSubmissionMapper.getSubmissionsOfExam(examId), true);
        result.put("participants", participants);
        result.put("submissions", submissions);
        return result;
    }

    /**
     * 建立考试提交记录的索引 (参赛者UID - 试题ID).
     *
     * @param examSubmissions 包含全部竞赛提交记录的列表
     * @param override           - 当同一题出现多次提交时, 是否覆盖已有的提交记录
     * @return 组织后的竞赛提交记录
     */
    private Map<Long, Map<Long, Submission>> getSubmissionsGroupByParticipant(
            List<ExamSubmission> examSubmissions, boolean override)
    {
        Map<Long, Map<Long, Submission>> submissions = new HashMap<>();

        for (ExamSubmission cs : examSubmissions)
        {
            long problemId = cs.getSubmission().getProblem().getProblemId();
            long participantUid = cs.getSubmission().getUser().getUid();

            if (!submissions.containsKey(participantUid))
            {
                submissions.put(participantUid, new HashMap<Long,Submission>());
            }
            Map<Long, Submission> submissionsOfParticipant = submissions.get(participantUid);

            if (!override && submissionsOfParticipant.containsKey(problemId))
            {
                continue;
            }
            submissionsOfParticipant.put(problemId, cs.getSubmission());
        }
        return submissions;
    }
    
    /**
     * 此方法仅供管理员使用
     * 创建考试
     *
     * @param examName 考试名称
     * @param examNotes  详细信息
     * @param examStartTime 开始时间
     * @param examEndTime 结束时间
     * @param examMode 赛制
     * @param examProblems 包含题目
     * @return 包含考试id和考试校验信息的map对象
     */
    public Map<String,Boolean> createExam(
            String examName,
            String examNotes,
            String examStartTime,
            String examEndTime,
            String examMode,
            String examProblems
    )
    {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        Date dateBegin,dateEnd;
        try
        {
            dateBegin = simpleDateFormat.parse(examStartTime);
            dateEnd = simpleDateFormat.parse(examEndTime);
        }
        catch (Exception ex)
        {
            Date currentDate = new Date();
            dateBegin = currentDate;
            dateEnd = currentDate;
        }

        Exam exam = new Exam(
                examName,
                examNotes,
                dateBegin,
                dateEnd,
                examMode,
                "[" + examProblems + "]"
        );

        @SuppressWarnings("unchecked")
        Map<String,Boolean> result = (Map<String,Boolean>)getExamCreationResult(exam);
        if((boolean) result.get("isSuccessful"))
        {
            examMapper.createExam(exam);
        }
        return result;
    }

    /**
     * 此方法仅供管理员使用
     * 编辑考试
     *
     * @param examId 考试ID
     * @param examName 考试名称
     * @param examNotes  详细信息
     * @param examStartTime 开始时间
     * @param examEndTime 结束时间
     * @param examMode 模式
     * @param examProblems 包含题目
     * @return 包含考试id和考试校验信息的map对象
     */
    public Map<String,Boolean> editExam(
            long examId,
            String examName,
            String examNotes,
            String examStartTime,
            String examEndTime,
            String examMode,
            String examProblems
    )
    {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date dateBegin,dateEnd;
        try
        {
            dateBegin = simpleDateFormat.parse(examStartTime);
            dateEnd = simpleDateFormat.parse(examEndTime);
        }
        catch (Exception ex)
        {
            Date currentDate = new Date();
            dateBegin = currentDate;
            dateEnd = currentDate;
        }

        Exam exam = new Exam(
                examId,
                examName,
                examNotes,
                dateBegin,
                dateEnd,
                examMode,
                "[" + examProblems + "]"
        );

        @SuppressWarnings("unchecked")
        Map<String,Boolean> result = (Map<String,Boolean>)getExamCreationResult(exam);
        if((boolean) result.get("isSuccessful"))
        {
            examMapper.updateExam(exam);
        }
        return result;
    }

    /**
     * 检查考试正确性
     * @param exam 要检查的考试
     * @return 包含考试校验信息的map对象
     */
    private Map<String, Boolean> getExamCreationResult(Exam exam)
    {
        Map<String, Boolean> result = new HashMap<>();

        boolean isProblemsAvailable = true;
        String problems = exam.getExamProblems();
        for(int i = 0;i < problems.length();i++)
        {
            char charAtI = problems.charAt(i);
            if(!Character.isDigit(charAtI))
            {
                if(charAtI != ',' && charAtI != '[' && charAtI != ']')
                {
                    isProblemsAvailable = false;
                }
            }
        }
        if(isProblemsAvailable)
        {
            problems = problems.substring(1,problems.length() - 1);
            String[] problemsList = problems.split(",");
            for(String s : problemsList)
            {
                if(problemService.getProblem(Integer.parseInt(s)) == null) isProblemsAvailable = false;
            }
        }

        Date currentDate = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        simpleDateFormat.format(currentDate);

        List<Integer> problemsId = new ArrayList<>();
        result.put("isExamNameEmpty",exam.getExamName().isEmpty());
        result.put("isEndDateGreaterThanBeginDate", exam.getEndTime().after(exam.getStartTime()));
        result.put("isExamModeEmpty",exam.getExamMode().isEmpty());
        result.put("isProblemsAvailable",isProblemsAvailable);
        boolean isSuccessful =
                !result.get("isExamNameEmpty")
                        && result.get("isEndDateGreaterThanBeginDate")
                        && !result.get("isExamModeEmpty")
                        && result.get("isProblemsAvailable");
        result.put("isSuccessful",isSuccessful);
        return result;
    }
    /**
     * 获取某考试中某个用户各试题的提交记录.
     *
     * @param examId  - 考试的唯一标识符
     * @param participant - 参赛者
     * @return 包含用户提交记录的Map对象, 按试题ID索引
     */
    public Map<Long, ExamSubmission> getSubmissionsOfParticipantOfExam(
            long examId, User participant)
    {
        if (participant == null)
        {
            return null;
        }
        Map<Long, ExamSubmission> submissionsGroupByProblems = new HashMap<>();
        List<ExamSubmission> submissions =
                examSubmissionMapper.getSubmissionOfExamOfExam(examId, participant.getUid());

        for (ExamSubmission cs : submissions)
        {
            long problemId = cs.getSubmission().getProblem().getProblemId();
            submissionsGroupByProblems.put(problemId, cs);
        }
        return submissionsGroupByProblems;
    }

    /**
     * 获取某考试中某个用户某试题的提交记录.
     *
     * @param exam    - 考试对象
     * @param problemId  - 试题的唯一标识符
     * @param participant - 参赛者对象
     * @return 包含提交记录的List对象
     */
    public List<Submission> getSubmissionsOfParticipantOfExamProblem(
            Exam exam, long problemId, User participant)
    {
        if (exam == null || participant == null)
        {
            return null;
        }

        List<Submission> submissions = new ArrayList<>();
        if (getExamStatus(exam) != Exam.EXAM_STATUS.READY)
        {
            List<ExamSubmission> css =
                    examSubmissionMapper.getSubmissionOfExamOfExamProblem(
                            exam.getExamId(), problemId, participant.getUid());
            for (ExamSubmission cs : css)
            {
                submissions.add(cs.getSubmission());
            }
        }
        return submissions;
    }


    /**
     * 获取某考试的参赛人数.
     *
     * @param examId - 考试的唯一标识符
     * @return 某考试的参赛人数
     */
    public long getNumberOfParticipantsOfExam(long examId)
    {
        return examParticipantMapper.getNumberOfParticipantsOfExam(examId);
    }

    /**
     * 获取某个用户是否加入了某场考试.
     *
     * @param examId   - 考试的唯一标识符
     * @param currentUser - 当前登录的用户对象
     * @return 某个用户是否加入了某场考试
     */
    public boolean isAttendExam(long examId, User currentUser)
    {
        if (currentUser == null)
        {
            return false;
        }
        return examParticipantMapper.getParticipantOfExam(examId, currentUser.getUid()) != null;
    }

    /**
     * 获取考试的当前状态 (未开始/进行中/已结束).
     *
     * @param exam - 待查询的考试
     * @return 考试的当前状态
     */
    private Exam.EXAM_STATUS getExamStatus(Exam exam)
    {
        if (exam == null)
        {
            return null;
        }

        Date currentTime = new Date();
        if (currentTime.before(exam.getStartTime()))
        {
            return Exam.EXAM_STATUS.READY;
        } else if (currentTime.after(exam.getEndTime()))
        {
            return Exam.EXAM_STATUS.DONE;
        } else if (currentTime.before(exam.getEndTime())
                && currentTime.after(exam.getStartTime()))
        {
            return Exam.EXAM_STATUS.LIVE;
        }
        return null;
    }

    /**
     * 参加考试.
     *
     * @param examId   - 考试的唯一标识符
     * @param currentUser - 当前登录的用户对象
     * @return 包含是否成功参加考试状态信息的Map对象
     */
    public Map<String, Boolean> attendExam(
            long examId, User currentUser)
    {
        Exam exam = examMapper.getExam(examId);

        Map<String, Boolean> result = new HashMap<>(6, 1);
        result.put("isExamExists", exam != null);
        result.put("isExamReady", getExamStatus(exam) == Exam.EXAM_STATUS.READY);
        result.put("isUserLogin", currentUser != null);
        result.put("isAttendedExam", isAttendExam(examId, currentUser));

        boolean isSuccessful =
                result.get("isExamExists")
                        && result.get("isExamReady")
                        && result.get("isUserLogin")
                        && !result.get("isAttendedExam");
        if (isSuccessful)
        {
            ExamParticipant examParticipant = new ExamParticipant(exam, currentUser);
            examParticipantMapper.createExamParticipant(examParticipant);
        }
        result.put("isSuccessful", isSuccessful);
        return result;
    }


    /**
     * 删除考试
     * @param examId 考试ID
     */
    public void deleteExam(long examId)
    {
        examParticipantMapper.deleteExamAllParticipant(examId);
        examMapper.deleteExam(examId);
    }

    public void createExamSubmission(Exam exam,Submission submission)
    {
        ExamSubmission examSubmission = new ExamSubmission();
        examSubmission.setExam(exam);
        examSubmission.setSubmission(submission);
        examSubmissionMapper.createExamSubmission(examSubmission);
    }

    /**
     * 自动注入的ExamMapper对象.
     */
    @Autowired
    private ExamMapper examMapper;

    /**
     * 自动注入的ExamParticipantMapper对象.
     */
    @Autowired
    private ExamParticipantMapper examParticipantMapper;

    /**
     * 自动注入的ExamSubmissionMapper对象.
     */
    @Autowired
    private ExamSubmissionMapper examSubmissionMapper;

    /**
     * 自动注入的ProblemMapper对象. 用于获取考试中的试题信息.
     */
    @Autowired
    private ProblemMapper problemMapper;
    /**
     * 自动注入的ProblemService对象，用于创建考试时的检查
     */
    @Autowired
    private ProblemService problemService;
}
