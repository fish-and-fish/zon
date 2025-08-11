package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 客户信息对象 customer
 * 
 * @author ruoyi
 * @date 2025-08-10
 */
public class Customer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 自增主键ID */
    private String id;

    /** 客户唯一ID（A1国家+公司编号+人员编号） */
    @Excel(name = "客户唯一ID", readConverterExp = "A=1国家+公司编号+人员编号")
    private String customerId;

    /** 公司名称 */
    @Excel(name = "公司名称")
    private String companyName;

    /** 客户名称 */
    @Excel(name = "客户名称")
    private String customerName;

    /** 状态类（如P2） */
    @Excel(name = "状态类", readConverterExp = "如=P2")
    private String status;

    /** 客户类型 */
    @Excel(name = "客户类型")
    private String customerType;

    /** 客户来源 */
    @Excel(name = "客户来源")
    private String customerSource;

    /** 客户描述 */
    @Excel(name = "客户描述")
    private String customerDescription;

    /** 国家地区 */
    @Excel(name = "国家地区")
    private String countryRegion;

    /** 客户等级 */
    @Excel(name = "客户等级")
    private String customerLevel;

    /** 创建日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "创建日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createdAt;

    /** 跟进内容 */
    @Excel(name = "跟进内容")
    private String followupContent;

    /** 跟进日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "跟进日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date followupDate;

    /** 职位 */
    @Excel(name = "职位")
    private String position;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String contactPhone;

    /** 邮箱 */
    @Excel(name = "邮箱")
    private String email;

    /** 其他联系方式 */
    @Excel(name = "其他联系方式")
    private String otherContact;

    /** 公司网站 */
    @Excel(name = "公司网站")
    private String companyWebsite;

    /** 公司地址 */
    @Excel(name = "公司地址")
    private String companyAddress;

    /** 附件路径或链接 */
    @Excel(name = "附件路径或链接")
    private String attachment;

    public void setId(String id) 
    {
        this.id = id;
    }

    public String getId() 
    {
        return id;
    }

    public void setCustomerId(String customerId) 
    {
        this.customerId = customerId;
    }

    public String getCustomerId() 
    {
        return customerId;
    }

    public void setCompanyName(String companyName) 
    {
        this.companyName = companyName;
    }

    public String getCompanyName() 
    {
        return companyName;
    }

    public void setCustomerName(String customerName) 
    {
        this.customerName = customerName;
    }

    public String getCustomerName() 
    {
        return customerName;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setCustomerType(String customerType) 
    {
        this.customerType = customerType;
    }

    public String getCustomerType() 
    {
        return customerType;
    }

    public void setCustomerSource(String customerSource) 
    {
        this.customerSource = customerSource;
    }

    public String getCustomerSource() 
    {
        return customerSource;
    }

    public void setCustomerDescription(String customerDescription) 
    {
        this.customerDescription = customerDescription;
    }

    public String getCustomerDescription() 
    {
        return customerDescription;
    }

    public void setCountryRegion(String countryRegion) 
    {
        this.countryRegion = countryRegion;
    }

    public String getCountryRegion() 
    {
        return countryRegion;
    }

    public void setCustomerLevel(String customerLevel) 
    {
        this.customerLevel = customerLevel;
    }

    public String getCustomerLevel() 
    {
        return customerLevel;
    }

    public void setCreatedAt(Date createdAt) 
    {
        this.createdAt = createdAt;
    }

    public Date getCreatedAt() 
    {
        return createdAt;
    }

    public void setFollowupContent(String followupContent) 
    {
        this.followupContent = followupContent;
    }

    public String getFollowupContent() 
    {
        return followupContent;
    }

    public void setFollowupDate(Date followupDate) 
    {
        this.followupDate = followupDate;
    }

    public Date getFollowupDate() 
    {
        return followupDate;
    }

    public void setPosition(String position) 
    {
        this.position = position;
    }

    public String getPosition() 
    {
        return position;
    }

    public void setContactPhone(String contactPhone) 
    {
        this.contactPhone = contactPhone;
    }

    public String getContactPhone() 
    {
        return contactPhone;
    }

    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }

    public void setOtherContact(String otherContact) 
    {
        this.otherContact = otherContact;
    }

    public String getOtherContact() 
    {
        return otherContact;
    }

    public void setCompanyWebsite(String companyWebsite) 
    {
        this.companyWebsite = companyWebsite;
    }

    public String getCompanyWebsite() 
    {
        return companyWebsite;
    }

    public void setCompanyAddress(String companyAddress) 
    {
        this.companyAddress = companyAddress;
    }

    public String getCompanyAddress() 
    {
        return companyAddress;
    }

    public void setAttachment(String attachment) 
    {
        this.attachment = attachment;
    }

    public String getAttachment() 
    {
        return attachment;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("customerId", getCustomerId())
            .append("companyName", getCompanyName())
            .append("customerName", getCustomerName())
            .append("status", getStatus())
            .append("customerType", getCustomerType())
            .append("customerSource", getCustomerSource())
            .append("customerDescription", getCustomerDescription())
            .append("countryRegion", getCountryRegion())
            .append("customerLevel", getCustomerLevel())
            .append("createdAt", getCreatedAt())
            .append("followupContent", getFollowupContent())
            .append("followupDate", getFollowupDate())
            .append("position", getPosition())
            .append("contactPhone", getContactPhone())
            .append("email", getEmail())
            .append("otherContact", getOtherContact())
            .append("companyWebsite", getCompanyWebsite())
            .append("companyAddress", getCompanyAddress())
            .append("attachment", getAttachment())
            .toString();
    }
}
