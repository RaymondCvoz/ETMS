
package etms.web.model;

import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * 用户组
 *
 */
@Component
public class UserGroup
{
    /**
     * 用户组的默认构造函数.
     */
    public UserGroup()
    {
    }

    /**
     * 用户组的构造函数.
     *
     * @param userGroupId   - 用户组的唯一标识符
     * @param userGroupSlug - 用户组的别名
     * @param userGroupName - 用户组名称
     */
    public UserGroup(int userGroupId, String userGroupSlug, String userGroupName)
    {
        this.userGroupId = userGroupId;
        this.userGroupSlug = userGroupSlug;
        this.userGroupName = userGroupName;
    }

    /**
     * 获取用户组唯一标识符.
     *
     * @return 用户组唯一标识符
     */
    public int getUserGroupId()
    {
        return userGroupId;
    }

    /**
     * 设置用户组唯一标识符.
     *
     * @param userGroupId - 用户组唯一标识符
     */
    public void setUserGroupId(int userGroupId)
    {
        this.userGroupId = userGroupId;
    }

    /**
     * 获取用户组的别名.
     *
     * @return 用户组别名
     */
    public String getUserGroupSlug()
    {
        return userGroupSlug;
    }

    /**
     * 设置用户组的别名.
     *
     * @param userGroupSlug - 用户组别名
     */
    public void setUserGroupSlug(String userGroupSlug)
    {
        this.userGroupSlug = userGroupSlug;
    }

    /**
     * 获取用户组名称.
     *
     * @return 用户组名称
     */
    public String getUserGroupName()
    {
        return userGroupName;
    }

    /**
     * 设置用户组名称.
     *
     * @param userGroupName - 用户组名称
     */
    public void setUserGroupName(String userGroupName)
    {
        this.userGroupName = userGroupName;
    }

    @Override
    public String toString()
    {
        return "UserGroup{" +
                "userGroupId=" + userGroupId +
                ", userGroupSlug='" + userGroupSlug + '\'' +
                ", userGroupName='" + userGroupName + '\'' +
                '}';
    }

    /**
     * 用户组唯一标识符.
     */
    private int userGroupId;

    /**
     * 用户组的别名.
     */
    private String userGroupSlug;

    /**
     * 用户组名称.
     */
    private String userGroupName;

}
