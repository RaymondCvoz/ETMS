
package etms.web.controller;

import etms.web.exception.ResourceNotFoundException;
import etms.web.model.*;
import etms.web.service.*;
import etms.web.util.CsrfProtector;
import etms.web.util.DateUtils;
import etms.web.util.HttpRequestParser;
import etms.web.util.SessionListener;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 用于处理系统管理的请求.
 **/
@Controller
@RequestMapping(value = "/administration")
public class AdministrationController
{
    /**
     * 加载系统管理首页.
     *
     * @param request  - HttpRequest对象
     * @param response - HttpResponse对象
     * @return 包含系统管理页面信息的ModelAndView对象
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView indexView(HttpServletRequest request, HttpServletResponse response)
    {
        ModelAndView view = new ModelAndView("administration/index");
        view.addObject("totalUsers", getTotalUsers());
        view.addObject("newUsersToday", getNumberOfUserRegisteredToday());
        view.addObject("onlineUsers", getOnlineUsers());
        view.addObject("totalProblems", getTotalProblems());
        view.addObject("privateProblems", getPrivateProblems());
        view.addObject("submissionsToday", getSubmissionsToday());
        return view;
    }

    /**
     * 获取系统中注册用户的总数.
     *
     * @return 系统中注册用户的总数
     */
    private long getTotalUsers()
    {
        UserGroup userGroup = userService.getUserGroupUsingSlug("users");
        return userService.getNumberOfUsers(userGroup);
    }

    /**
     * 获取今日注册的用户数量.
     *
     * @return 今日注册的用户数量
     */
    public long getNumberOfUserRegisteredToday()
    {
        return userService.getNumberOfUserRegisteredToday();
    }

    /**
     * 获取在线用户的数量.
     *
     * @return 在线用户的数量
     */
    private long getOnlineUsers()
    {
        return SessionListener.getTotalSessions();
    }

    /**
     * 获取全部试题的总数量.
     *
     * @return 全部试题的总数量
     */
    private long getTotalProblems()
    {
        return problemService.getNumberOfProblems();
    }

    /**
     * 获取私有试题的数量.
     *
     * @return 私有试题的数量
     */
    private long getPrivateProblems()
    {
        long numberOfTotalProblems = getTotalProblems();
        long numberOfPublicProblems = problemService.getNumberOfProblemsUsingFilters(null, "", true);
        return numberOfTotalProblems - numberOfPublicProblems;
    }

    /**
     * 获取今日的提交数量.
     *
     * @return 今日的提交数量
     */
    private long getSubmissionsToday()
    {
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int date = calendar.get(Calendar.DAY_OF_MONTH);

        calendar.set(year, month, date, 0, 0, 0);
        Date startTime = calendar.getTime();

        calendar.set(year, month, date + 1, 0, 0, 0);
        Date endTime = calendar.getTime();
        return submissionService.getNumberOfSubmissionsUsingDate(startTime, endTime);
    }

    /**
     * 获取Web应用当前内存占用情况.
     *
     * @return Web应用当前内存占用(MB)
     */
    private long getCurrentMemoryUsage()
    {
        long totalMemory = Runtime.getRuntime().totalMemory();
        long freeMemory = Runtime.getRuntime().freeMemory();

        return (totalMemory - freeMemory) / 1048576;
    }


