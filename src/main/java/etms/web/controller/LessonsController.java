package etms.web.controller;
import etms.web.model.*;
import etms.web.service.LessonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理用户的查看课程/提交评测等请求.
 */
@Controller
@RequestMapping(value = "/lesson")
public class LessonsController
{
    /**
     * 显示课程库中的全部课程.
     * @param keyword             - 关键词
     * @param request             - HttpRequest对象
     * @param response            - HttpResponse对象
     * @return 包含课程库页面信息的ModelAndView对象
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView lessonsView(
            @RequestParam(value = "keyword", required = false) String keyword,
            HttpServletRequest request,
            HttpServletResponse response)
            throws UnsupportedEncodingException
    {
        List<Lesson> lessons =
                lessonService.getLessonsUsingFilters(keyword);
        long totalLessons =
                lessonService.getNumberOfLessonsUsingFilters(keyword);
        ModelAndView view = new ModelAndView("lessons/lessons");
        view.addObject("lessons", lessons)
                .addObject("totalLessons", totalLessons);
        return view;
    }

    /**
     * 获取课程的起始编号.
     *
     * @return 课程的起始编号
     */
    private long getFirstIndexOfLessons()
    {
        return lessonService.getFirstIndexOfLessons();
    }

    /**
     * 获取课程列表.
     *
     * @param request    - HttpRequest对象
     * @return 一个包含课程列表的HashMap对象
     */
    @RequestMapping(value = "/getLessons.action", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, Object> getLessonsAction(
            @RequestParam(value = "keyword", required = false) String keyword,
            HttpServletRequest request)
    {
        HttpSession session = request.getSession();
        List<Lesson> lessons =
                lessonService.getLessonsUsingFilters(keyword);
        Map<Long, Submission> submissionOfLessons = null;

        Map<String, Object> result = new HashMap<>(4, 1);
        result.put("isSuccessful", lessons != null && !lessons.isEmpty());
        result.put("lessons", lessons);
        return result;
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
     * 加载课程的详细信息.
     *
     * @param lessonId - 课程的唯一标识符
     * @param request   - HttpRequest对象
     * @param response  - HttpResponse对象
     * @return 包含课程详细信息的ModelAndView对象
     */
    @RequestMapping(value = "/{lessonId}", method = RequestMethod.GET)
    public ModelAndView lessonView(
            @PathVariable("lessonId") long lessonId,
            HttpServletRequest request,
            HttpServletResponse response)
    {
        HttpSession session = request.getSession();
        Lesson lesson = lessonService.getLesson(lessonId);
        ModelAndView view = new ModelAndView("lessons/lesson");
        view.addObject("lesson", lesson);
        return view;
    }

    /**
     * 自动注入的LessonService对象. 用于完成课程的逻辑操作.
     */
    @Autowired
    private LessonService lessonService;
}
