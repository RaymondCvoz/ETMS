package etms.web.controller;
import etms.web.exception.ResourceNotFoundException;
import etms.web.model.*;
import etms.web.service.ExamService;
import etms.web.service.ProblemService;
import etms.web.service.SubmissionService;
import etms.web.util.HttpSessionParser;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理考试的相关请求.
 *
 */
@Controller
@RequestMapping(value = "/exam")
public class ExamsController
{
    /**
     * 显示考试列表页面.
     *
     * @param keyword  - 考试的关键词
     * @param request  - HttpRequest对象
     * @param response - HttpResponse对象
     * @return 一个包含考试列表页面内容的ModelAndView对象
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView examsView(
            @RequestParam(value = "keyword", required = false) String keyword,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        List<Exam> exams = examService.getExams(keyword);

        ModelAndView view = new ModelAndView("exams/exams");
        view.addObject("exams", exams);
        view.addObject("currentTime", new Date());
        return view;
    }

    /**
     * 获取考试的列表.
     *
     * @param keyword    - 考试的关键词
     * @param request    - HttpRequest对象
     * @return 一个包含考试列表的HashMap对象
     */
    @RequestMapping(value = "/getExams.action", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, Object> getExamsAction(
            @RequestParam(value = "keyword", required = false) String keyword,
            HttpServletRequest request)
    {
        Map<String, Object> result = new HashMap<>(3, 1);

        List<Exam> exams =
                examService.getExams(keyword);
        result.put("isSuccessful", exams != null && !exams.isEmpty());
        result.put("exams", exams);

        return result;
    }

    /**
     * 显示考试详细信息的页面.
     *
     * @param examId - 考试的唯一标识符
     * @param request   - HttpRequest对象
     * @param response  - HttpResponse对象
     * @return 包含提交详细信息的ModelAndView对象
     */
    @RequestMapping(value = "/{examId}", method = RequestMethod.GET)
    public ModelAndView examView(
            @PathVariable("examId") long examId,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        HttpSession session = request.getSession();
        User currentUser = HttpSessionParser.getCurrentUser(session);
        Exam exam = examService.getExam(examId);
        if (exam == null)
        {
            throw new ResourceNotFoundException();
        }

        boolean isAttended = examService.isAttendExam(examId, currentUser);
        long numberOfParticipants = examService.getNumberOfParticipantsOfExam(examId);
        List<Long> problemIdList = JSON.parseArray(exam.getExamProblems(), Long.class);
        List<Problem> problems = examService.getProblemsOfExams(problemIdList);
        Map<Long, ExamSubmission> submissions =
                examService.getSubmissionsOfParticipantOfExam(examId, currentUser);

        ModelAndView view = new ModelAndView("exams/exam");
        view.addObject("currentTime", new Date())
                .addObject("exam", exam)
                .addObject("problems", problems)
                .addObject("submissions", submissions)
                .addObject("isAttended", isAttended)
                .addObject("numberOfParticipants", numberOfParticipants);
        return view;
    }

    /**
     * 处理用户参加考试的请求.
     *
     * @param examId - 考试的唯一标识符
     * @param request   - HttpRequest对象
     * @param response  - HttpResponse对象
     * @return 包含是否成功参加考试状态信息的Map对象
     */
    @RequestMapping(value = "/{examId}/attend.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> attendExamAction(
            @PathVariable("examId") long examId,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        HttpSession session = request.getSession();
        User currentUser = HttpSessionParser.getCurrentUser(session);
        Map<String, Boolean> result =
                examService.attendExam(examId, currentUser);
        return result;
    }

    @RequestMapping(value = "/{examId}/createSubmission.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Object> createSubmissionAction(
            @PathVariable("examId") long examId,
            @RequestParam(value = "problemId") long problemId,
            @RequestParam(value = "context") String context,
            HttpServletRequest request)
    {
        HttpSession session = request.getSession();
        User currentUser = HttpSessionParser.getCurrentUser(session);

        Map<String, Object> result =
                submissionService.createSubmission(
                        currentUser, problemId, context,true);
        boolean isSuccessful = (Boolean) result.get("isSuccessful");
        if (isSuccessful)
        {
            long submissionId = (Long) result.get("submissionId");
            Exam exam = examService.getExam(examId);
            Submission submission = submissionService.getSubmission(submissionId);
            examService.createExamSubmission(exam,submission);
        }
        return result;
    }

    /**
     * 显示考试中的试题信息.
     *
     * @param examId - 考试的唯一标识符
     * @param problemId - 试题的唯一标识符
     * @param request   - HttpRequest对象
     * @param response  - HttpResponse对象
     * @return 包含考试试题信息的ModelAndView对象
     */
    @RequestMapping(value = "/{examId}/p/{problemId}", method = RequestMethod.GET)
    public ModelAndView problemView(
            @PathVariable("examId") long examId,
            @PathVariable("problemId") long problemId,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        HttpSession session = request.getSession();
        User currentUser = HttpSessionParser.getCurrentUser(session);
        Exam exam = examService.getExam(examId);
        if (exam == null)
        {
            throw new ResourceNotFoundException();
        }
        // 试题不存在于考试试题列表中
        List<Long> problems = JSON.parseArray(exam.getExamProblems(), Long.class);
        if (!problems.contains(problemId))
        {
            throw new ResourceNotFoundException();
        }
        // 未参加考试者在考试结束前无法查看试题
        Date currentTime = new Date();
        boolean isAttended = examService.isAttendExam(examId, currentUser);
        if (exam.getEndTime().after(currentTime) && !isAttended)
        {
            throw new ResourceNotFoundException();
        }

        Problem problem = problemService.getProblem(problemId);
        List<Submission> submissions =
                examService.getSubmissionsOfParticipantOfExamProblem(exam, problemId, currentUser);
        ModelAndView view = new ModelAndView("problems/problem");
        view.addObject("exam", exam);
        view.addObject("problem", problem);
        view.addObject("submissions", submissions);
        view.addObject("currentTime", currentTime);
        view.addObject("isExam", true);
        return view;
    }

    /**
     * 显示排行榜.
     *
     * @param examId - 竞赛的唯一标识符
     * @param request   - HttpRequest对象
     * @param response  - HttpResponse对象
     * @return 包含竞赛排行榜的ModelAndView对象
     */
    @RequestMapping(value = "/{examId}/leaderboard", method = RequestMethod.GET)
    public ModelAndView leaderboardView(
            @PathVariable("examId") long examId,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        Exam exam = examService.getExam(examId);
        Date currentTime = new Date();
        if (exam == null)
        {
            throw new ResourceNotFoundException();
        }

        List<Long> problemIdList = JSON.parseArray(exam.getExamProblems(), Long.class);
        List<Problem> problems = examService.getProblemsOfExams(problemIdList);

        ModelAndView view = null;
        Map<String, Object> result = null;
        view = new ModelAndView("exams/leaderboard");

        List<ExamParticipant> participants = examService.getLeaderBoardParticipants(examId);
        Map<Long, Map<Long, Submission>> submissions = examService.getLeaderBoardSubmissions(examId);

        for(ExamParticipant examParticipant : participants)
        {
            System.out.println(examParticipant.getUser().toString());
        }

        view.addObject("participants", participants);
        view.addObject("submissions", submissions);
        view.addObject("exam", exam);
        view.addObject("problems", problems);
        return view;
    }
    
    /**
     * 每次查询需要加载考试的数量.
     */
    private static final int NUMBER_OF_CONTESTS_PER_PAGE = 10;

    /**
     * 自动注入的ExamService对象.
     */
    @Autowired
    private ExamService examService;

    /**
     * 自动注入的ProblemService对象. 用于查询试题信息.
     */
    @Autowired
    private ProblemService problemService;
    

    /**
     * 自动注入的SubmissionService对象. 用于创建提交记录.
     */
    @Autowired
    private SubmissionService submissionService;
}
