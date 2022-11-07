package etms.web.model;

import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 公告信息实体类
 */
@Component
public class BulletinBoardMessage
{
    /**
     * 公告信息默认构造函数
     */
    public BulletinBoardMessage()
    {
    }

    /**
     * 公告信息构造函数
     * @param messageId 公告信息唯一标识符
     * @param messageName 公告信息标题
     * @param messageBody 公告信息内容
     * @param messageCreateTime 公告信息创建时间
     */
    public BulletinBoardMessage(long messageId, String messageName, String messageBody, Date messageCreateTime)
    {
        this.messageId = messageId;
        this.messageName = messageName;
        this.messageBody = messageBody;
        this.messageCreateTime = messageCreateTime;
    }

    /**
     * 获取公告信息唯一标识符
     * @return 公告信息唯一标识符
     */
    public long getMessageId()
    {
        return messageId;
    }

    /**
     * 设置公告信息唯一标识符
     * @param messageId 公告信息唯一标识符
     */
    public void setMessageId(long messageId)
    {
        this.messageId = messageId;
    }

    /**
     * 获取公告信息标题
     * @return 公告信息标题
     */
    public String getMessageName()
    {
        return messageName;
    }

    /**
     * 设置公告信息标题
     * @param messageName 公告信息标题
     */
    public void setMessageName(String messageName)
    {
        this.messageName = messageName;
    }

    /**
     *获取公告信息内容
     * @return 公告信息内容
     */
    public String getMessageBody()
    {
        return messageBody;
    }

    /**
     * 设置公告信息内容
     * @param messageBody 公告信息内容
     */
    public void setMessageBody(String messageBody)
    {
        this.messageBody = messageBody;
    }

    /**
     * 获取公告信息创建时间
     * @return 公告信息创建时间
     */
    public Date getMessageCreateTime()
    {
        return messageCreateTime;
    }

    /**
     * 设置公告信息创建时间
     * @param messageCreateTime 公告信息创建时间
     */
    public void setMessageCreateTime(Date messageCreateTime)
    {
        this.messageCreateTime = messageCreateTime;
    }

    /**
     * 公告信息唯一标识符
     */
    private long messageId;
    /**
     * 公告信息标题
     */
    private String messageName;
    /**
     * 公告信息内容
     */
    private String messageBody;
    /**
     * 公告信息创建时间
     */
    private Date messageCreateTime;

}
