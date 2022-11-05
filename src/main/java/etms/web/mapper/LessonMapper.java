package etms.web.mapper;


import etms.web.model.Lesson;
import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * User Data Access object
 */
@CacheNamespace(implementation = org.mybatis.caches.ehcache.EhcacheCache.class)
@Component
public interface LessonMapper
{
    /**
     * 使用唯一标识符获取课程
     * @param lessonId 课程唯一标识符
     * @return 课程
     */
    Lesson getLessonUsingLessonId(@Param("lessonId") long lessonId);

    /**
     * 使用讲师唯一标识符获取课程
     * @param lecturerId 讲师唯一标识符
     * @return 课程列表
     */
    List<Lesson> getLessonUsingLecturerId(@Param("lecturerId") long lecturerId);

    /**
     * 使用课程名获取课程
     * @param lessonName 课程名
     * @return 课程
     */
    Lesson getLessonUsingLessonName(@Param("lessonName") String lessonName);

    /**
     * 创建课程
     * @param lesson 课程
     * @return --
     */
    int createLesson(Lesson lesson);

    /**
     * 更新课程
     * @param lesson 课程
     * @return --
     */
    int updateLesson(Lesson lesson);

    /**
     * 删除课程
     * @param lessonId 课程唯一标识符
     * @return --
     */
    int deleteLesson(@Param("lessonId") long lessonId);
}
