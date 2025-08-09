<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="客户ID" prop="customerId">
        <el-input
          v-model="queryParams.customerId"
          placeholder="请输入客户ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="公司名称" prop="companyName">
        <el-input
          v-model="queryParams.companyName"
          placeholder="请输入公司名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="客户名称" prop="customerName">
        <el-input
          v-model="queryParams.customerName"
          placeholder="请输入客户名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="国家地区" prop="countryRegion">
        <el-input
          v-model="queryParams.countryRegion"
          placeholder="请输入国家地区"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="客户等级" prop="customerLevel">
        <el-input
          v-model="queryParams.customerLevel"
          placeholder="请输入客户等级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="自动字段" prop="createdAt">
        <el-date-picker clearable
          v-model="queryParams.createdAt"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择自动字段">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="跟进日期" prop="followupDate">
        <el-date-picker clearable
          v-model="queryParams.followupDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择跟进日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="职位" prop="position">
        <el-input
          v-model="queryParams.position"
          placeholder="请输入职位"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="联系电话" prop="contactPhone">
        <el-input
          v-model="queryParams.contactPhone"
          placeholder="请输入联系电话"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input
          v-model="queryParams.email"
          placeholder="请输入邮箱"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="其他联系方式" prop="otherContact">
        <el-input
          v-model="queryParams.otherContact"
          placeholder="请输入其他联系方式"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="公司网站" prop="companyWebsite">
        <el-input
          v-model="queryParams.companyWebsite"
          placeholder="请输入公司网站"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="附件，存储路径或链接" prop="attachment">
        <el-input
          v-model="queryParams.attachment"
          placeholder="请输入附件，存储路径或链接"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:customer:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:customer:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:customer:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:customer:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="customerList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="自增主键ID" align="center" prop="id" />
      <el-table-column label="客户ID" align="center" prop="customerId" />
      <el-table-column label="公司名称" align="center" prop="companyName" />
      <el-table-column label="客户名称" align="center" prop="customerName" />
      <el-table-column label="状态类" align="center" prop="status" />
      <el-table-column label="客户类型" align="center" prop="customerType" />
      <el-table-column label="客户来源" align="center" prop="customerSource" />
      <el-table-column label="客户描述" align="center" prop="customerDescription" />
      <el-table-column label="国家地区" align="center" prop="countryRegion" />
      <el-table-column label="客户等级" align="center" prop="customerLevel" />
      <el-table-column label="自动字段" align="center" prop="createdAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="跟进内容" align="center" prop="followupContent" />
      <el-table-column label="跟进日期" align="center" prop="followupDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.followupDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="职位" align="center" prop="position" />
      <el-table-column label="联系电话" align="center" prop="contactPhone" />
      <el-table-column label="邮箱" align="center" prop="email" />
      <el-table-column label="其他联系方式" align="center" prop="otherContact" />
      <el-table-column label="公司网站" align="center" prop="companyWebsite" />
      <el-table-column label="公司地址" align="center" prop="companyAddress" />
      <el-table-column label="附件，存储路径或链接" align="center" prop="attachment" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:customer:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:customer:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改客户信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="客户ID" prop="customerId">
          <el-input v-model="form.customerId" placeholder="请输入客户ID" />
        </el-form-item>
        <el-form-item label="公司名称" prop="companyName">
          <el-input v-model="form.companyName" placeholder="请输入公司名称" />
        </el-form-item>
        <el-form-item label="客户名称" prop="customerName">
          <el-input v-model="form.customerName" placeholder="请输入客户名称" />
        </el-form-item>
        <el-form-item label="客户描述" prop="customerDescription">
          <el-input v-model="form.customerDescription" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="国家地区" prop="countryRegion">
          <el-input v-model="form.countryRegion" placeholder="请输入国家地区" />
        </el-form-item>
        <el-form-item label="客户等级" prop="customerLevel">
          <el-input v-model="form.customerLevel" placeholder="请输入客户等级" />
        </el-form-item>
        <el-form-item label="自动字段" prop="createdAt">
          <el-date-picker clearable
            v-model="form.createdAt"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择自动字段">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="跟进内容">
          <editor v-model="form.followupContent" :min-height="192"/>
        </el-form-item>
        <el-form-item label="跟进日期" prop="followupDate">
          <el-date-picker clearable
            v-model="form.followupDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择跟进日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="职位" prop="position">
          <el-input v-model="form.position" placeholder="请输入职位" />
        </el-form-item>
        <el-form-item label="联系电话" prop="contactPhone">
          <el-input v-model="form.contactPhone" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="form.email" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="其他联系方式" prop="otherContact">
          <el-input v-model="form.otherContact" placeholder="请输入其他联系方式" />
        </el-form-item>
        <el-form-item label="公司网站" prop="companyWebsite">
          <el-input v-model="form.companyWebsite" placeholder="请输入公司网站" />
        </el-form-item>
        <el-form-item label="公司地址" prop="companyAddress">
          <el-input v-model="form.companyAddress" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="附件，存储路径或链接" prop="attachment">
          <el-input v-model="form.attachment" placeholder="请输入附件，存储路径或链接" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listCustomer, getCustomer, delCustomer, addCustomer, updateCustomer } from "@/api/system/customer"

export default {
  name: "Customer",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 客户信息表格数据
      customerList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        customerId: null,
        companyName: null,
        customerName: null,
        status: null,
        customerType: null,
        customerSource: null,
        customerDescription: null,
        countryRegion: null,
        customerLevel: null,
        createdAt: null,
        followupContent: null,
        followupDate: null,
        position: null,
        contactPhone: null,
        email: null,
        otherContact: null,
        companyWebsite: null,
        companyAddress: null,
        attachment: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        customerId: [
          { required: true, message: "客户ID不能为空", trigger: "blur" }
        ],
        companyName: [
          { required: true, message: "公司名称不能为空", trigger: "blur" }
        ],
        customerName: [
          { required: true, message: "客户名称不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "状态类不能为空", trigger: "change" }
        ],
        customerType: [
          { required: true, message: "客户类型不能为空", trigger: "change" }
        ],
        customerSource: [
          { required: true, message: "客户来源不能为空", trigger: "blur" }
        ],
        countryRegion: [
          { required: true, message: "国家地区不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询客户信息列表 */
    getList() {
      this.loading = true
      listCustomer(this.queryParams).then(response => {
        this.customerList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        customerId: null,
        companyName: null,
        customerName: null,
        status: null,
        customerType: null,
        customerSource: null,
        customerDescription: null,
        countryRegion: null,
        customerLevel: null,
        createdAt: null,
        followupContent: null,
        followupDate: null,
        position: null,
        contactPhone: null,
        email: null,
        otherContact: null,
        companyWebsite: null,
        companyAddress: null,
        attachment: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加客户信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getCustomer(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改客户信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateCustomer(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addCustomer(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除客户信息编号为"' + ids + '"的数据项？').then(function() {
        return delCustomer(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/customer/export', {
        ...this.queryParams
      }, `customer_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
