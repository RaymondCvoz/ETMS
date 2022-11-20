
package etms.web.aspect;

import etms.web.model.Option;
import etms.web.model.User;
import etms.web.service.OptionService;
import etms.web.service.SubmissionService;
import etms.web.service.UserService;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 视图的切面类. 在加载页面前加载已登录用户的个人信息及答题情况.
 *
 */
@Aspect
public class ViewAspect
{
    @Around(
            value =
                    "execution(* etms.web.controller.*.*View(..)) && args(.., request,"
                            + " response)")
    /**
     * 加载已登录用户的个人信息及答题情况.
     *
     * @param proceedingJoinPoint - ProceedingJoinPoint对象
     * @param request             - HttpRequest对象
     * @param response            - HttpResponse对象
     * @return 一个包含预期视图的ModelAndView对象
     * @throws Throwable - ResourceNotFound异常
     */
    public ModelAndView getUserProfile(
            ProceedingJoinPoint proceedingJoinPoint,
            HttpServletRequest request,
            HttpServletResponse response)
            throws Throwable
    {
        ModelAndView view = null;
        HttpSession session = request.getSession();

        view = (ModelAndView) proceedingJoinPoint.proceed();
        view.addAllObjects(getSystemOptions());
        boolean isLoggedIn = isLoggedIn(session);
        if (isLoggedIn)
        {
            long userId = (Long) session.getAttribute("uid");
            User user = userService.getUserUsingUid(userId);
            view.addObject("isLogin", true)
                    .addObject("myProfile", user)
                    .addObject("mySubmissionStats", submissionService.getSubmissionStatsOfUser(userId));
        }
        return view;
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
     * 加载系统定义的选项(Option).
     *
     * @return 包含系统定义选项的键值对列表
     */
    private Map<String, String> getSystemOptions()
    {
        List<Option> options = optionService.getOptions();
        Map<String, String> optionMap = new HashMap<>();

        for (Option option : options)
        {
            String key = option.getOptionName();
            String value = option.getOptionValue();
            optionMap.put(key, value);
        }
        return optionMap;
    }


    /**
     * 自动注入的UserService对象.
     */
    @Autowired
    private UserService userService;

    /**
     * 自动注入的SubmissionService对象.
     */
    @Autowired
    private SubmissionService submissionService;

    /**
     * 自动注入的OptionService对象.
     */
    @Autowired
    private OptionService optionService;
}
