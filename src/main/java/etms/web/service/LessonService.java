
package etms.web.service;

import etms.web.mapper.LessonMapper;
import etms.web.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;
@Service
@Transactional
public class LessonService
{
    /**
     * 获取课程的起始编号.
     *
     * @return 课程的起始编号
     */
    public long getFirstIndexOfLessons()
    {
        return lessonMapper.getLowerBoundOfLessons();
    }

    /**
     * 获取课程的结束编号.
     * @return 课程的结束编号
     */
    public long getLastIndexOfLessonsAdmin()
    {
        return lessonMapper.getUpperBoundOfLessons();
    }

    /**
     * 通过课程的唯一标识符获取课程的详细信息.
     *
     * @param lessonId - 课程的唯一标识符
     * @return 课程的详细信息
     */
    public Lesson getLesson(long lessonId)
    {
        return lessonMapper.getLesson(lessonId);
    }

    /**
     * 获取课程列表.
     *
     * @param keyword             - 关键字
     * @return 课程列表(List < Lesson > 对象)
     */
    public List<Lesson> getLessonsUsingFilters(
            String keyword)
    {
        return lessonMapper.getLessonsUsingFilters(
                keyword);
    }

    /**
     * 获取课程列表.
     *
     * @param keyword             - 关键字
     * @return 课程列表(List < Lesson > 对象)
     */
    public List<Lesson> getLessonsUsingFiltersAdmin(
            String keyword)
    {
        long lessonTagId = 0;
        return lessonMapper.getLessonsUsingFiltersAdmin(
                keyword);
    }

    /**
     * 获取课程的总数量.
     *
     * @param keyword             - 关键字
     * @return 课程的总数量
     */
    public long getNumberOfLessonsUsingFilters(
            String keyword)
    {
        long lessonTagId = 0;
        return lessonMapper.getNumberOfLessonsUsingFilters(keyword);
    }


    /**
     * [此方法仅供管理员使用] 获取全部课程的总数量.
     *
     * @return 全部课程的总数量
     */
    public long getNumberOfLessons()
    {
        return lessonMapper.getNumberOfLessons();
    }

    /**
     * 创建课程
     * @param lessonName 课程名称
     * @param description 课程描述
     * @return 包含课程创建结果的map对象
     */
    public Map<String, Object> createLesson(
            String lessonName,
            String description)
    {
        Lesson lesson =
                new Lesson(
                        lessonName,
                        description);
        @SuppressWarnings("unchecked")
        Map<String, Object> result = (Map<String, Object>) getLessonCreationResult(lesson);

        if ((boolean) result.get("isSuccessful"))
        {
            lessonMapper.createLesson(lesson);
            long lessonId = lesson.getLessonId();
            result.put("lessonId", lessonId);
        }
        return result;
    }

    /**
     * 检查课程信息是否合法.
     *
     * @param lesson - 待创建的课程
     * @return 包含课程创建结果的Map<String, Boolean>对象
     */
    private Map<String, ? extends Object> getLessonCreationResult(Lesson lesson)
    {
        Map<String, Boolean> result = new HashMap<>();
        result.put("isLessonNameEmpty", lesson.getLessonName().isEmpty());
        result.put("isLessonNameLegal", isLessonNameLegal(lesson.getLessonName()));
        result.put("isDescriptionEmpty", lesson.getDescription().isEmpty());

        boolean isSuccessful =
                !result.get("isLessonNameEmpty")
                        && result.get("isLessonNameLegal")
                        && !result.get("isDescriptionEmpty");
        result.put("isSuccessful", isSuccessful);
        return result;
    }

    /**
     * 编辑课程.
     *
     * @param lessonId         - 课程唯一标识符
     * @param lessonName       - 课程名称
     * @param description       - 课程描述
     * @param hint              - 课程提示
     * @param lessonTags       - 课程标签(JSON)
     * @param isPublic          - 课程是否公开
     * @return 包含课程创建结果的Map<String, Object>对象
     */
    public Map<String, Boolean> editLesson(
            long lessonId,
            boolean isPublic,
            String lessonName,
            String description,
            String hint,
            boolean lessonType,
            String answer,
            int score,
            String lessonTags)
    {
        Lesson lesson =
                new Lesson(
                        lessonId,
                        lessonName,
                        description);
        Map<String, Boolean> result = getLessonEditResult(lesson);

        if (result.get("isSuccessful"))
        {
            lessonMapper.updateLesson(lesson);
            System.out.println(lessonTags);
        }
        return result;
    }

    /**
     * 检查课程信息是否合法.
     *
     * @param lesson - 待编辑的课程
     * @return 包含课程编辑结果的Map<String, Boolean>对象
     */
    private Map<String, Boolean> getLessonEditResult(Lesson lesson)
    {
        @SuppressWarnings("unchecked")
        Map<String, Boolean> result = (Map<String, Boolean>) getLessonCreationResult(lesson);

        long lessonId = lesson.getLessonId();
        if (lessonMapper.getLesson(lessonId) != null)
        {
            result.put("isLessonExists", true);
        } else
        {
            result.put("isLessonExists", false);
            result.put("isSuccessful", false);
        }
        return result;
    }

    /**
     * 检查课程名称的合法性.
     *
     * @param lessonName - 课程名称
     * @return 课程名称是否合法
     */
    private boolean isLessonNameLegal(String lessonName)
    {
        return lessonName.length() <= 128;
    }

    /**
     * [此方法仅供管理员使用] 删除指定的课程.
     *
     * @param lessonId - 课程的唯一标识符
     */
    public void deleteLesson(long lessonId)
    {
        lessonMapper.deleteLesson(lessonId);
    }

    /**
     * 自动注入的LessonMapper对象.
     */
    @Autowired
    private LessonMapper lessonMapper;

}
