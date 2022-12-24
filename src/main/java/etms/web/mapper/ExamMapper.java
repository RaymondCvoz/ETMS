
package etms.web.mapper;

import etms.web.model.Exam;
import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * Exam Data Access Object.
 *
 */
@CacheNamespace(implementation = org.mybatis.caches.ehcache.EhcacheCache.class)
@Mapper
public interface ExamMapper
{
    /**
     * [此方法仅供管理员使用] 获取考试的总数量.
     *
     * @param keyword - 考试的关键词
     * @return 考试的总数量
     */
    long getNumberOfExams(@Param("keyword") String keyword);

    /**
     * 获取考试列表.
     *
     * @param keyword - 考试的关键词
     * @return 预期的考试对象
     */
    List<Exam> getExams(
            @Param("keyword") String keyword);

    /**
     * 根据考试的唯一标识符获取考试.
     *
     * @param examId - 考试的唯一标识符
     * @return 预期的考试对象
     */
    Exam getExam(long examId);

    /**
     * 创建考试.
     *
     * @param exam - 待创建的考试对象
     */
    int createExam(Exam exam);

    /**
     * 更新考试.
     *
     * @param exam - 待更新的考试对象
     */
    int updateExam(Exam exam);

    /**
     * 删除考试.
     *
     * @param examId - 考试的唯一标识符
     */
    int deleteExam(long examId);

}
