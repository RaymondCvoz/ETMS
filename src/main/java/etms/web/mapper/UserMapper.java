
package etms.web.mapper;

import etms.web.model.User;
import etms.web.model.UserGroup;
import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * User Data Access Object.
 *
 */
@CacheNamespace(implementation = org.mybatis.caches.ehcache.EhcacheCache.class)
@Mapper
public interface UserMapper
{
    /**
     * [此方法仅供管理员使用] 获取系统中某个用户组中用户的总数.
     *
     * @param userGroup - 用户所属的用户组对象
     * @return 系统中某个用户组中用户的总数
     */
    long getNumberOfUsersUsingUserGroup(@Param("userGroup") UserGroup userGroup);

    /**
     * [此方法仅供管理员使用] 使用用户组和用户名获取符合条件的用户的总数.
     *
     * @param userGroup - 用户组对象
     * @param username  - 部分或全部用户名
     * @return 某个用户组中用户名中包含某个字符串的用户的总数
     */
    long getNumberOfUsersUsingUserGroupAndUsername(
            @Param("userGroup") UserGroup userGroup, @Param("username") String username);

    /**
     * 通过用户唯一标识符获取用户对象.
     *
     * @param uid - 用户唯一标识符
     * @return 预期的用户对象或空引用
     */
    User getUserUsingUid(@Param("uid") long uid);

    /**
     * 通过用户名获取用户对象.
     *
     * @param username - 用户名
     * @return 预期的用户对象或空引用
     */
    User getUserUsingUsername(@Param("username") String username);

    /**
     * 通过电子邮件地址获取用户对象.
     *
     * @param email - 电子邮件地址
     * @return 预期的用户对象或空引用
     */
    User getUserUsingEmail(@Param("email") String email);

    /**
     * 获取某个用户组中的用户列表.
     *
     * @param userGroup - 用户所属的用户组对象
     * @param offset    - 用户唯一标识符的起始编号
     * @param limit     - 需要获取的用户的数量
     * @return 符合条件的用户列表
     */
    List<User> getUserUsingUserGroup(
            @Param("userGroup") UserGroup userGroup,
            @Param("uid") long offset,
            @Param("limit") int limit);

    /**
     * [此方法仅供管理员使用] 根据用户组和用户名筛选用户对象.
     *
     * @param userGroup - 用户组对象
     * @param username  - 部分或全部用户名
     * @param offset    - 用户唯一标识符的起始编号
     * @param limit     - 需要获取的用户的数量
     * @return 符合条件的用户列表
     */
    List<User> getUserUsingUserGroupAndUsername(
            @Param("userGroup") UserGroup userGroup,
            @Param("username") String username,
            @Param("offset") long offset,
            @Param("limit") int limit);

    /**
     * 创建新用户对象.
     *
     * @param user - 待创建的用户对象
     */
    int createUser(User user);

    /**
     * 更新用户对象.
     *
     * @param user - 待更新信息的用户对象
     */
    int updateUser(User user);

    /**
     * 删除用户对象.
     *
     * @param uid - 待删除用户的用户唯一标识符
     */
    int deleteUser(@Param("uid") long uid);
}
