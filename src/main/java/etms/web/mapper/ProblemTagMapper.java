
package etms.web.mapper;

import etms.web.model.ProblemTag;
import etms.web.model.ProblemTagRelationship;
import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * ProblemTag Data Access Object.
 *
 */
@CacheNamespace(implementation = org.mybatis.caches.ehcache.EhcacheCache.class)
public interface ProblemTagMapper
{
    /**
     * 获取全部的题目分类.
     *
     * @return 包含全部题目分类的列表
     */
    List<ProblemTag> getProblemCategories();

    /**
     * 通过题目分类的唯一标识符获取题目分类对象.
     *
     * @param ProblemTagId - 题目分类的唯一标识符
     * @return 预期的题目分类对象或空引用
     */
    ProblemTag getProblemTagUsingCategoryId(int ProblemTagId);

    /**
     * 获取题目的分类列表.
     *
     * @param problemId - 题目的唯一标识符.
     * @return 包含题目分类的列表
     */
    List<ProblemTag> getProblemCategoriesUsingProblemId(long problemId);

    /**
     * 获取某个区间内各题目的分类.
     *
     * @param problemIdLowerBound - 题目ID区间的下界
     * @param problemIdUpperBound - 题目ID区间的上界
     * @return 包含题目分类信息的列表
     */
    List<ProblemTagRelationship> getProblemCategoriesOfProblems(
            @Param(value = "problemIdLowerBound") long problemIdLowerBound,
            @Param(value = "problemIdUpperBound") long problemIdUpperBound);

    /**
     * 通过题目分类的别名获取题目分类对象.
     *
     * @param ProblemTagSlug - 题目分类的别名
     * @return 预期的题目分类对象或空引用
     */
    ProblemTag getProblemTagUsingCategorySlug(String ProblemTagSlug);

    /**
     * 创建题目分类对象.
     *
     * @param ProblemTag - 待创建的题目分类对象
     */
    int createProblemTag(ProblemTag ProblemTag);

    /**
     * 创建题目及题目分类的关系.
     *
     * @param problemId       - 题目的唯一标识符
     * @param ProblemTag - 题目分类对象
     */
    int createProblemTagRelationship(
            @Param(value = "problemId") long problemId,
            @Param(value = "ProblemTag") ProblemTag ProblemTag);

    /**
     * 更新题目分类对象.
     *
     * @param ProblemTag - 待更新的题目分类对象
     */
    int updateProblemTag(ProblemTag ProblemTag);

    /**
     * 删除题目分类对象.
     *
     * @param ProblemTagId - 待删除题目分类对象的唯一标识符
     */
    int deleteProblemTag(int ProblemTagId);

    /**
     * 删除题目的全部分类关系.
     *
     * @param problemId - 题目的唯一标识符
     */
    int deleteProblemTagRelationship(long problemId);
}
