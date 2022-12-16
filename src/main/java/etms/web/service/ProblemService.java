
package etms.web.service;

import etms.web.mapper.ProblemTagMapper;
import etms.web.mapper.ProblemMapper;
import etms.web.model.*;
import etms.web.util.SlugifyUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class ProblemService
{
    /**
     * 获取试题的起始编号.
     *
     * @return 试题的起始编号
     */
    public long getFirstIndexOfProblems()
    {
        return problemMapper.getLowerBoundOfProblems();
    }

    /**
     * 获取试题的结束编号.
     *
     * @param isPublic     - 是否只筛选公开试题
     * @param offset       - 试题唯一标识符的起始序号
     * @param limit        - 每次加载试题的数量
     * @return 试题的结束编号
     */
    public long getLastIndexOfProblems(boolean isPublic, long offset, int limit)
    {
        return problemMapper.getUpperBoundOfProblemsWithLimit(isPublic, offset, limit);
    }

    /**
     * 获取试题的结束编号.
     * @return 试题的结束编号
     */
    public long getLastIndexOfProblemsAdmin()
    {
        return problemMapper.getUpperBoundOfProblems();
    }

    /**
     * 通过试题的唯一标识符获取试题的详细信息.
     *
     * @param problemId - 试题的唯一标识符
     * @return 试题的详细信息
     */
    public Problem getProblem(long problemId)
    {
        return problemMapper.getProblem(problemId);
    }

    /**
     * 获取试题列表.
     *
     * @param offset              - 试题唯一标识符的起始序号
     * @param keyword             - 关键字
     * @param problemTagSlug      - 试题标签的别名
     * @param isPublic            - 是否只筛选公开试题
     * @param limit               - 每次加载试题的数量
     * @return 试题列表(List < Problem > 对象)
     */
    public List<Problem> getProblemsUsingFilters(
            long offset,
            String keyword,
            String problemTagSlug,
            boolean isPublic,
            int limit)
    {
        ProblemTag problemTag =
                problemTagMapper.getProblemTagUsingTagSlug(problemTagSlug);
        long problemTagId = 0;
        if (offset < 0)
        {
            offset = 0;
        }

        if (problemTag != null)
        {
            problemTagId = problemTag.getProblemTagId();
        }
        return problemMapper.getProblemsUsingFilters(
                keyword, problemTagId, isPublic, offset, limit);
    }

    /**
     * 获取试题列表.
     *
     * @param keyword             - 关键字
     * @param problemTagSlug      - 试题标签的别名
     * @return 试题列表(List < Problem > 对象)
     */
    public List<Problem> getProblemsUsingFiltersAdmin(
            String keyword,
            String problemTagSlug)
    {
        ProblemTag problemTag =
                problemTagMapper.getProblemTagUsingTagSlug(problemTagSlug);
        long problemTagId = 0;
        if (problemTag != null)
        {
            problemTagId = problemTag.getProblemTagId();
        }
        return problemMapper.getProblemsUsingFiltersAdmin(
                keyword, problemTagId);
    }

    /**
     * 获取试题的总数量.
     *
     * @param keyword             - 关键字
     * @param ProblemTagSlug      - 试题分类的别名
     * @param isPublic            - 是否只筛选公开试题
     * @return 试题的总数量
     */
    public long getNumberOfProblemsUsingFilters(
            String keyword, String ProblemTagSlug, boolean isPublic)
    {
        ProblemTag ProblemTag =
                ProblemTagMapper.getProblemTagUsingTagSlug(ProblemTagSlug);
        long problemTagId = 0;
        if (ProblemTag != null)
        {
            problemTagId = ProblemTag.getProblemTagId();
        }
        return problemMapper.getNumberOfProblemsUsingFilters(keyword, problemTagId, isPublic);
    }

    /**
     * 获取某个区间内各试题的分类.
     *
     * @param problemIdLowerBound - 试题ID区间的下界
     * @param problemIdUpperBound - 试题ID区间的上界
     * @return 包含试题分类信息的列表
     */
    public Map<Long, List<ProblemTag>> getProblemTagsOfProblems(
            long problemIdLowerBound, long problemIdUpperBound)
    {
        List<ProblemTagRelationship> ProblemTagRelationships =
                ProblemTagMapper.getProblemTagsOfProblems(
                        problemIdLowerBound, problemIdUpperBound);

        Map<Long, List<ProblemTag>> problemTagsOfProblems = new HashMap<>();
        for (ProblemTagRelationship pcr : ProblemTagRelationships)
        {
            long problemId = pcr.getProblemId();
            if (!problemTagsOfProblems.containsKey(problemId))
            {
                problemTagsOfProblems.put(problemId, new ArrayList<ProblemTag>());
            }

            List<ProblemTag> problemTags = problemTagsOfProblems.get(problemId);
            problemTags.add(
                    new ProblemTag(
                            pcr.getProblemTagId(),
                            pcr.getProblemTagSlug(),
                            pcr.getProblemTagName()));
        }
        return problemTagsOfProblems;
    }

    /**
     * 获取试题的分类列表.
     *
     * @param problemId - 试题的唯一标识符.
     * @return 包含试题分类的列表
     */
    public List<ProblemTag> getProblemTagsUsingProblemId(long problemId)
    {
        return ProblemTagMapper.getProblemTagsUsingProblemId(problemId);
    }


    /**
     * 获取全部的试题分类.
     *
     * @return 包含全部试题分类的列表
     */
    public List<ProblemTag> getProblemTags()
    {
        return ProblemTagMapper.getProblemTags();
    }

    /**
     * [此方法仅供管理员使用] 获取全部试题的总数量.
     *
     * @return 全部试题的总数量
     */
    public long getNumberOfProblems()
    {
        return problemMapper.getNumberOfProblems();
    }

    /**
     * 创建试题
     * @param isPublic 是否公开
     * @param problemName 试题名称
     * @param description 试题描述
     * @param hint 试题提示
     * @param problemType 试题类型
     * @param answer 试题答案
     * @param problemTags 试题类别
     * @param score 试题满分
     * @return 包含试题创建结果的map对象
     */
    public Map<String, Object> createProblem(
            boolean isPublic,
            String problemName,
            String description,
            String hint,
            int problemType,
            String answer,
            int score,
            String problemTags)
    {
        Problem problem =
                new Problem(
                        isPublic,
                        problemName,
                        description,
                        hint,
                        problemType,
                        answer,
                        score);
        @SuppressWarnings("unchecked")
        Map<String, Object> result = (Map<String, Object>) getProblemCreationResult(problem);

        if ((boolean) result.get("isSuccessful"))
        {
            problemMapper.createProblem(problem);
            long problemId = problem.getProblemId();
            createProblemTagRelationships(problemId, problemTags);
            createProblemTags(problemId, problemTags);

            result.put("problemId", problemId);
        }
        return result;
    }

    /**
     * 检查试题信息是否合法.
     *
     * @param problem - 待创建的试题
     * @return 包含试题创建结果的Map<String, Boolean>对象
     */
    private Map<String, ? extends Object> getProblemCreationResult(Problem problem)
    {
        Map<String, Boolean> result = new HashMap<>();
        result.put("isProblemNameEmpty", problem.getProblemName().isEmpty());
        result.put("isProblemNameLegal", isProblemNameLegal(problem.getProblemName()));
        result.put("isDescriptionEmpty", problem.getDescription().isEmpty());

        boolean isSuccessful =
                !result.get("isProblemNameEmpty")
                        && result.get("isProblemNameLegal")
                        && !result.get("isDescriptionEmpty");
        result.put("isSuccessful", isSuccessful);
        return result;
    }

    /**
     * 编辑试题.
     *
     * @param problemId         - 试题唯一标识符
     * @param problemName       - 试题名称
     * @param description       - 试题描述
     * @param hint              - 试题提示
     * @param problemTags       - 试题标签(JSON)
     * @param isPublic          - 试题是否公开
     * @return 包含试题创建结果的Map<String, Object>对象
     */
    public Map<String, Boolean> editProblem(
            long problemId,
            boolean isPublic,
            String problemName,
            String description,
            String hint,
            int problemType,
            String answer,
            int score,
            String problemTags)
    {
        Problem problem =
                new Problem(
                        problemId,
                        isPublic,
                        problemName,
                        description,
                        hint,
                        problemType,
                        answer,
                        score);
        Map<String, Boolean> result = getProblemEditResult(problem);

        if (result.get("isSuccessful"))
        {
            problemMapper.updateProblem(problem);
            updateProblemTagRelationships(problemId, problemTags);
            updateProblemTags(problemId, problemTags);
        }
        return result;
    }

    /**
     * 检查试题信息是否合法.
     *
     * @param problem - 待编辑的试题
     * @return 包含试题编辑结果的Map<String, Boolean>对象
     */
    private Map<String, Boolean> getProblemEditResult(Problem problem)
    {
        @SuppressWarnings("unchecked")
        Map<String, Boolean> result = (Map<String, Boolean>) getProblemCreationResult(problem);

        long problemId = problem.getProblemId();
        if (problemMapper.getProblem(problemId) != null)
        {
            result.put("isProblemExists", true);
        } else
        {
            result.put("isProblemExists", false);
            result.put("isSuccessful", false);
        }
        return result;
    }



    /**
     * 创建试题所属分类.
     *
     * @param problemId         - 试题的唯一标识符
     * @param problemTags - 试题分类别名的JSON数组
     */
    private void createProblemTagRelationships(long problemId, String problemTags)
    {
        JSONArray jsonArray = JSON.parseArray(problemTags);
        if (jsonArray.size() == 0)
        {
            jsonArray.add("uncategorized");
        }
        for (int i = 0; i < jsonArray.size(); ++i)
        {
            String ProblemTagSlug = jsonArray.getString(i);
            ProblemTag pc =
                    ProblemTagMapper.getProblemTagUsingTagSlug(ProblemTagSlug);

            ProblemTagMapper.createProblemTagRelationship(problemId, pc);
        }
    }

    /**
     * 更新试题所属分类. 首先删除该试题的全部分类, 然后重新创建分类关系.
     *
     * @param problemId         - 试题的唯一标识符
     * @param problemTags - 试题分类别名的JSON数组
     */
    private void updateProblemTagRelationships(long problemId, String problemTags)
    {
        ProblemTagMapper.deleteProblemTagRelationship(problemId);
        createProblemTagRelationships(problemId, problemTags);
    }

    /**
     * 创建试题标签.
     *
     * @param problemId   - 试题的唯一标识符
     * @param problemTags - 试题标签的JSON数组
     */
    private void createProblemTags(long problemId, String problemTags)
    {
        Set<String> problemTagSlugs = new HashSet<>();
        JSONArray jsonArray = JSON.parseArray(problemTags);

        for (int i = 0; i < jsonArray.size(); ++i)
        {
            String problemTagName = jsonArray.getString(i);
            String problemTagSlug = SlugifyUtils.getSlug(problemTagName);

            ProblemTag pt = problemTagMapper.getProblemTagUsingTagSlug(problemTagSlug);
            if (pt == null)
            {
                pt = new ProblemTag(problemTagSlug, problemTagName);
                problemTagMapper.createProblemTag(pt);
            }
            // Fix Bug: Two tags have different tag name but the same tag slug.
            // Example: Hello World / Hello-World
            if (!problemTagSlugs.contains(problemTagSlug))
            {
                problemTagMapper.createProblemTagRelationship(problemId, pt);
                problemTagSlugs.add(problemTagSlug);
            }
        }
    }

    /**
     * 更新试题标签. 首先删除该试题的全部标签, 然后重新创建标签与试题的关系.
     *
     * @param problemId   - 试题的唯一标识符
     * @param problemTags - 试题标签的JSON数组
     */
    private void updateProblemTags(long problemId, String problemTags)
    {
        problemTagMapper.deleteProblemTagRelationship(problemId);
        createProblemTags(problemId, problemTags);
    }

    /**
     * 检查试题名称的合法性.
     *
     * @param problemName - 试题名称
     * @return 试题名称是否合法
     */
    private boolean isProblemNameLegal(String problemName)
    {
        return problemName.length() <= 128;
    }

    /**
     * [此方法仅供管理员使用] 删除指定的试题.
     *
     * @param problemId - 试题的唯一标识符
     */
    public void deleteProblem(long problemId)
    {
        problemMapper.deleteProblem(problemId);
    }

    /**
     * [此方法仅供管理员使用] 创建试题分类.
     *
     * @param ProblemTagSlug       - 试题分类的别名
     * @param ProblemTagName       - 试题分类的名称
     * @return 包含试题分类创建结果的Map<String, Object>对象
     */
    public Map<String, Object> createProblemTag(
            String ProblemTagSlug, String ProblemTagName)
    {
        ProblemTag ProblemTag =
                new ProblemTag(ProblemTagSlug, ProblemTagName);
        @SuppressWarnings("unchecked")
        Map<String, Object> result =
                (Map<String, Object>) getProblemTagCreationResult(ProblemTag);

        if ((boolean) result.get("isSuccessful"))
        {
            ProblemTagMapper.createProblemTag(ProblemTag);

            long ProblemTagId = ProblemTag.getProblemTagId();
            result.put("ProblemTagId", ProblemTagId);
        }
        return result;
    }

    /**
     * 检查欲创建的试题分类对象各字段的合法性.
     *
     * @param ProblemTag - 欲创建的试题分类对象
     * @return 包含试题分类对象各字段验证结果的Map<String, Boolean>对象
     */
    private Map<String, ? extends Object> getProblemTagCreationResult(
            ProblemTag ProblemTag)
    {
        Map<String, Boolean> result = new HashMap<>(6, 1);
        result.put("isProblemTagSlugEmpty", ProblemTag.getProblemTagSlug().isEmpty());
        result.put(
                "isProblemTagSlugLegal",
                isProblemTagSlugLegal(ProblemTag.getProblemTagSlug()));
        result.put(
                "isProblemTagSlugExists",
                isProblemTagSlugExists(ProblemTag.getProblemTagSlug()));
        result.put("isProblemTagNameEmpty", ProblemTag.getProblemTagName().isEmpty());
        result.put(
                "isProblemTagNameLegal",
                isProblemTagNameLegal(ProblemTag.getProblemTagName()));

        boolean isSuccessful =
                !result.get("isProblemTagSlugEmpty")
                        && result.get("isProblemTagSlugLegal")
                        && !result.get("isProblemTagSlugExists")
                        && !result.get("isProblemTagNameEmpty")
                        && result.get("isProblemTagNameLegal");
        result.put("isSuccessful", isSuccessful);
        return result;
    }

    /**
     * [此方法仅供管理员使用] 编辑试题分类.
     *
     * @param ProblemTagId         - 试题分类的唯一标识符
     * @param ProblemTagSlug       - 试题分类的别名
     * @param ProblemTagName       - 试题分类的名称
     * @return 包含试题分类编辑结果的Map<String, Boolean>对象
     */
    public Map<String, Boolean> editProblemTag(
            int ProblemTagId,
            String ProblemTagSlug,
            String ProblemTagName)
    {

        ProblemTag ProblemTag =
                new ProblemTag(
                        ProblemTagId, ProblemTagSlug, ProblemTagName);

        Map<String, Boolean> result = getProblemTagEditResult(ProblemTag);

        if (result.get("isSuccessful"))
        {
            ProblemTagMapper.updateProblemTag(ProblemTag);
        }
        return result;
    }

    /**
     * 获取试题分类的编辑结果.
     *
     * @param ProblemTag - 待编辑的试题分类对象
     * @return 包含试题分类编辑结果的Map<String, Boolean>对象
     */
    private Map<String, Boolean> getProblemTagEditResult(ProblemTag ProblemTag)
    {
        Map<String, Boolean> result = new HashMap<>();
        result.put(
                "isProblemTagExists", isProblemTagExists((int) ProblemTag.getProblemTagId()));
        result.put(
                "isProblemTagEditable",
                isProblemTagEditable((int) ProblemTag.getProblemTagId()));
        result.put("isProblemTagSlugEmpty", ProblemTag.getProblemTagSlug().isEmpty());
        result.put(
                "isProblemTagSlugLegal",
                isProblemTagSlugLegal(ProblemTag.getProblemTagSlug()));
        result.put(
                "isProblemTagSlugExists",
                isProblemTagSlugExists(ProblemTag, ProblemTag.getProblemTagSlug()));
        result.put("isProblemTagNameEmpty", ProblemTag.getProblemTagName().isEmpty());
        result.put(
                "isProblemTagNameLegal",
                isProblemTagNameLegal(ProblemTag.getProblemTagName()));

        boolean isSuccessful =
                result.get("isProblemTagExists")
                        && result.get("isProblemTagEditable")
                        && !result.get("isProblemTagSlugEmpty")
                        && result.get("isProblemTagSlugLegal")
                        && !result.get("isProblemTagSlugExists")
                        && !result.get("isProblemTagNameEmpty")
                        && result.get("isProblemTagNameLegal");
        result.put("isSuccessful", isSuccessful);
        return result;
    }

    /**
     * 检查分类目录是否存在.
     *
     * @param ProblemTagId - 分类目录的唯一标识符
     * @return 分类目录是否存在
     */
    private boolean isProblemTagExists(int ProblemTagId)
    {
        ProblemTag ProblemTag =
                ProblemTagMapper.getProblemTagUsingTagId(ProblemTagId);
        return ProblemTag != null;
    }

    /**
     * 检查试题分类是否可编辑. 试题分类的唯一标识符为1的项目是默认分类, 不可编辑.
     *
     * @param ProblemTagId - 待编辑的试题分类对象
     * @return 试题分类是否可编辑
     */
    private boolean isProblemTagEditable(int ProblemTagId)
    {
        return ProblemTagId != 1;
    }

    /**
     * 根据试题分类的别名获取试题分类的唯一标识符.
     *
     * @param problemTagSlug - 试题分类的别名
     * @return 试题分类的唯一标识符
     */
    private int getProblemTagIdUsingSlug(String problemTagSlug)
    {
        int problemTagId = 0;
        if (!problemTagSlug.isEmpty())
        {
            ProblemTag ProblemTag =
                    ProblemTagMapper.getProblemTagUsingTagSlug(problemTagSlug);

            if (ProblemTag != null)
            {
                problemTagId = (int) ProblemTag.getProblemTagId();
            }
        }
        return problemTagId;
    }

    /**
     * 检查试题分类的别名的合法性
     *
     * @param ProblemTagSlug - 试题分类的别名
     * @return 试题分类的别名是否合法
     */
    private boolean isProblemTagSlugLegal(String ProblemTagSlug)
    {
        return ProblemTagSlug.length() <= 32;
    }

    /**
     * 检查试题分类是否存在(检查Slug是否重复)
     *
     * @param ProblemTagSlug - 试题分类的别名
     * @return 试题分类是否存在
     */
    private boolean isProblemTagSlugExists(String ProblemTagSlug)
    {
        ProblemTag ProblemTag =
                ProblemTagMapper.getProblemTagUsingTagSlug(ProblemTagSlug);
        return ProblemTag != null;
    }

    /**
     * 检查试题分类是否存在(检查Slug是否重复)
     *
     * @param problemTag     - 当前的试题分类对象
     * @param problemTagSlug - 试题分类的别名
     * @return 试题分类是否存在
     */
    private boolean isProblemTagSlugExists(
            ProblemTag problemTag, String problemTagSlug)
    {
        ProblemTag anotherProblemTag =
                ProblemTagMapper.getProblemTagUsingTagSlug(problemTagSlug);
        return anotherProblemTag != null
                && anotherProblemTag.getProblemTagId() != problemTag.getProblemTagId();
    }

    /**
     * 检查试题分类名称的合法性
     *
     * @param ProblemTagName - 试题分类的名称
     * @return 试题分类名称是否合法
     */
    private boolean isProblemTagNameLegal(String ProblemTagName)
    {
        return ProblemTagName.length() <= 32;
    }

    /**
     * 根据试题分类的唯一标识符删除某个试题分类.
     *
     * @param ProblemTagId - 分类目录的唯一标识符
     * @return 试题分类是否被删除
     */
    public boolean deleteProblemTag(int ProblemTagId)
    {
        boolean isProblemTagEditable = false;
        if (isProblemTagEditable(ProblemTagId))
        {
            ProblemTagMapper.deleteProblemTag(ProblemTagId);
            isProblemTagEditable = true;
        }
        return isProblemTagEditable;
    }

    /**
     * 自动注入的ProblemMapper对象.
     */
    @Autowired
    private ProblemMapper problemMapper;

    /**
     * 自动注入的ProblemTagMapper对象.
     */
    @Autowired
    private ProblemTagMapper ProblemTagMapper;

    /**
     * 自动注入的ProblemTagMapper对象.
     */
    @Autowired
    private ProblemTagMapper problemTagMapper;
}
