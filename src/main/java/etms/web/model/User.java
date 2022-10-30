package etms.web.model;


/**
 * 用户的Model. 对应数据库中的etms_user数据表.
 *
 */
public class User
{
    /**
     * 用户空构造函数
     */
    public User()
    {

    }
    /**
     *用户构造函数
     * @param uid 用户id
     * @param userGroup 用户组id
     * @param userName 用户名
     * @param password 用户密码
     * @param email 用户电子邮件地址
     */
    public User(long uid, int userGroup, String userName, String password, String email)
    {
        this.uid = uid;
        this.userGroup = userGroup;
        this.userName = userName;
        this.password = password;
        this.email = email;
    }

    /**
     * 获取用户id
     * @return 用户uid
     */
    public long getUid()
    {
        return uid;
    }

    /**
     * 设置用户id
     * @param uid 用户id
     */
    public void setUid(long uid)
    {
        this.uid = uid;
    }

    /**
     * 获取用户组
     * @return 用户组id
     */
    public int getuserGroup()
    {
        return userGroup;
    }

    /**
     * 设置用户组id
     * @param userGroup 用户组id
     */
    public void setUserGroup(int userGroup)
    {
        this.userGroup = userGroup;
    }

    /**
     * 获取用户名
     * @return 用户名
     */
    public String getUserName()
    {
        return userName;
    }

    /**
     * 设置用户名
     * @param userName 用户名
     */
    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    /**
     * 获取用户密码
     * @return 用户密码
     */
    public String getPassword()
    {
        return password;
    }

    /**
     * 设置用户密码
     * @param password 用户密码
     */
    public void setPassword(String password)
    {
        this.password = password;
    }

    /**
     * 获取用户电子邮件地址
     * @return 用户电子邮件地址
     */
    public String getEmail()
    {
        return email;
    }

    /**
     * 设置用户电子邮件地址
     * @param email 用户电子邮件地址
     */
    public void setEmail(String email)
    {
        this.email = email;
    }

    /**
     * 用户id
     */
    private long uid;
    /**
     * 用户组id
     */
    private int userGroup;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 用户密码
     */
    private String password;
    /**
     * 用户电子邮件地址
     */
    private String email;
}
