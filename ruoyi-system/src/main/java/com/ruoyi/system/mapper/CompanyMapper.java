package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.Company;

/**
 * 【请填写功能名称】Mapper接口
 * 
 * @author ruoyi
 * @date 2025-08-19
 */
public interface CompanyMapper 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param id 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Company selectCompanyById(Long id);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param company 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Company> selectCompanyList(Company company);

    /**
     * 新增【请填写功能名称】
     * 
     * @param company 【请填写功能名称】
     * @return 结果
     */
    public int insertCompany(Company company);

    /**
     * 修改【请填写功能名称】
     * 
     * @param company 【请填写功能名称】
     * @return 结果
     */
    public int updateCompany(Company company);

    /**
     * 删除【请填写功能名称】
     * 
     * @param id 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteCompanyById(Long id);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCompanyByIds(Long[] ids);
}
