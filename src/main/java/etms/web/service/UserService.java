
package etms.web.service;

import etms.web.mapper.*;
import etms.web.model.*;
import etms.web.util.DigestUtils;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 用户类(User)的业务逻辑层.
 *
 */
@Service
@Transactional
public class UserService
{
    /**
     * 通过用户唯一标识符获取用户对象.
     *
     * @param userId - 用户唯一标识符
     * @return 预期的用户对象或空引用
     */
    public User getUserUsingUid(long userId)
    {
        return userMapper.getUserUsingUid(userId);
    }

    /**
     * 获取某个用户组中的用户列表.
     *
     * @param userGroup - 用户所属的用户组对象
     * @param offset    - 用户唯一标识符的起始编号
     * @param limit     - 需要获取的用户的数量
     * @return 用户列表
     */
    public List<User> getUserUsingUserGroup(UserGroup userGroup, long offset, int limit)
    {
        return userMapper.getUserUsingUserGroup(userGroup, offset, limit);
    }

    /**
     * 获取用户的元信息.
     *
     * @param user - 元信息对应的用户对象
     * @return 用户元信息的键值对
     */
    public Map<String, Object> getUserMetaUsingUid(User user)
    {
        Map<String, Object> userMetaMap = new HashMap<>();
        if (user == null)
        {
            return userMetaMap;
        }
        List<UserMeta> userMetaList = userMetaMapper.getUserMetaUsingUser(user);
        for (UserMeta userMeta : userMetaList)
        {
            String key = userMeta.getMetaKey();
            Object value = userMeta.getMetaValue();

            if ("socialLinks".equals(key))
            {
                value = JSON.parseObject((String) value);
            }
            userMetaMap.put(key, value);
        }
        return userMetaMap;
    }

    /**
     * 通过用户名或电子邮件地址获取用户对象.
     *
     * @param username - 用户名或电子邮件地址
     * @return 一个User对象或空引用
     */
    public User getUserUsingUsernameOrEmail(String username)
    {
        boolean isUsingEmail = username.indexOf('@') != -1;
        User user = null;

        if (!isUsingEmail)
        {
            user = userMapper.getUserUsingUsername(username);
        } else
        {
            user = userMapper.getUserUsingEmail(username);
        }
        return user;
    }

    /**
     * 验证用户身份是否有效.
     *
     * @param username - 用户名或电子邮件地址
     * @param password - 密码(已使用MD5加密)
     * @return 一个包含登录验证结果的Map<String, Boolean>对象
     */
    public Map<String, Boolean> isAllowedToLogin(String username, String password)
    {
        Map<String, Boolean> result = new HashMap<>(6, 1);
        result.put("isUsernameEmpty", username.isEmpty());
        result.put("isPasswordEmpty", password.isEmpty());
        result.put("isAccountValid", false);
        result.put("isAllowedToAccess", false);
        result.put("isSuccessful", false);

        if (!result.get("isUsernameEmpty") && !result.get("isPasswordEmpty"))
        {
            User user = getUserUsingUsernameOrEmail(username);
            if (user != null && user.getPassword().equals(password))
            {
                result.put("isAccountValid", true);
                result.put("isSuccessful", true);
            }
        }
        return result;
    }

    /**
     * 验证账户有效性并创建用户.
     *
     * @param username         - 用户名
     * @param password         - 密码(未使用MD5加密)
     * @param email            - 电子邮件地址
     * @param userGroupSlug    - 用户组的别名
     * @param isAllowRegister  - 系统是否允许注册新用户
     * @return 一个包含账户创建结果的Map<String, Boolean>对象
     */
    public Map<String, Boolean> createUser(
            String username,
            String password,
            String email,
            String userGroupSlug,
            boolean isAllowRegister)
    {
        UserGroup userGroup = userGroupMapper.getUserGroupUsingSlug(userGroupSlug);
        User user =
                new User(username, password, email, userGroup);

        Map<String, Boolean> result =
                getUserCreationResult(user, password, isAllowRegister);
        if (result.get("isSuccessful"))
        {
            userMapper.createUser(user);
            createUserMeta(user);
        }
        return result;
    }

