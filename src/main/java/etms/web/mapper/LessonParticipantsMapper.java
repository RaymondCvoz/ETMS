package etms.web.mapper;

import etms.web.model.LessonParticipant;
import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * User Data Access Object
 */
@CacheNamespace(implementation = org.mybatis.caches.ehcache.EhcacheCache.class)
@Component
public interface LessonParticipantsMapper
{
    /**
     *根据课程唯一标识符获取课程学生对应关系
     * @param lessonId 课程唯一标识符
     * @return 课程学生对应关系列表
     */
    List<LessonParticipant> getLessonParticipantUsingLessonId(@Param("lessonId") long lessonId);

    /**
     * 根据学生唯一标识符获取课程学生对应关系
     * @param participantId 学生唯一标识符
     * @return 课程学生对应关系列表
     */
    List<LessonParticipant> getLessonParticipantUsingParticipantId(@Param("participantId") long participantId);

    /**
     * 根据课程和学生唯一标识符获取课程学生对应关系
     * @param participantId 学生唯一标识符
     * @param lessonId 课程唯一标识符
     * @return 课程学生对应关系列表
     */
    List<LessonParticipant> getLessonParticipantUsingLessonIdAndParticipantId(@Param("participantId") long participantId,
                                                                              @Param("lessonId") long lessonId);

    /**
     * 创建课程学生对应关系
     * @param lessonParticipant 课程学生对应关系
     * @return --
     */
    int createLessonParticipant(LessonParticipant lessonParticipant);

    /**
     * 删除课程学生对应关系
     * @param lessonParticipant 课程学生对应关系
     * @return --
     */
    int deleteLessonParticipant(LessonParticipant lessonParticipant);
}