    /**
     * 获取系统一段时间内的提交次数.
     *
     * @param period  - 时间间隔的天数
     * @param request - HttpServletRequest对象
     * @return 包含提交次数与时间的 Map 对象
     */
    @RequestMapping(value = "/getNumberOfSubmissions.action", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, Object> getNumberOfSubmissionsAction(
            @RequestParam(value = "period") int period, HttpServletRequest request)
    {
        Map<String, Object> submissions = new HashMap<>(2, 1);
        Date today = new Date();
        Date previousDate = DateUtils.getPreviousDate(period);
        Map<String, Long> totalSubmissions =
                submissionService.getNumberOfSubmissionsUsingDate(previousDate, today, 0, false);
        Map<String, Long> acceptedSubmissions =
                submissionService.getNumberOfSubmissionsUsingDate(previousDate, today, 0, true);

        submissions.put("totalSubmissions", totalSubmissions);
        submissions.put("acceptedSubmissions", acceptedSubmissions);
        return submissions;
    }

    /**
     * 加载用户列表页面.
     *
     * @param request  - HttpRequest对象
     * @param response - HttpResponse对象
     * @return 包含用户列表页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/all-users", method = RequestMethod.GET)
    public ModelAndView allUsersView(
            @RequestParam(value = "userGroup", required = false, defaultValue = "") String userGroupSlug,
            @RequestParam(value = "username", required = false, defaultValue = "") String username,
            @RequestParam(value = "page", required = false, defaultValue = "1") long pageNumber,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        final int NUMBER_OF_USERS_PER_PAGE = 100;
        List<UserGroup> userGroups = userService.getUserGroups();
        UserGroup userGroup = userService.getUserGroupUsingSlug(userGroupSlug);
        long totalUsers = userService.getNumberOfUsersUsingUserGroupAndUsername(userGroup, username);
        long offset = (pageNumber >= 1 ? pageNumber - 1 : 0) * NUMBER_OF_USERS_PER_PAGE;
        List<User> users =
                userService.getUserUsingUserGroupAndUsername(
                        userGroup, username, offset, NUMBER_OF_USERS_PER_PAGE);

        ModelAndView view = new ModelAndView("administration/all-users");
        view.addObject("userGroups", userGroups);
        view.addObject("selectedUserGroup", userGroupSlug);
        view.addObject("username", username);
        view.addObject("currentPage", pageNumber);
        view.addObject("totalPages", (long) Math.ceil(totalUsers * 1.0 / NUMBER_OF_USERS_PER_PAGE));
        view.addObject("users", users);
        return view;
    }

    /**
     * 删除选定的用户.
     *
     * @param users   - 用户ID的集合, 以逗号(, )分隔
     * @param request - HttpServletRequest对象
     * @return 提交记录的删除结果
     */
    @RequestMapping(value = "/deleteUsers.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> deleteUsersAction(
            @RequestParam(value = "users") String users, HttpServletRequest request)
    {
        Map<String, Boolean> result = new HashMap<>(2, 1);
        List<Long> userList = JSON.parseArray(users, Long.class);

        for (Long userId : userList)
        {
            userService.deleteUser(userId);
        }
        result.put("isSuccessful", true);
        return result;
    }

    /**
     * 加载编辑用户信息的页面.
     *
     * @param userId   - 用户的唯一标识符
     * @param request  - HttpServletRequest对象
     * @param response - HttpServletResponse对象
     * @return 包含编辑用户信息的ModelAndView对象
     */
    @RequestMapping(value = "/edit-user/{userId}", method = RequestMethod.GET)
    public ModelAndView editUserView(
            @PathVariable(value = "userId") long userId,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        User user = userService.getUserUsingUid(userId);
        Map<String, Object> userMeta = userService.getUserMetaUsingUid(user);
        if (user == null)
        {
            throw new ResourceNotFoundException();
        }

        List<UserGroup> userGroups = userService.getUserGroups();
        ModelAndView view = new ModelAndView("administration/edit-user");
        view.addObject("user", user);
        view.addAllObjects(userMeta);
        view.addObject("userGroups", userGroups);
        return view;
    }

    /**
     * 编辑用户个人信息.
     *
     * @param uid                - 用户的唯一标识符.
     * @param password           - 用户的密码(未经MD5加密)
     * @param email              - 用户的电子邮件地址
     * @param userGroupSlug      - 用户组的别名
     * @param request            - HttpServletRequest对象
     * @return 一个包含个人资料修改结果的Map<String, Boolean>对象
     */
    @RequestMapping(value = "/editUser.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> editUserAction(
            @RequestParam(value = "uid") long uid,
            @RequestParam(value = "password") String password,
            @RequestParam(value = "email") String email,
            @RequestParam(value = "userGroup") String userGroupSlug,
            HttpServletRequest request)
    {
        User user = userService.getUserUsingUid(uid);
        Map<String, Boolean> result = new HashMap<>(12, 1);
        result.put("isSuccessful", false);
        result.put("isUserExists", false);

        if (user != null)
        {
            Map<String, Boolean> updateProfileResult =
                    userService.updateProfile(user, password, userGroupSlug);
            Map<String, Boolean> updateUserMetaResult =
                    userService.updateProfile(user, email);
            boolean isUpdateProfileSuccessful = updateProfileResult.get("isSuccessful");
            boolean isUpdateUserMetaSuccessful = updateUserMetaResult.get("isSuccessful");

            result.putAll(updateProfileResult);
            result.putAll(updateUserMetaResult);
            result.put("isUserExists", true);
            result.put("isSuccessful", isUpdateProfileSuccessful && isUpdateUserMetaSuccessful);
        }
        return result;
    }

    /**
     * 加载创建用户页面.
     *
     * @param request  - HttpServletRequest对象
     * @param response - HttpServletResponse对象
     * @return 包含创建用户页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/new-user", method = RequestMethod.GET)
    public ModelAndView newUserView(HttpServletRequest request, HttpServletResponse response)
    {
        List<UserGroup> userGroups = userService.getUserGroups();
        ModelAndView view = new ModelAndView("administration/new-user");
        view.addObject("userGroups", userGroups);
        return view;
    }

    /**
     * 创建新用户.
     *
     * @param username           - 用户名
     * @param password           - 密码
     * @param email              - 电子邮件地址
     * @param userGroupSlug      - 用户组的别名
     * @param request            - HttpServletRequest对象
     * @return 一个包含账户创建结果的Map<String, Boolean>对象
     */
    @RequestMapping(value = "/newUser.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> newUserAction(
            @RequestParam(value = "username") String username,
            @RequestParam(value = "password") String password,
            @RequestParam(value = "email") String email,
            @RequestParam(value = "userGroup") String userGroupSlug,
            HttpServletRequest request)
    {
        Map<String, Boolean> result =
                userService.createUser(username, password, email, userGroupSlug);

        if (result.get("isSuccessful"))
        {
            String ipAddress = HttpRequestParser.getRemoteAddr(request);
            LOGGER.info(
                    String.format(
                            "User: [Username=%s] was created by administrator at %s.",
                            new Object[]{username, ipAddress}));
        }
        return result;
    }

    /**
     * 加载试题列表页面.
     *
     * @param request  - HttpServletRequest对象
     * @param response - HttpServletResponse对象
     * @return 包含提交列表页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/all-problems", method = RequestMethod.GET)
    public ModelAndView allProblemsView(
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            @RequestParam(value = "problemTag", required = false, defaultValue = "") String problemTagSlug,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        List<ProblemTag> problemTags = problemService.getProblemTags();

        long problemIdLowerBound = problemService.getFirstIndexOfProblems();
        long problemIdUpperBound = problemService.getLastIndexOfProblemsAdmin();

        List<Problem> problems =
                problemService.getProblemsUsingFiltersAdmin(
                        keyword,
                        problemTagSlug);
        Map<Long, List<ProblemTag>> problemTagRelationships =
                problemService.getProblemTagsOfProblems(problemIdLowerBound, problemIdUpperBound);

        ModelAndView view = new ModelAndView("administration/all-problems");
        view.addObject("problemTags", problemTags);
        view.addObject("selectedProblemTag", problemTagSlug);
        view.addObject("keyword", keyword);
        view.addObject("problems", problems);
        view.addObject("problemTagRelationships", problemTagRelationships);
        return view;
    }

//    /**
//     * 加载考试列表页面.
//     *
//     * @param request  - HttpServletRequest对象
//     * @param response - HttpServletResponse对象
//     * @return 包含考试列表页面信息的ModelAndView对象
//     */
//    @RequestMapping(value = "/all-contests",method = RequestMethod.GET)
//    public ModelAndView allContestsView(
//            @RequestParam(value = "keyword",required = false) String keyword,
//            @RequestParam(value = "page", required = false, defaultValue = "1") long pageNumber,
//            HttpServletRequest request,
//            HttpServletResponse response
//    )
//    {
//        final int NUMBER_OF_CONTESTS_PER_PAGE = 100;
//        long offset = (pageNumber >= 1 ? pageNumber - 1 : 0) * NUMBER_OF_CONTESTS_PER_PAGE;
//        List<Exam> contests = contestService.getContests(keyword,offset,NUMBER_OF_CONTESTS_PER_PAGE);
//        long totalContests = contests.size();
//
//        ModelAndView view = new ModelAndView("administration/all-exams");
//        view.addObject(
//                "totalPages", (long) Math.ceil(totalContests * 1.0 / NUMBER_OF_CONTESTS_PER_PAGE));
//        view.addObject("contests",contests);
//        view.addObject("currentPage", pageNumber);
//        return view;
//    }
//
//    /**
//     * 创建考试页面
//     * @param request HttpServletRequest对象
//     * @param response HttpServletResponse对象
//     * @return 包含新建考试所需信息的ModelAndView
//     */
//    @RequestMapping(value = "/new-exam",method = RequestMethod.GET)
//    public ModelAndView newContestView(HttpServletRequest request,HttpServletResponse response)
//    {
//        List<Problem> problems = problemService.getProblemsUsingFilters(0,"","","",true,1000000);
//        ModelAndView view = new ModelAndView("administration/new-exam");
//
//        Date currentDate = new Date();
//        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        String dateToString =  simpleDateFormat.format(currentDate);
//
//        view.addObject("availableProblems",problems);
//        view.addObject("dateToString",dateToString);
//        return view;
//    }
//
//    /**
//     * 创建考试
//     * @param examName 考试名称
//     * @param examNote 考试备注
//     * @param startTime 开始时间
//     * @param endTime 结束时间
//     * @param examType 考试类型
//     * @param problems 题目
//     * @return 包含考试创建信息的Map对象
//     * @throws ParseException
//     */
//    @RequestMapping(value = "/newContest.action",method = RequestMethod.POST)
//    public @ResponseBody
//    Map<String,Boolean> newContestAction(
//            @RequestParam(value = "examName") String examName,
//            @RequestParam(value = "examNote") String examNote,
//            @RequestParam(value = "startTime") String startTime,
//            @RequestParam(value = "endTime") String endTime,
//            @RequestParam(value = "examType") String examType,
//            @RequestParam(value = "problems") String problems
//    )
//    {
//        Map<String, Boolean> result =
//                contestService.createContest(contestName, contestNote, startTime, endTime, contestMode,problems);
//
//        if ((Boolean) result.get("isSuccessful"))
//        {
//            LOGGER.info("contest" + result.get("contestId") + " has been created");
//        }
//        return result;
//    }
//
//    /**
//     * 删除考试操作
//     * @param exams 包含要删除的考试ID的JSON
//     * @return 删除结果的Map对象
//     */
//    @RequestMapping(value = "/deleteExams.action",method = RequestMethod.POST)
//    public @ResponseBody
//    Map<String,Boolean> deleteContestsAction(@RequestParam(value = "exams") String exams)
//    {
//        Map<String, Boolean> result = new HashMap<>(2, 1);
//        List<Long> examsId = JSON.parseArray(exams, Long.class);
//        for(Long examId : examsId)
//        {
//            contestService.deleteContest(contestId);
//        }
//        result.put("isSuccessful",true);
//        return result;
//    }
    /**
     * 删除选定的试题.
     *
     * @param problems - 试题ID的集合, 以逗号(, )分隔
     * @param request  - HttpServletRequest对象
     * @return 试题的删除结果
     */
    @RequestMapping(value = "/deleteProblems.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> deleteProblemsAction(
            @RequestParam(value = "problems") String problems, HttpServletRequest request)
    {
        Map<String, Boolean> result = new HashMap<>(2, 1);
        List<Long> problemList = JSON.parseArray(problems, Long.class);

        for (Long problemId : problemList)
        {
            problemService.deleteProblem(problemId);

            String ipAddress = HttpRequestParser.getRemoteAddr(request);
            LOGGER.info(
                    String.format(
                            "Problem: [ProblemId=%s] was deleted by administrator at %s.",
                            new Object[]{problemId, ipAddress}));
        }
        result.put("isSuccessful", true);
        return result;
    }

    /**
     * 加载创建试题页面.
     *
     * @param request  - HttpServletRequest对象
     * @param response - HttpServletResponse对象
     * @return 包含创建试题页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/new-problem", method = RequestMethod.GET)
    public ModelAndView newProblemView(HttpServletRequest request, HttpServletResponse response)
    {
        List<ProblemTag> problemTags = problemService.getProblemTags();
        ModelAndView view = new ModelAndView("administration/new-problem");
        view.addObject("problemCategories", problemTags);
        return view;
    }

    /**
     * 处理用户创建试题的请求.
     *
     * @param isPublic          - 试题是否公开
     * @param problemName       - 试题名称
     * @param description       - 试题描述
     * @param hint              - 试题提示
     * @param problemType       - 试题类型
     * @param problemTags       - 试题标签((JSON 格式)
     * @param score             - 试题满分
     * @param answer            - 试题标准答案
     * @param request           - HttpServletRequest对象
     * @return 包含试题创建结果的 Map<String, Boolean>对象
     */
    @RequestMapping(value = "/createProblem.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Object> createProblemAction(
            @RequestParam(value = "problemName") String problemName,
            @RequestParam(value = "description") String description,
            @RequestParam(value = "hint") String hint,
            @RequestParam(value = "problemTags") String problemTags,
            @RequestParam(value = "isPublic") boolean isPublic,
            @RequestParam(value = "problemType") boolean problemType,
            @RequestParam(value = "score") int score,
            @RequestParam(value = "answer") String answer,
            HttpServletRequest request)
    {
        Map<String, Object> result =
                problemService.createProblem(
                        isPublic,
                        problemName,
                        description,
                        hint,
                        problemType,
                        answer,
                        score,
                        problemTags);

        if ((boolean) result.get("isSuccessful"))
        {
            long problemId = (Long) result.get("problemId");
            String ipAddress = HttpRequestParser.getRemoteAddr(request);
            LOGGER.info(
                    String.format(
                            "Problem: [ProblemId=%s] was created by administrator at %s.",
                            new Object[]{problemId, ipAddress}));
        }
        return result;
    }

    /**
     * 加载编辑试题页面.
     *
     * @param problemId - 试题的唯一标识符
     * @param request   - HttpServletRequest对象
     * @param response  - HttpServletResponse对象
     * @return 包含提交列表页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/edit-problem/{problemId}", method = RequestMethod.GET)
    public ModelAndView editProblemsView(
            @PathVariable(value = "problemId") long problemId,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        Problem problem = problemService.getProblem(problemId);

        if (problem == null)
        {
            throw new ResourceNotFoundException();
        }
        List<ProblemTag> selectedProblemTags =
                problemService.getProblemTagsUsingProblemId(problemId);
        List<ProblemTag> problemTags = problemService.getProblemTags();

        ModelAndView view = new ModelAndView("administration/edit-problem");
        view.addObject("problem", problem);
        view.addObject("selectedProblemTags", selectedProblemTags);
        view.addObject("problemTags", problemTags);
        return view;
    }

    /**
     * 处理用户编辑试题的请求.
     *
     * @param isPublic          - 试题是否公开
     * @param problemName       - 试题名称
     * @param description       - 试题描述
     * @param hint              - 试题提示
     * @param problemType       - 试题类型
     * @param problemTags       - 试题标签((JSON 格式)
     * @param score             - 试题满分
     * @param answer            - 试题标准答案
     * @param request           - HttpServletRequest对象
     * @return 包含试题编辑结果的 Map<String, Boolean>对象
     */
    @RequestMapping(value = "/editProblem.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> editProblemAction(
            @RequestParam(value = "problemId") long problemId,
            @RequestParam(value = "problemName") String problemName,
            @RequestParam(value = "description") String description,
            @RequestParam(value = "hint") String hint,
            @RequestParam(value = "answer") String answer,
            @RequestParam(value = "problemType") boolean problemType,
            @RequestParam(value = "problemTags") String problemTags,
            @RequestParam(value = "score") int score,
            @RequestParam(value = "isPublic") boolean isPublic,
            HttpServletRequest request)
    {
        Map<String, Boolean> result =
                problemService.editProblem(
                        problemId,
                        isPublic,
                        problemName,
                        description,
                        hint,
                        problemType,
                        answer,
                        score,
                        problemTags);
        if (result.get("isSuccessful"))
        {
            String ipAddress = HttpRequestParser.getRemoteAddr(request);

            LOGGER.info(
                    String.format(
                            "Problem: [ProblemId=%s] was edited by administrator at %s.",
                            new Object[]{problemId, ipAddress}));
        }
        return result;
    }

    /**
     * 加载试题分类页面.
     *
     * @param request  - HttpServletRequest对象
     * @param response - HttpServletResponse对象
     * @return 包含试题分类页面信息的ModelAndView对象.
     */
    @RequestMapping(value = "/problem-categories", method = RequestMethod.GET)
    public ModelAndView problemCategoriesView(
            HttpServletRequest request, HttpServletResponse response)
    {
        List<ProblemTag> problemCategories = problemService.getProblemTags();

        ModelAndView view = new ModelAndView("administration/problem-categories");
        view.addObject("problemCategories", problemCategories);
        return view;
    }

    /**
     * 创建试题分类.
     *
     * @param problemTagSlug       - 试题分类的别名
     * @param problemTagName       - 试题分类的名称
     * @param request              - HttpServletRequest对象
     * @return 包含试题分类的创建结果的Map<String, Object>对象
     */
    @RequestMapping(value = "/createProblemTag.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Object> createProblemCategoryAction(
            @RequestParam(value = "problemTagSlug") String problemTagSlug,
            @RequestParam(value = "problemTagName") String problemTagName,
            HttpServletRequest request)
    {
        Map<String, Object> result =
                problemService.createProblemTag(problemTagSlug, problemTagName);
        if ((boolean) result.get("isSuccessful"))
        {
            long problemTagId = (Long) result.get("problemTagId");
            String ipAddress = HttpRequestParser.getRemoteAddr(request);

            LOGGER.info(
                    String.format(
                            "ProblemCategory: [ProblemCategoryId=%s] was created by administrator at %s.",
                            new Object[]{problemTagId, ipAddress}));
        }
        return result;
    }

    /**
     * 编辑试题分类.
     *
     * @param problemTagId           - 试题分类的唯一标识符
     * @param problemTagSlug         - 试题分类的别名
     * @param problemTagName         - 试题分类的名称
     * @param request                - HttpServletRequest对象
     * @return 包含试题分类的编辑结果的Map<String, Boolean>对象
     */
    @RequestMapping(value = "/editProblemTag.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> editProblemCategoryAction(
            @RequestParam(value = "problemTagId") String problemTagId,
            @RequestParam(value = "problemTagSlug") String problemTagSlug,
            @RequestParam(value = "problemTagName") String problemTagName,
            HttpServletRequest request)
    {
        Map<String, Boolean> result =
                problemService.editProblemTag(
                        Integer.parseInt(problemTagId),
                        problemTagSlug,
                        problemTagName);

        if (result.get("isSuccessful"))
        {
            String ipAddress = HttpRequestParser.getRemoteAddr(request);

            LOGGER.info(
                    String.format(
                            "ProblemCategory: [ProblemCategoryId=%s] was edited by administrator at %s.",
                            new Object[]{problemTagId, ipAddress}));
        }
        return result;
    }

    /**
     * 删除试题分类.
     *
     * @param problemTags - 试题分类的唯一标识符集合
     * @param request           - HttpServletRequest对象
     * @return 包含试题分类的删除结果的Map<String, Boolean>对象
     */
    @RequestMapping(value = "/deleteProblemTags.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Object> deleteProblemCategoryAction(
            @RequestParam(value = "problemTags") String problemTags,
            HttpServletRequest request)
    {
        Map<String, Object> result = new HashMap<>(3, 1);
        List<Integer> problemTagList = JSON.parseArray(problemTags, Integer.class);
        List<Integer> deletedProblemTags = new ArrayList<>();

        for (int problemTagId : problemTagList)
        {
            if (problemService.deleteProblemTag(problemTagId))
            {
                deletedProblemTags.add(problemTagId);
            }
            LOGGER.info(
                    String.format(
                            "ProblemCategory: [ProblemCategoryId=%s] was deleted by administrator at %s.",
                            new Object[]{problemTagId}));
        }
        result.put("isSuccessful", true);
        result.put("deletedProblemCategories", deletedProblemTags);
        return result;
    }

    /**
     * 加载提交列表页面.
     *
     * @param problemId  - 提交对应试题的唯一标识符
     * @param username   - 提交者的用户名
     * @param pageNumber - 当前页面的页码
     * @param request    - HttpServletRequest对象
     * @param response   - HttpServletResponse对象
     * @return 包含提交列表页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/all-submissions", method = RequestMethod.GET)
    public ModelAndView allSubmissionsView(
            @RequestParam(value = "problemId", required = false, defaultValue = "0") long problemId,
            @RequestParam(value = "username", required = false, defaultValue = "") String username,
            @RequestParam(value = "page", required = false, defaultValue = "1") long pageNumber,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        final int NUMBER_OF_SUBMISSIONS_PER_PAGE = 100;

        long totalSubmissions =
                submissionService.getNumberOfSubmissionsUsingProblemIdAndUsername(problemId, username);
        long latestSubmissionId = submissionService.getLatestSubmissionId();
        long offset =
                latestSubmissionId
                        - (pageNumber >= 1 ? pageNumber - 1 : 0) * NUMBER_OF_SUBMISSIONS_PER_PAGE;
        List<Submission> submissions =
                submissionService.getSubmissions(
                        problemId, username, offset, NUMBER_OF_SUBMISSIONS_PER_PAGE);

        ModelAndView view = new ModelAndView("administration/all-submissions");
        view.addObject("problemId", problemId);
        view.addObject("username", username);
        view.addObject("currentPage", pageNumber);
        view.addObject(
                "totalPages", (long) Math.ceil(totalSubmissions * 1.0 / NUMBER_OF_SUBMISSIONS_PER_PAGE));
        view.addObject("submissions", submissions);
        return view;
    }

    /**
     * 删除选定的提交记录.
     *
     * @param submissions - 提交记录ID的集合, 以逗号(, )分隔
     * @param request     - HttpServletRequest对象
     * @return 提交记录的删除结果
     */
    @RequestMapping(value = "/deleteSubmissions.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Object> deleteSubmissionsAction(
            @RequestParam(value = "submissions") String submissions, HttpServletRequest request)
    {
        Map<String, Object> result = new HashMap<>(3, 1);
        List<Long> submissionList = JSON.parseArray(submissions, Long.class);
        List<Long> deletedSubmissions = new ArrayList<>();

        for (Long submissionId : submissionList)
        {
            if (submissionService.deleteSubmission(submissionId))
            {
                deletedSubmissions.add(submissionId);
            }
            String ipAddress = HttpRequestParser.getRemoteAddr(request);
            LOGGER.info(
                    String.format(
                            "Submission: [SubmissionId=%s] deleted by administrator at %s.",
                            new Object[]{submissionId, ipAddress}));
        }
        result.put("isSuccessful", true);
        result.put("deletedSubmissions", deletedSubmissions);
        return result;
    }

    /**
     * 查看提交记录.
     *
     * @param submissionId - 提交记录的唯一标识符
     * @param request      - HttpServletRequest对象
     * @param response     - HttpServletResponse对象
     * @return 包含提交记录信息的ModelAndView对象
     */
    @RequestMapping(value = "/edit-submission/{submissionId}", method = RequestMethod.GET)
    public ModelAndView editSubmissionView(
            @PathVariable(value = "submissionId") long submissionId,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        Submission submission = submissionService.getSubmission(submissionId);
        if (submission == null)
        {
            throw new ResourceNotFoundException();
        }
        ModelAndView view = new ModelAndView("administration/edit-submission");
        view.addObject("submission", submission);
        view.addObject("csrfToken", CsrfProtector.getCsrfToken(request.getSession()));
        return view;
    }

    /**
     * 加载常规选项页面.
     *
     * @param request  - HttpRequest对象
     * @param response - HttpResponse对象
     * @return 包含常规选项页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/general-settings", method = RequestMethod.GET)
    public ModelAndView generalSettingsView(
            HttpServletRequest request, HttpServletResponse response)
    {
        ModelAndView view = new ModelAndView("administration/general-settings");
        view.addObject("options", getOptions());
        return view;
    }

    /**
     * 获取系统全部的选项, 以键值对的形式返回.
     *
     * @return 键值对形式的系统选项
     */
    private Map<String, String> getOptions()
    {
        Map<String, String> optionMap = new HashMap<>();
        List<Option> options = optionService.getOptions();

        for (Option option : options)
        {
            optionMap.put(option.getOptionName(), option.getOptionValue());
        }
        return optionMap;
    }

    /**
     * 更新网站常规选项.
     *
     * @param websiteName         - 网站名称
     * @param websiteDescription  - 网站描述
     * @param copyright           - 网站版权信息
     * @param allowUserRegister   - 是否允许用户注册
     * @param icpNumber           - 网站备案号
     * @param policeIcpNumber     - 公安备案号
     * @param googleAnalyticsCode - Google Analytics代码
     * @param offensiveWords      - 敏感词列表
     * @param request             - HttpServletRequest对象
     * @return 网站常规选项的更新结果
     */
    @RequestMapping(value = "/updateGeneralSettings.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> updateGeneralSettingsAction(
            @RequestParam(value = "websiteName") String websiteName,
            @RequestParam(value = "websiteDescription") String websiteDescription,
            @RequestParam(value = "copyright") String copyright,
            @RequestParam(value = "allowUserRegister") boolean allowUserRegister,
            @RequestParam(value = "icpNumber") String icpNumber,
            @RequestParam(value = "policeIcpNumber") String policeIcpNumber,
            @RequestParam(value = "googleAnalyticsCode") String googleAnalyticsCode,
            @RequestParam(value = "offensiveWords") String offensiveWords,
            HttpServletRequest request)
    {
        Map<String, Boolean> result =
                optionService.updateOptions(
                        websiteName,
                        websiteDescription,
                        copyright,
                        allowUserRegister,
                        icpNumber,
                        policeIcpNumber,
                        googleAnalyticsCode,
                        offensiveWords);
        return result;
    }

    /**
     * 自动注入的UserService对象.
     */
    @Autowired
    private UserService userService;

    /**
     * 自动注入的ProblemService对象. 用于获取试题记录信息.
     */
    @Autowired
    private ProblemService problemService;

    /**
     * 自动注入的SubmissionService对象. 用于获取提交记录信息.
     */
    @Autowired
    private SubmissionService submissionService;

    /**
     * 自动注入的OptionService对象. 用于获取系统中的设置选项.
     */
    @Autowired
    private OptionService optionService;

    /**
     * 日志记录器.
     */
    private static final Logger LOGGER = LogManager.getLogger(AdministrationController.class);
}