    /**
     * [此方法仅供管理员使用] 验证账户有效性并创建用户.
     *
     * @param username      - 用户名
     * @param password      - 密码(未使用MD5加密)
     * @param email         - 电子邮件地址
     * @param userGroupSlug - 用户组的别名
     * @return 一个包含账户创建结果的Map<String, Boolean>对象
     */
    public Map<String, Boolean> createUser(
            String username, String password, String email, String userGroupSlug)
    {
        UserGroup userGroup = userGroupMapper.getUserGroupUsingSlug(userGroupSlug);
        User user =
                new User(username, password, email, userGroup);

        Map<String, Boolean> result = getUserCreationResult(user, password, true);
        if (result.get("isSuccessful"))
        {
            userMapper.createUser(user);
            createUserMeta(user);
        }
        return result;
    }

    /**
     * 创建用户元信息.
     *
     * @param user - 对应的用户对象
     */
    private void createUserMeta(User user)
    {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar calendar = Calendar.getInstance();
        String registerTime = formatter.format(calendar.getTime());
        UserMeta registerTimeMeta = new UserMeta(user, "registerTime", registerTime);
        userMetaMapper.createUserMeta(registerTimeMeta);
    }

    /**
     * 验证待创建用户信息的合法性.
     *
     * @param user             - 待创建的User对象
     * @param password         - 密码(未使用MD5加密)
     * @param isAllowRegister  - 系统是否允许注册新用户
     * @return 一个包含账户信息验证结果的Map<String, Boolean>对象
     */
    private Map<String, Boolean> getUserCreationResult(
            User user, String password, boolean isAllowRegister)
    {
        Map<String, Boolean> result = new HashMap<>(13, 1);
        result.put("isUsernameEmpty", user.getUsername().isEmpty());
        result.put("isUsernameLegal", isUsernameLegal(user.getUsername()));
        result.put("isUsernameExists", isUsernameExists(user.getUsername()));
        result.put("isPasswordEmpty", password.isEmpty());
        result.put("isPasswordLegal", isPasswordLegal(password));
        result.put("isEmailEmpty", user.getEmail().isEmpty());
        result.put("isEmailLegal", isEmailLegal(user.getEmail()));
        result.put("isEmailExists", isEmailExists(user.getEmail()));
        result.put("isUserGroupLegal", user.getUserGroup() != null);
        result.put("isAllowRegister", isAllowRegister);

        boolean isSuccessful =
                !result.get("isUsernameEmpty")
                        && result.get("isUsernameLegal")
                        && !result.get("isUsernameExists")
                        && !result.get("isPasswordEmpty")
                        && result.get("isPasswordLegal")
                        && !result.get("isEmailEmpty")
                        && result.get("isEmailLegal")
                        && !result.get("isEmailExists")
                        && result.get("isUserGroupLegal")
                        && result.get("isAllowRegister");
        result.put("isSuccessful", isSuccessful);
        return result;
    }


    /**
     * 验证旧密码正确性并修改密码.
     *
     * @param user            - 待修改密码的用户对象
     * @param oldPassword     - 旧密码
     * @param newPassword     - 新密码
     * @param confirmPassword - 确认新密码
     * @return 一个包含密码验证结果的Map<String, Boolean>对象
     */
    public Map<String, Boolean> changePassword(
            User user, String oldPassword, String newPassword, String confirmPassword)
    {
        Map<String, Boolean> result =
                getChangePasswordResult(user, oldPassword, newPassword, confirmPassword);

        if (result.get("isSuccessful"))
        {
            user.setPassword(newPassword);
            userMapper.updateUser(user);
        }
        return result;
    }

