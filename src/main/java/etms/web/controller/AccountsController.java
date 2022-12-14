
package etms.web.controller;

import etms.web.exception.ResourceNotFoundException;
import etms.web.model.User;
import etms.web.service.OptionService;
import etms.web.service.SubmissionService;
import etms.web.service.UserService;
import etms.web.util.CsrfProtector;
import etms.web.util.DateUtils;
import etms.web.util.HttpRequestParser;
import etms.web.util.HttpSessionParser;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理用户的登录/注册请求.
 *
 */
@Controller
@RequestMapping(value = "/accounts")
public class AccountsController
{
    /**
     * 显示用户的登录页面.
     *
     * @param isLogout   - 是否处于登出状态
     * @param forwardUrl - 登录后跳转的地址(相对路径)
     * @param request    - HttpServletRequest对象
     * @param response   - HttpResponse对象
     * @return 包含登录页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView loginView(
            @RequestParam(value = "logout", required = false, defaultValue = "false") boolean isLogout,
            @RequestParam(value = "forward", required = false, defaultValue = "") String forwardUrl,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        HttpSession session = request.getSession();
        if (isLogout)
        {
            destroySession(request, session);
        }

        ModelAndView view = null;
        if (isLoggedIn(session))
        {
            RedirectView redirectView = new RedirectView(request.getContextPath());
            redirectView.setExposeModelAttributes(false);
            view = new ModelAndView(redirectView);
        } else
        {
            view = new ModelAndView("accounts/login");
            view.addObject("isLogout", isLogout);
            view.addObject("forwardUrl", forwardUrl);
        }
        return view;
    }

    /**
     * 为注销的用户销毁Session.
     *
     * @param request - HttpServletRequest对象
     * @param session - HttpSession 对象
     */
    private void destroySession(HttpServletRequest request, HttpSession session)
    {
        User currentUser = HttpSessionParser.getCurrentUser(request.getSession());
        session.setAttribute("isLoggedIn", false);
    }

    /**
     * 检查用户是否已经登录.
     *
     * @param session - HttpSession 对象
     * @return 用户是否已经登录
     */
    private boolean isLoggedIn(HttpSession session)
    {
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        return isLoggedIn != null && isLoggedIn;
    }

    /**
     * 处理用户的登录请求.
     *
     * @param username - 用户名
     * @param password - 密码
     * @param request  - HttpServletRequest对象
     * @return 一个包含登录验证结果的Map<String, Boolean>对象
     */
    @RequestMapping(value = "/login.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> loginAction(
            @RequestParam(value = "username") String username,
            @RequestParam(value = "password") String password,
            @RequestParam(value = "rememberMe") boolean isAutoLoginAllowed,
            HttpServletRequest request)
    {
        Map<String, Boolean> result = userService.isAllowedToLogin(username, password);
        if (result.get("isSuccessful"))
        {
            User user = userService.getUserUsingUsernameOrEmail(username);
            getSession(request, user, isAutoLoginAllowed);
        }
        return result;
    }

    /**
     * 为登录的用户创建Session.
     *
     * @param request            - HttpServletRequest对象
     * @param user               - 一个User对象, 包含用户的基本信息
     * @param isAutoLoginAllowed - 是否保存登录状态
     */
    private void getSession(HttpServletRequest request, User user, boolean isAutoLoginAllowed)
    {
        HttpSession session = request.getSession();
        session.setAttribute("isLoggedIn", true);
        session.setAttribute("isAutoLoginAllowed", isAutoLoginAllowed);
        session.setAttribute("uid", user.getUid());
    }

    /**
     * 显示用户注册的页面.
     *
     * @param request  - HttpServletRequest对象
     * @param response - HttpResponse对象
     * @return 包含注册页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView registerView(
            @RequestParam(value = "forward", required = false, defaultValue = "") String forwardUrl,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        HttpSession session = request.getSession();
        ModelAndView view = null;
        if (isLoggedIn(session))
        {
            RedirectView redirectView = new RedirectView(request.getContextPath());
            redirectView.setExposeModelAttributes(false);
            view = new ModelAndView(redirectView);
        } else
        {
            boolean isAllowRegister =
                    optionService.getOption("allowUserRegister").getOptionValue().equals("1");

            view = new ModelAndView("accounts/register");
            view.addObject("isAllowRegister", isAllowRegister);
            view.addObject("csrfToken", CsrfProtector.getCsrfToken(session));
        }
        return view;
    }

    /**
     * 处理用户注册的请求.
     *
     * @param username     - 用户名
     * @param password     - 密码
     * @param email        - 电子邮件地址
     * @param request      - HttpServletRequest对象
     * @return 一个包含账户创建结果的Map<String, Boolean>对象
     */
    @RequestMapping(value = "/register.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> registerAction(
            @RequestParam(value = "username") String username,
            @RequestParam(value = "password") String password,
            @RequestParam(value = "email") String email,
            HttpServletRequest request)
    {
        boolean isAllowRegister =
                optionService.getOption("allowUserRegister").getOptionValue().equals("1");
        String userGroupSlug = "users";
        Map<String, Boolean> result =
                userService.createUser(
                        username,
                        password,
                        email,
                        userGroupSlug,
                        isAllowRegister);

        if (result.get("isSuccessful"))
        {
            User user = userService.getUserUsingUsernameOrEmail(username);
            getSession(request, user, false);
        }
        return result;
    }

