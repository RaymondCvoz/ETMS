
package etms.web.model;

import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * 系统设置选项类.
 *
 */
@Component
public class Option
{
    /**
     * Option类的默认构造函数.
     */
    public Option()
    {
    }

    /**
     * Option类的构造函数.
     *
     * @param optionName  - 选项的名称
     * @param optionValue - 选项的值
     */
    public Option(String optionName, String optionValue)
    {
        this.optionName = optionName;
        this.optionValue = optionValue;
    }

    /**
     * Option类的构造函数.
     *
     * @param optionId    - 选项的唯一标识符
     * @param optionName  - 选项的名称
     * @param optionValue - 选项的值
     */
    public Option(int optionId, String optionName, String optionValue)
    {
        this(optionName, optionValue);
        this.optionId = optionId;
    }

    /**
     * 获取选项的唯一标识符.
     *
     * @return 选项的唯一标识符
     */
    public int getOptionId()
    {
        return optionId;
    }

    /**
     * 设置选项的唯一标识符.
     *
     * @param optionId - 选项的唯一标识符
     */
    public void setOptionId(int optionId)
    {
        this.optionId = optionId;
    }

    /**
     * 获取选项的名称.
     *
     * @return 选项的名称
     */
    public String getOptionName()
    {
        return optionName;
    }

    /**
     * 设置选项的名称.
     *
     * @param optionName - 选项的名称
     */
    public void setOptionName(String optionName)
    {
        this.optionName = optionName;
    }

    /**
     * 获取选项的值.
     *
     * @return 选项的值
     */
    public String getOptionValue()
    {
        return optionValue;
    }

    /**
     * 设置选项的值.
     *
     * @param optionValue - 选项的值
     */
    public void setOptionValue(String optionValue)
    {
        this.optionValue = optionValue;
    }


    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
    public String toString()
    {
        return String.format(
                "Option [ID=%d, Name=%s, Value=%s, isAutoLoad=%s]",
                new Object[]{optionId, optionName, optionValue});
    }

    /**
     * 选项的唯一标识符.
     */
    private int optionId;

    /**
     * 选项的名称.
     */
    private String optionName;

    /**
     * 选项的值.
     */
    private String optionValue;
}