    /**
     * 验证旧密码的正确性和新密码的合法性.
     *
     * @param user            - 待修改密码的用户对象
     * @param oldPassword     - 旧密码
     * @param newPassword     - 新密码
     * @param confirmPassword - 确认新密码
     * @return 一个包含密码验证结果的Map<String, Boolean>对象
     */
    private Map<String, Boolean> getChangePasswordResult(
            User user, String oldPassword, String newPassword, String confirmPassword)
    {
        Map<String, Boolean> result = new HashMap<>(5, 1);
        result.put("isOldPasswordCorrect", isOldPasswordCorrect(user.getPassword(), oldPassword));
        result.put("isNewPasswordEmpty", newPassword.isEmpty());
        result.put("isNewPasswordLegal", isPasswordLegal(newPassword));
        result.put("isConfirmPasswordMatched", newPassword.equals(confirmPassword));

        boolean isSuccessful =
                result.get("isOldPasswordCorrect")
                        && !result.get("isNewPasswordEmpty")
                        && result.get("isNewPasswordLegal")
                        && result.get("isConfirmPasswordMatched");
        result.put("isSuccessful", isSuccessful);
        return result;
    }

    /**
     * 验证新资料的有效性并更新个人资料.
     *
     * @param user             - 待更改资料的用户
     * @param email            - 用户的电子邮件地址
     * @return 一个包含个人资料修改结果的Map<String, Boolean>对象
     */
    public Map<String, Boolean> updateProfile(
            User user,
            String email)
    {
        Map<String, Boolean> result =
                getUpdateProfileResult(user, email);

        if (result.get("isSuccessful"))
        {
            user.setEmail(email);
            userMapper.updateUser(user);
        }
        return result;
    }

    /**
     * 验证新资料的有效性.
     *
     * @param user             - 待更改资料的用户
     * @param email            - 用户的电子邮件地址
     * @return 一个包含个人资料修改结果的Map<String, Boolean>对象
     */
    private Map<String, Boolean> getUpdateProfileResult(
            User user,
            String email)
    {
        Map<String, Boolean> result = new HashMap<>(7, 1);
        result.put("isEmailEmpty", email.isEmpty());
        result.put("isEmailLegal", isEmailLegal(email));
        result.put("isEmailExists", isEmailExists(user.getEmail(), email));

        boolean isSuccessful =
                !result.get("isEmailEmpty")
                        && result.get("isEmailLegal")
                        && !result.get("isEmailExists");
        result.put("isSuccessful", isSuccessful);
        return result;
    }

    /**
     * 更新用户元信息.
     *
     * @param user      - 待更新元信息的用户
     * @param metaKey   - 元信息的键
     * @param metaValue - 元信息的值
     */
    private void updateUserMeta(User user, String metaKey, String metaValue)
    {
        UserMeta userMeta = userMetaMapper.getUserMetaUsingUserAndMetaKey(user, metaKey);

        if (userMeta == null)
        {
            if (metaValue.isEmpty())
            {
                return;
            }
            userMeta = new UserMeta(user, metaKey, metaValue);
            userMetaMapper.createUserMeta(userMeta);
        } else
        {
            userMeta.setMetaValue(metaValue);
            userMetaMapper.updateUserMeta(userMeta);
        }
    }

    /**
     * 验证用户名的合法性: 规则: 用户名应由[A-Za-z0-9_]组成, 以字母起始且长度在6-16个字符.
     *
     * @param username - 用户名
     * @return 用户名是否合法
     */
    private boolean isUsernameLegal(String username)
    {
        return username.matches("^[A-Za-z][A-Za-z0-9_]{5,15}$");
    }

    /**
     * 检查用户名是否存在.
     *
     * @param username - 用户名
     * @return 用户名是否存在
     */
    private boolean isUsernameExists(String username)
    {
        User user = userMapper.getUserUsingUsername(username);
        return user != null;
    }

    /**
     * 检查密码是否合法. 规则: 密码的长度在6-16个字符.
     *
     * @param password - 密码(未经MD5加密)
     * @return 密码是否合法
     */
    private boolean isPasswordLegal(String password)
    {
        int passwordLength = password.length();
        return passwordLength >= 6 && passwordLength <= 16;
    }

