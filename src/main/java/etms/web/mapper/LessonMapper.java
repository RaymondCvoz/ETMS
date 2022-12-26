
package etms.web.mapper;

import etms.web.model.Lesson;
import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Lesson Data Access Object.
 *
 */
@CacheNamespace(implementation = org.mybatis.caches.ehcache.EhcacheCache.class)
public interface LessonMapper
{
    /**
     * [此方法仅供管理员使用] 获取全部课程的总数量.
     *
     * @return 全部课程的总数量
     */
    long getNumberOfLessons();

    /**
     * 根据筛选条件获取课程的总数量.
     *
     * @param keyword           - 关键词
     * @return 符合筛选条件课程的总数量
     */
    long getNumberOfLessonsUsingFilters(
            @Param("keyword") String keyword);

    /**
     * 获取第一个课程的ID.
     *
     * @return 第一个课程的ID
     */
    long getLowerBoundOfLessons();

    /**
     * 获取最后一个课程的ID.
     *
     * @return 最后一个课程的ID
     */
    long getUpperBoundOfLessons();

    /**
     * 获取某个课程区间内最后一个课程的ID.
     *
     * @param isPublic     - 是否只筛选公开课程
     * @param offset       - 课程唯一标识符的起始编号
     * @param limit        - 需要获取的课程的数量
     * @return 某个课程区间内最后一个课程的ID
     */
    long getUpperBoundOfLessonsWithLimit(
            @Param("isPublic") boolean isPublic,
            @Param("lessonId") long offset,
            @Param("limit") int limit);

    /**
     * 通过课程唯一标识符获取课程对象.
     *
     * @param lessonId - 课程的唯一标识符
     * @return 一个课程对象
     */
    Lesson getLesson(@Param("lessonId") long lessonId);

    /**
     * 通过课程唯一标识符和关键字获取某个范围内的所有课程.
     *
     * @param keyword           - 关键词
     * @return 某个范围内的符合条件的课程
     */
    List<Lesson> getLessonsUsingFilters(
            @Param("keyword") String keyword);

    /**
     * 通过课程唯一标识符和关键字获取某个范围内的所有课程.
     *
     * @param keyword           - 关键词
     * @return 某个范围内的符合条件的课程
     */
    List<Lesson> getLessonsUsingFiltersAdmin(
            @Param("keyword") String keyword);

    /**
     * 创建一个新的课程对象.
     *
     * @param lesson - 课程对象
     * @return 操作是否成功完成
     */
    int createLesson(Lesson lesson);

    /**
     * 更新课程信息.
     *
     * @param lesson - 课程对象
     * @return 操作是否成功完成
     */
    int updateLesson(Lesson lesson);

    /**
     * 通过课程的唯一标识符删除一个课程对象.
     *
     * @param lessonId - 课程的唯一标识符
     * @return 操作是否成功完成
     */
    int deleteLesson(@Param("lessonId") long lessonId);
}
