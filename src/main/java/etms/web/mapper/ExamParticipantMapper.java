
package etms.web.mapper;

import etms.web.model.ExamParticipant;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * ExamParticipant Data Access Object.
 */
public interface ExamParticipantMapper
{
    /**
     * 获取某个考试的参赛人数.
     *
     * @param examId - 考试的唯一标识符
     * @return 某个考试的参赛人数
     */
    long getNumberOfParticipantsOfExam(long examId);

    /**
     * 获取某个考试的参赛者列表 (OI赛制).
     *
     * @param examId - 考试的唯一标识符
     * @param offset    - 起始参赛者的偏移量(offset)
     * @param limit     - 需要获取参赛者的数量
     * @return 某个考试的参赛者列表
     */
    List<ExamParticipant> getParticipantsOfExam(
            @Param("examId") long examId, @Param("offset") long offset, @Param("limit") int limit);


    /**
     * 获取某个选手在某个考试的参赛记录.
     *
     * @param examId     - 考试的唯一标识符
     * @param participantUid - 参赛者的用户唯一标识符
     * @return 对应的某个选手在某个考试的参赛记录
     */
    ExamParticipant getParticipantOfExam(
            @Param("examId") long examId, @Param("participantUid") long participantUid);

    /**
     * 创建参赛记录(用于参加考试).
     *
     * @param examParticipant - 待创建的参赛记录
     */
    int createExamParticipant(ExamParticipant examParticipant);

    /**
     * 更新参赛记录. 用于参加OI考试, 更新提交的源代码.
     *
     * @param examParticipant - 待更新的参赛记录
     */
    int updateExamParticipant(ExamParticipant examParticipant);

    /**
     * 删除参赛记录.
     *
     * @param examId     - 考试的唯一标识符
     * @param participantUid - 参赛者的用户唯一标识符
     */
    int deleteExamParticipant(
            @Param("examId") long examId, @Param("participantUid") long participantUid);

    /**
     * 删除比赛所有参赛记录
     * @param examId 考试的唯一标识符
     * @return
     */
    int deleteExamAllParticipant(
            @Param("examId") long examId);
}