    /**
     * 更改密码时, 验证用户的旧密码是否正确.
     *
     * @param oldPassword      - 用户的旧密码(已使用MD5加密)
     * @param submitedPassword - 所提交进行验证的旧密码(未使用MD5加密)
     * @return 用户旧密码是否正确
     */
    private boolean isOldPasswordCorrect(String oldPassword, String submitedPassword)
    {
        if (submitedPassword.isEmpty())
        {
            return true;
        }
        return oldPassword.equals(submitedPassword);
    }

    /**
     * 检查电子邮件地址是否合法. 规则: 合法的电子邮件地址且长度不超过64个字符.
     *
     * @param email - 电子邮件地址
     * @return 电子邮件地址是否合法
     */
    private boolean isEmailLegal(String email)
    {
        int emailLength = email.length();
        return emailLength <= 64
                && email.matches("^[A-Za-z0-9\\._-]+@[A-Za-z0-9_-]+\\.[A-Za-z0-9\\._-]+$");
    }

    /**
     * 检查电子邮件地址是否存在. 说明: 仅用于用户创建新账户
     *
     * @param email - 电子邮件地址
     * @return 电子邮件地址是否存在
     */
    private boolean isEmailExists(String email)
    {
        User user = userMapper.getUserUsingEmail(email);
        return user != null;
    }

    /**
     * 检查电子邮件地址是否存在. 说明: 仅用于用户编辑个人资料
     *
     * @param currentEmail - 之前所使用的Email地址
     * @param email        - 待更新的Email地址
     * @return 电子邮件地址是否存在
     */
    private boolean isEmailExists(String currentEmail, String email)
    {
        if (currentEmail.equals(email))
        {
            return false;
        }
        User user = userMapper.getUserUsingEmail(email);
        return user != null;
    }

    /**
     * 检查个人主页的地址是否合法. 规则: 合法的HTTP(S)协议URL且长度不超过64个字符.
     *
     * @param website - 个人主页的地址
     * @return 个人主页的地址是否合法
     */
    private boolean isWebsiteLegal(String website)
    {
        int websiteLength = website.length();
        return website.isEmpty()
                || (websiteLength <= 64
                && website.matches("^(http|https):\\/\\/[A-Za-z0-9-]+\\.[A-Za-z0-9_.]+$"));
    }

    /**
     * 通过用户组的别名获取用户组对象.
     *
     * @param userGroupSlug - 用户组的别名
     * @return 用户组对象或空引用
     */
    public UserGroup getUserGroupUsingSlug(String userGroupSlug)
    {
        UserGroup userGroup = userGroupMapper.getUserGroupUsingSlug(userGroupSlug);
        return userGroup;
    }

    /**
     * [此方法仅供管理员使用] 获取全部的用户组对象.
     *
     * @return 全部的用户组对象的列表
     */
    public List<UserGroup> getUserGroups()
    {
        List<UserGroup> userGroups = userGroupMapper.getUserGroups();
        return userGroups;
    }

    /**
     * [此方法仅供管理员使用] 获取系统中注册用户的总数.
     *
     * @param userGroup - 用户所属的用户组对象
     * @return 系统中注册用户的总数
     */
    public long getNumberOfUsers(UserGroup userGroup)
    {
        return userMapper.getNumberOfUsersUsingUserGroup(userGroup);
    }

    /**
     * [此方法仅供管理员使用] 获取今日注册的用户数量.
     *
     * @return 今日注册的用户数量
     */
    public long getNumberOfUserRegisteredToday()
    {
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int date = calendar.get(Calendar.DAY_OF_MONTH);

        calendar.set(year, month, date, 0, 0, 0);
        Date startTime = calendar.getTime();
        calendar.set(year, month, date, 23, 59, 59);
        Date endTime = calendar.getTime();

        return userMetaMapper.getNumberOfUserRegistered(startTime, endTime);
    }

