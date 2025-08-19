package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson2.JSON;
import com.ruoyi.system.domain.Company;
import com.ruoyi.system.mapper.CompanyMapper;
import com.ruoyi.system.mapper.CustomerMapper;
import com.ruoyi.system.domain.Customer;
import com.ruoyi.system.service.ICustomerService;

/**
 * 客户信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-08-10
 */
@Service
public class CustomerServiceImpl implements ICustomerService 
{
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private CompanyMapper companyMapper;

    /**
     * 查询客户信息
     * 
     * @param id 客户信息主键
     * @return 客户信息
     */
    @Override
    public Customer selectCustomerById(String id)
    {
        return customerMapper.selectCustomerById(id);
    }

    /**
     * 查询客户信息列表
     * 
     * @param customer 客户信息
     * @return 客户信息
     */
    @Override
    public List<Customer> selectCustomerList(Customer customer)
    {
        return customerMapper.selectCustomerList(customer);
    }

    /**
     * 新增客户信息
     * 
     * @param customer 客户信息
     * @return 结果
     */
    @Override
    public int insertCustomer(Customer customer){
        customer.setFollowupJson(JSON.toJSONString(customer.getFollowups()));
        Company company = new Company();
        company.setCompanyName(customer.getCompanyName());
        companyMapper.insertCompany(company);
        Company company1 = companyMapper.selectCompanyList(company).get(0);

        Customer customer1 = new Customer();
        customer1.setCompanyName(customer.getCompanyName());
        customer1.setCountryRegion(customer.getCountryRegion());
        Integer size = customerMapper.selectCustomerList(customer1).size();
        size ++;
        String customerId = customer.getCountryRegion() + getCode(company1.getId().intValue(), 5) + getCode(size, 2);
        customer.setCustomerId(customerId);
        return customerMapper.insertCustomer(customer);
    }

    public String getCode(Integer id, Integer len) {
        if (id == null || len == null || len <= 0) {
            throw new IllegalArgumentException("id 和 len 不能为空，且 len 必须大于 0");
        }
        return String.format("%0" + len + "d", id);
    }

    /**
     * 修改客户信息
     * 
     * @param customer 客户信息
     * @return 结果
     */
    @Override
    public int updateCustomer(Customer customer)
    {
        customer.setFollowupJson(JSON.toJSONString(customer.getFollowups()));
        String customerId = customer.getCountryRegion() + customer.getCompanyName() + "";
        customer.setCustomerId(customerId);
        return customerMapper.updateCustomer(customer);
    }

    /**
     * 批量删除客户信息
     * 
     * @param ids 需要删除的客户信息主键
     * @return 结果
     */
    @Override
    public int deleteCustomerByIds(String[] ids)
    {
        return customerMapper.deleteCustomerByIds(ids);
    }

    /**
     * 删除客户信息信息
     * 
     * @param id 客户信息主键
     * @return 结果
     */
    @Override
    public int deleteCustomerById(String id)
    {
        return customerMapper.deleteCustomerById(id);
    }
}
