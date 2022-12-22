
package etms.web.mapper;

import etms.web.model.ExamSubmission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * ExamSubmission Data Access Object.
 *
 */
public interface ExamSubmissionMapper
{
    /**
     * 获取某场竞赛的提交记录.
     *
     * @param examId - 竞赛的唯一标识符
     * @return 包含竞赛提交记录(ExamSubmission)的List对象
     */
    List<ExamSubmission> getSubmissionsOfExam(@Param("examId") long examId);

    /**
     * 获取某场竞赛AC的提交记录.
     *
     * @param examId - 竞赛的唯一标识符
     * @return 包含AC竞赛提交记录(ExamSubmission)的List对象
     */
    List<ExamSubmission> getAcceptedSubmissionsOfExam(@Param("examId") long examId);

    /**
     * 获取某场竞赛某个参赛者的提交记录.
     *
     * @param examId     - 竞赛的唯一标识符
     * @param participantUid - 参赛者用户的唯一标识符
     * @return 包含某竞赛某参赛者提交记录(ExamSubmission)的List对象
     */
    List<ExamSubmission> getSubmissionOfExamOfExam(
            @Param("examId") long examId, @Param("participantUid") long participantUid);

    /**
     * 获取某场竞赛某个参赛者对某个试题的提交记录.
     *
     * @param examId     - 竞赛的唯一标识符
     * @param problemId     - 试题的唯一标识符
     * @param participantUid - 参赛者用户的唯一标识符
     * @return 包含某竞赛某参赛者提交记录(ExamSubmission)的List对象
     */
    List<ExamSubmission> getSubmissionOfExamOfExamProblem(
            @Param("examId") long examId,
            @Param("problemId") long problemId,
            @Param("participantUid") long participantUid);

    /**
     * 创建提交记录.
     *
     * @param examSubmission - 待创建的提交记录
     */
    int createExamSubmission(ExamSubmission examSubmission);

    /**
     * 删除竞赛提交记录.
     *
     * @param examId    - 竞赛的唯一标识符
     * @param submissionId - 提交记录的唯一标识符
     */
    int deleteExamSubssion(
            @Param("examId") long examId, @Param("submissionId") long submissionId);
}