    /**
     * [此方法仅供管理员使用] 使用用户组和用户名获取符合条件的用户的总数.
     *
     * @param userGroup - 用户组对象
     * @param username  - 部分或全部用户名
     * @return 某个用户组中用户名中包含某个字符串的用户的总数
     */
    public long getNumberOfUsersUsingUserGroupAndUsername(UserGroup userGroup, String username)
    {
        return userMapper.getNumberOfUsersUsingUserGroupAndUsername(userGroup, username);
    }

    /**
     * [此方法仅供管理员使用] 根据用户组和用户名筛选用户对象.
     *
     * @param userGroup - 用户组对象
     * @param username  - 部分或全部用户名
     * @return 符合条件的用户列表
     */
    public List<User> getUserUsingUserGroupAndUsername(
            UserGroup userGroup, String username)
    {
        return userMapper.getUserUsingUserGroupAndUsername(userGroup, username);
    }

    /**
     * [此方法仅供管理员使用]
     *
     * @param user               - 待更改个人信息的用户.
     * @param password           - 用户的密码
     * @param email              - 用户的电子邮箱
     * @param userGroupSlug      - 用户所属用户组的别名
     * @return 包含用户个人信息更改结果的Map<String, Boolean>对象
     */
    public Map<String, Boolean> updateProfile(
            User user, String password, String email,String userGroupSlug)
    {
        UserGroup userGroup = userGroupMapper.getUserGroupUsingSlug(userGroupSlug);
        Map<String, Boolean> result = getUpdateProfileResult(password, email, userGroup);
        if (result.get("isSuccessful"))
        {
            if (!password.isEmpty())
            {
                user.setPassword(password);
            }
            user.setUserGroup(userGroup);
            userMapper.updateUser(user);
        }
        return result;
    }

    /**
     * [此方法仅供管理员使用] 更改用户的基本信息.
     *
     * @param password       - 用户的密码
     * @param email          - 用户的电子邮箱
     * @param userGroup      - 用户所属的用户组
     * @return 包含用户个人信息更改结果的Map<String, Boolean>对象
     */
    private Map<String, Boolean> getUpdateProfileResult(
            String password,String email, UserGroup userGroup)
    {
        Map<String, Boolean> result = new HashMap<>(6, 1);
        result.put("isPasswordEmpty", password.isEmpty());
        result.put("isPasswordLegal", isPasswordLegal(password));
        result.put("isUserGroupLegal", userGroup != null);
        result.put("isEmailEmpty", email.isEmpty());
        result.put("isEmailLegal", isEmailLegal(email));
        boolean isSuccessful =
                result.get("isPasswordEmpty") ^ result.get("isPasswordLegal")
                        && result.get("isUserGroupLegal")
                        && !result.get("isEmailEmpty")
                                && result.get("isEmailLegal");
        result.put("isSuccessful", isSuccessful);
        return result;
    }


    /**
     * [此方法仅供管理员使用] 根据用户的唯一标识符删除用户.
     *
     * @param uid - 用户的唯一标识符
     */
    public void deleteUser(long uid)
    {
        userMapper.deleteUser(uid);
    }

    /**
     * [此方法仅供管理员使用] 根据用户的唯一标识符删除用户元信息.
     *
     * @param uid - 用户的唯一标识符
     */
    public void deleteUserMeta(long uid)
    {
        userMetaMapper.deleteUserMetaUsingUser(uid);
    }


    /**
     * 自动注入的UserMapper对象. 用于获取用户基本信息.
     */
    @Autowired
    private UserMapper userMapper;

    /**
     * 自动注入的UserMetaMapper对象. 用于获取用户元信息.
     */
    @Autowired
    private UserMetaMapper userMetaMapper;

    /**
     * 自动注入的UserGroupMapper对象. 用于获取用户组信息.
     */
    @Autowired
    private UserGroupMapper userGroupMapper;

}
