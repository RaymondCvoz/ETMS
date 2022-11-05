
package etms.web.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * 用户
 *
 */
@Component
public class User
{
    /**
     * 用户的默认构造函数.
     */
    public User()
    {
    }

    /**
     * 用户的构造函数.
     *
     * @param username       - 用户名
     * @param password       - 密码
     * @param email          - 电子邮件地址
     * @param userGroup     - 用户组
     */
    public User(
            String username,
            String password,
            String email,
            UserGroup userGroup)
    {
        this.username = username;
        this.password = password;
        this.email = email;
        this.userGroup = userGroup;
    }

    /**
     * User类的构造函数.
     *
     * @param uid            - 用户唯一标识符
     * @param username       - 用户名
     * @param password       - 密码
     * @param email          - 电子邮件地址
     * @param userGroup      - 用户组
     */
    public User(
            int uid,
            String username,
            String password,
            String email,
            UserGroup userGroup)
    {
        this(username, password, email, userGroup);
        this.uid = uid;
    }

    /**
     * 获取用户唯一标识符.
     *
     * @return 用户唯一标识符
     */
    public long getUid()
    {
        return uid;
    }

    /**
     * 设置用户唯一标识符.
     *
     * @param uid - 用户唯一标识符
     */
    public void setUid(long uid)
    {
        this.uid = uid;
    }

    /**
     * 获取用户名.
     *
     * @return 用户名
     */
    public String getUsername()
    {
        return username;
    }

    /**
     * 设置用户名.
     *
     * @param username - 用户名
     */
    public void setUsername(String username)
    {
        this.username = username;
    }

    /**
     * 获取密码(已采用MD5加密).
     *
     * @return 密码
     */
    public String getPassword()
    {
        return password;
    }

    /**
     * 设置密码.
     *
     * @param password - 密码
     */
    public void setPassword(String password)
    {
        this.password = password;
    }

    /**
     * 获取电子邮件地址.
     *
     * @return 电子邮件地址
     */
    public String getEmail()
    {
        return email;
    }

    /**
     * 设置电子邮件地址
     *
     * @param email - 电子邮件地址
     */
    public void setEmail(String email)
    {
        this.email = email;
    }

    /**
     * 获取用户组.
     *
     * @return 用户组对象
     */
    public UserGroup getUserGroup()
    {
        return userGroup;
    }

    /**
     * 设置用户组.
     *
     * @param userGroupId - 用户组对象
     */
    public void setUserGroup(UserGroup userGroupId)
    {
        this.userGroup = userGroupId;
    }

    public boolean equals(Object obj)
    {
        if (obj instanceof User)
        {
            User anotherUser = (User) obj;
            return anotherUser.getUid() == uid;
        }
        return false;
    }

    @Override
    public String toString()
    {
        return "User{" +
                "uid=" + uid +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", userGroup=" + userGroup +
                '}';
    }

    /**
     * 用户的唯一标识符.
     */
    private long uid;

    /**
     * 用户名.
     */
    private String username;

    /**
     * 密码(已采用MD5加密).
     */
    @JsonIgnore
    private String password;

    /**
     * 电子邮件地址.
     */
    private String email;

    /**
     * 用户组对象.
     */
    @JsonIgnore
    private UserGroup userGroup;
    /**
     * 唯一的序列化标识符.
     */
    private static final long serialVersionUID = 2264535351943252507L;
}