    /**
     * 加载用户的个人信息.
     *
     * @param userId   - 用户的唯一标识符
     * @param request  - HttpServletRequest对象
     * @param response - HttpResponse对象
     * @return 包含用户个人信息的ModelAndView对象
     */
    @RequestMapping(value = "/user/{userId}", method = RequestMethod.GET)
    public ModelAndView userView(
            @PathVariable("userId") long userId,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        User user = userService.getUserUsingUid(userId);

        ModelAndView view = new ModelAndView("accounts/user");
        view.addObject("user", user);
        view.addAllObjects(userService.getUserMetaUsingUid(user));

        view.addObject("submissions", submissionService.getSubmissionOfUser(userId));
        view.addObject("submissionStats", submissionService.getSubmissionStatsOfUser(userId));
        return view;
    }

    /**
     * 获取某个用户一段时间内的提交次数.
     *
     * @param userId  - 用户的唯一标识符
     * @param period  - 时间间隔的天数
     * @param request - HttpServletRequest对象
     * @return 包含某个用户提交次数与时间的 Map 对象
     */
    @RequestMapping(value = "/getNumberOfSubmissionsOfUsers.action", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, Object> getNumberOfSubmissionsOfUsersAction(
            @RequestParam(value = "uid", required = false, defaultValue = "0") long userId,
            @RequestParam(value = "period") int period,
            HttpServletRequest request)
    {
        if (userId == 0)
        {
            HttpSession session = request.getSession();
            userId = (Long) session.getAttribute("uid");
        }
        Map<String, Object> submissions = new HashMap<>(2, 1);
        Date today = new Date();
        Date previousDate = DateUtils.getPreviousDate(period);
        Map<String, Long> totalSubmissions =
                submissionService.getNumberOfSubmissionsUsingDate(previousDate, today, userId, false);
        Map<String, Long> acceptedSubmissions =
                submissionService.getNumberOfSubmissionsUsingDate(previousDate, today, userId, true);

        submissions.put("totalSubmissions", totalSubmissions);
        submissions.put("acceptedSubmissions", acceptedSubmissions);
        return submissions;
    }

    /**
     * 加载用户控制板页面.
     *
     * @param request  - HttpServletRequest对象
     * @param response - HttpResponse对象
     * @return 包含控制板页面信息的ModelAndView对象
     */
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public ModelAndView dashboardView(HttpServletRequest request, HttpServletResponse response)
    {
        HttpSession session = request.getSession();
        ModelAndView view = null;

        if (!isLoggedIn(session))
        {
            RedirectView redirectView = new RedirectView(request.getContextPath() + "/accounts/login");
            redirectView.setExposeModelAttributes(false);
            view = new ModelAndView(redirectView);
        }

        long userId = (Long) session.getAttribute("uid");
        User user = userService.getUserUsingUid(userId);
        view = new ModelAndView("accounts/dashboard");
        view.addObject("user", user);
        view.addAllObjects(userService.getUserMetaUsingUid(user));
        view.addObject("submissions", submissionService.getSubmissionOfUser(userId));

        return view;
    }

    /**
     * 处理用户修改密码的请求.
     *
     * @param oldPassword     - 旧密码
     * @param newPassword     - 新密码
     * @param confirmPassword - 确认新密码
     * @param request         - HttpServletRequest对象
     * @return 一个包含密码验证结果的Map<String, Boolean>对象
     */
    @RequestMapping(value = "/changePassword.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> changePasswordInDashboardAction(
            @RequestParam(value = "oldPassword") String oldPassword,
            @RequestParam(value = "newPassword") String newPassword,
            @RequestParam(value = "confirmPassword") String confirmPassword,
            HttpServletRequest request)
    {
        User currentUser = HttpSessionParser.getCurrentUser(request.getSession());

        Map<String, Boolean> result =
                userService.changePassword(currentUser, oldPassword, newPassword, confirmPassword);
        return result;
    }

    /**
     * 处理用户更改个人资料的请求.
     *
     * @param email       - 用户的电子邮件地址
     * @param request     - HttpServletRequest对象
     * @return 一个包含个人资料修改结果的Map<String, Boolean>对象
     */
    @RequestMapping(value = "/updateProfile.action", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, Boolean> updateProfileInDashboardAction(
            @RequestParam(value = "email") String email,
            HttpServletRequest request)
    {
        User currentUser = HttpSessionParser.getCurrentUser(request.getSession());
        Map<String, Boolean> result =
                userService.updateProfile(
                        currentUser, email);
        return result;
    }

    /**
     * 自动注入的UserService对象. 用于完成用户业务逻辑操作.
     */
    @Autowired
    private UserService userService;

    /**
     * 自动注入的SubmissionService对象. 用于加载个人信息页面用户的提交和通过情况.
     */
    @Autowired
    private SubmissionService submissionService;

    /**
     * 自动注入的OptionService对象. 用于查询注册功能是否开放.
     */
    @Autowired
    private OptionService optionService;

}
