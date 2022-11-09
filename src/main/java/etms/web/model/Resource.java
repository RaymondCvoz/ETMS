package etms.web.model;

import org.springframework.stereotype.Component;

@Component
public class Resource
{
    /**
     * 资源默认构造函数
     */
    public Resource()
    {
    }

    /**
     * 资源构造函数
     * @param resourceType 资源类型
     * @param resourceName 资源名称
     * @param resourcePath 资源路径
     * @param resourceInfo 资源信息
     */
    public Resource(String resourceType, String resourceName, String resourcePath, String resourceInfo)
    {
        this.resourceType = resourceType;
        this.resourceName = resourceName;
        this.resourcePath = resourcePath;
        this.resourceInfo = resourceInfo;
    }

    /**
     * 资源类构造函数
     * @param resourceId 资源唯一标识符
     * @param resourceType 资源类型
     * @param resourceName 资源名称
     * @param resourcePath 资源路径
     * @param resourceInfo 资源信息
     */
    public Resource(long resourceId, String resourceType, String resourceName, String resourcePath, String resourceInfo)
    {
        this.resourceId = resourceId;
        this.resourceType = resourceType;
        this.resourceName = resourceName;
        this.resourcePath = resourcePath;
        this.resourceInfo = resourceInfo;
    }

    /**
     * 获取资源唯一标识符
     * @return 资源唯一标识符
     */
    public long getResourceId()
    {
        return resourceId;
    }

    /**
     * 设置资源唯一标识符
     * @param resourceId 资源唯一标识符
     */
    public void setResourceId(long resourceId)
    {
        this.resourceId = resourceId;
    }

    /**
     * 获取资源类型
     * @return 资源类型
     */
    public String getResourceType()
    {
        return resourceType;
    }

    /**
     * 设置资源类型
     * @param resourceType 资源类型
     */
    public void setResourceType(String resourceType)
    {
        this.resourceType = resourceType;
    }

    /**
     * 获取资源名称
     * @return 资源名称
     */
    public String getResourceName()
    {
        return resourceName;
    }

    /**
     * 设置资源名称
     * @param resourceName 资源名称
     */
    public void setResourceName(String resourceName)
    {
        this.resourceName = resourceName;
    }

    /**
     * 获取资源路径
     * @return 资源路径
     */
    public String getResourcePath()
    {
        return resourcePath;
    }

    /**
     * 设置资源路径
     * @param resourcePath 资源路径
     */
    public void setResourcePath(String resourcePath)
    {
        this.resourcePath = resourcePath;
    }

    /**
     * 获取资源信息
     * @return 资源信息
     */
    public String getResourceInfo()
    {
        return resourceInfo;
    }

    /**
     * 设置资源信息
     * @param resourceInfo 资源信息
     */
    public void setResourceInfo(String resourceInfo)
    {
        this.resourceInfo = resourceInfo;
    }

    /**
     * 资源唯一标识符
     */
    private long resourceId;
    /**
     * 资源类型
     */
    private String resourceType;
    /**
     * 资源名称
     */
    private String resourceName;
    /**
     * 资源路径
     */
    private String resourcePath;
    /**
     * 资源信息
     */
    private String resourceInfo;
}
