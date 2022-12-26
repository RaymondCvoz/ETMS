
package etms.web.mapper;

import etms.web.model.ExamParticipant;
import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * ExamParticipant Data Access Object.
 */
@CacheNamespace(implementation = org.mybatis.caches.ehcache.EhcacheCache.class)
@Mapper
public interface ExamParticipantMapper
{
    /**
     * 获取某个考试的参加人数.
     *
     * @param examId - 考试的唯一标识符
     * @return 某个考试的参加人数
     */
    long getNumberOfParticipantsOfExam(long examId);

    /**
     * 获取某个考试的参加者列表
     *
     * @param examId - 考试的唯一标识符
     * @return 某个考试的参加者列表
     */
    List<ExamParticipant> getParticipantsOfExam(
            @Param("examId") long examId);


    /**
     * 获取某个选手在某个考试的参加记录.
     *
     * @param examId     - 考试的唯一标识符
     * @param uid - 参加者的用户唯一标识符
     * @return 对应的某个选手在某个考试的参加记录
     */
    ExamParticipant getParticipantOfExam(
            @Param("examId") long examId, @Param("uid") long uid);

    /**
     * 创建参加记录(用于参加考试).
     *
     * @param examParticipant - 待创建的参加记录
     */
    int createExamParticipant(ExamParticipant examParticipant);

    /**
     * 更新参加记录. 用于参加OI考试, 更新提交的源代码.
     *
     * @param examParticipant - 待更新的参加记录
     */
    int updateExamParticipant(ExamParticipant examParticipant);

    /**
     * 删除参加记录.
     *
     * @param examId     - 考试的唯一标识符
     * @param participantUid - 参加者的用户唯一标识符
     */
    int deleteExamParticipant(
            @Param("examId") long examId, @Param("participantUid") long participantUid);

    /**
     * 删除比赛所有参加记录
     * @param examId 考试的唯一标识符
     * @return
     */
    int deleteExamAllParticipant(
            @Param("examId") long examId);
}
