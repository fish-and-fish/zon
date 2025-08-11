<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="客户编号" prop="customerId">
        <el-input
          v-model="queryParams.customerId"
          placeholder="请输入客户编号"
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

      <!-- 状态类 下拉框 -->
      <el-form-item label="状态类" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态类" clearable>
          <el-option v-for="opt in statusOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
        </el-select>
      </el-form-item>

      <!-- 客户类型 下拉框 -->
      <el-form-item label="客户类型" prop="customerType">
        <el-select v-model="queryParams.customerType" placeholder="请选择客户类型" clearable>
          <el-option v-for="opt in customerTypeOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
        </el-select>
      </el-form-item>

      <!-- 客户来源 下拉框 -->
      <el-form-item label="客户来源" prop="customerSource">
        <el-select v-model="queryParams.customerSource" placeholder="请选择客户来源" clearable>
          <el-option v-for="opt in customerSourceOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
        </el-select>
      </el-form-item>

      <!-- 国家地区 下拉框 -->
      <el-form-item label="国家地区" prop="countryRegion">
        <el-select v-model="queryParams.countryRegion" placeholder="请选择国家地区" clearable filterable>
          <el-option v-for="c in countryList" :key="c.code" :label="c.name" :value="c.name" />
        </el-select>
      </el-form-item>

      <el-form-item label="客户等级" prop="customerLevel">
        <el-input
          v-model="queryParams.customerLevel"
          placeholder="请输入客户等级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创建日期" prop="createdAt">
        <el-date-picker clearable
                        v-model="queryParams.createdAt"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择创建日期">
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
      <el-form-item label="附件路径或链接" prop="attachment">
        <el-input
          v-model="queryParams.attachment"
          placeholder="请输入附件路径或链接"
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
      <el-table-column label="客户编号" align="center" prop="customerId" />
      <el-table-column label="公司名称" align="center" prop="companyName" />
      <el-table-column label="客户名称" align="center" prop="customerName" />
      <el-table-column label="状态类" align="center" prop="status" />
      <el-table-column label="客户类型" align="center" prop="customerType" />
      <el-table-column label="客户来源" align="center" prop="customerSource" />
      <el-table-column label="客户描述" align="center" prop="customerDescription" />
      <el-table-column label="国家地区" align="center" prop="countryRegion" />
      <el-table-column label="客户等级" align="center" prop="customerLevel" />
      <el-table-column label="创建日期" align="center" prop="createdAt" width="180">
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
      <el-table-column label="附件路径或链接" align="center" prop="attachment" />
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
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-row :gutter="12">
          <el-col :span="12">
            <el-form-item label="客户编号" prop="customerId">
              <el-input v-model="form.customerId" placeholder="A1国家+公司编号+人员编号（示例 A1CN0000101）" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="公司名称" prop="companyName">
              <el-input v-model="form.companyName" placeholder="请输入公司名称" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="12">
          <el-col :span="12">
            <el-form-item label="客户名称" prop="customerName">
              <el-input v-model="form.customerName" placeholder="请输入客户名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态类" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态类">
                <el-option v-for="opt in statusOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="12">
          <el-col :span="12">
            <el-form-item label="客户类型" prop="customerType">
              <el-select v-model="form.customerType" placeholder="请选择客户类型">
                <el-option v-for="opt in customerTypeOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="客户来源" prop="customerSource">
              <el-select v-model="form.customerSource" placeholder="请选择客户来源">
                <el-option v-for="opt in customerSourceOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="国家地区" prop="countryRegion">
          <el-select v-model="form.countryRegion" placeholder="请选择国家地区" filterable>
            <el-option v-for="c in countryList" :key="c.code" :label="c.name" :value="c.name" />
          </el-select>
        </el-form-item>

        <el-form-item label="客户描述" prop="customerDescription">
          <el-input v-model="form.customerDescription" type="textarea" placeholder="请输入内容" />
        </el-form-item>


        <!-- 客户等级 -->
        <el-row :gutter="12">
          <el-col :span="12">
            <el-form-item label="客户等级" prop="customerLevel">
              <el-input v-model="form.customerLevel" placeholder="请输入客户等级" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="12">
          <el-col :span="12">
            <el-form-item label="创建日期" prop="createdAt">
              <el-date-picker
                clearable
                v-model="form.createdAt"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择创建日期">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="跟进内容">
          <editor v-model="form.followupContent" :min-height="140"/>
        </el-form-item>
        <el-form-item label="跟进日期" prop="followupDate">
          <el-date-picker clearable
                          v-model="form.followupDate"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择跟进日期">
          </el-date-picker>
        </el-form-item>

        <el-row :gutter="12">
          <el-col :span="12">
            <el-form-item label="职位" prop="position">
              <el-input v-model="form.position" placeholder="请输入职位" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input v-model="form.contactPhone" placeholder="请输入联系电话" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="12">
          <el-col :span="12">
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="其他联系方式" prop="otherContact">
              <el-input v-model="form.otherContact" placeholder="请输入其他联系方式" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="公司网站" prop="companyWebsite">
          <el-input v-model="form.companyWebsite" placeholder="请输入公司网站" />
        </el-form-item>

        <el-form-item label="公司地址" prop="companyAddress">
          <el-input v-model="form.companyAddress" type="textarea" placeholder="请输入公司地址" />
        </el-form-item>

        <el-form-item label="附件路径或链接" prop="attachment">
          <el-input v-model="form.attachment" placeholder="请输入附件路径或链接" />
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
      // UI / control
      loading: false,
      showSearch: true,
      ids: [],
      single: true,
      multiple: true,
      total: 0,
      customerList: [],
      title: "",
      open: false,

      // 下拉选项（可以根据需要改为从后端拉取）
      statusOptions: [
        { label: "活跃P2", value: "P2" },      // 注意：实际存储值我这里用 "P2"
        { label: "非活跃", value: "INACTIVE" }
      ],
      customerTypeOptions: [
        { label: "订单客户", value: "订单客户" },
        { label: "样单客户", value: "样单客户" },
        { label: "重潜客户", value: "重潜客户" },
        { label: "轻潜客户", value: "轻潜客户" },
        { label: "无潜客户", value: "无潜客户" }
      ],
      customerSourceOptions: [
        { label: "阿里国际站", value: "阿里国际站" },
        { label: "邮件", value: "邮件" },
        { label: "公司客户", value: "公司客户" },
        { label: "展会", value: "展会" },
        { label: "领英", value: "领英" },
        { label: "ins", value: "ins" },
        { label: "Facebook", value: "Facebook" },
        { label: "Tiktok", value: "Tiktok" },
        { label: "1688", value: "1688" }
      ],
      countryList: [
        { code: "CN", name: "中国" },
        { code: "US", name: "美国" },
        { code: "GB", name: "英国" },
        { code: "CA", name: "加拿大" },
        { code: "AU", name: "澳大利亚" }
      ],

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

      // 表单数据
      form: {
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
      },

      // 表单校验
      rules: {
        customerId: [
          { required: true, message: "客户编号不能为空", trigger: "blur" },
          // 简单格式校验示例（可根据真实规则调整）：A1开头 + 至少后续 6~20 字符
          // { pattern: /^A1[A-Za-z0-9\-_]{6,20}$/, message: "客户ID 格式不正确（示例 A1CN0000101）", trigger: "blur" }
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
          { required: true, message: "客户来源不能为空", trigger: "change" }
        ],
        countryRegion: [
          { required: true, message: "国家地区不能为空", trigger: "change" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    // 列表查询
    getList() {
      this.loading = true
      listCustomer(this.queryParams).then(response => {
        // 兼容不同返回格式
        if (response && response.rows) {
          this.customerList = response.rows
          this.total = response.total || (response.rows.length)
        } else if (response && response.data) {
          // 如果后端返回 { data: { rows, total } }
          this.customerList = response.data.rows || []
          this.total = response.data.total || this.customerList.length
        } else {
          this.customerList = []
          this.total = 0
        }
      }).catch(err => {
        console.error("listCustomer error", err)
        this.customerList = []
        this.total = 0
      }).finally(() => {
        this.loading = false
      })
    },

    // 搜索
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },

    cancel() {
      this.open = false
    },

    // 重置查询
    resetQuery() {
      // 重置 queryParams 到初始值
      this.queryParams = {
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
      }
      // 如果有 queryForm 引用，重置表单控件状态
      this.resetForm("queryForm")
      this.getList()
    },

    // 选择变更
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = selection.length === 0
    },

    // 新增
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加客户信息"
    },

    // 修改
    handleUpdate(row) {
      this.reset()
      const id = (row && row.id) ? row.id : (Array.isArray(this.ids) && this.ids.length === 1 ? this.ids[0] : null)
      if (!id) {
        this.$modal && this.$modal.msgWarning && this.$modal.msgWarning("请选择要修改的一条记录")
        return
      }
      getCustomer(id).then(response => {
        // 兼容 response.data 或 response
        const data = response && response.data ? response.data : response
        this.form = Object.assign({}, this.form, data)
        this.open = true
        this.title = "修改客户信息"
      }).catch(err => {
        console.error("getCustomer error", err)
      })
    },

    // 提交新增/更新
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateCustomer(this.form).then(() => {
              this.$modal && this.$modal.msgSuccess && this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            }).catch(err => {
              console.error("updateCustomer error", err)
            })
          } else {
            addCustomer(this.form).then(() => {
              this.$modal && this.$modal.msgSuccess && this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            }).catch(err => {
              console.error("addCustomer error", err)
            })
          }
        }
      })
    },

    // 删除
    handleDelete(row) {
      const ids = row && row.id ? row.id : this.ids
      if (!ids || (Array.isArray(ids) && ids.length === 0)) {
        this.$modal && this.$modal.msgWarning && this.$modal.msgWarning("请选择要删除的记录")
        return
      }
      this.$modal.confirm('是否确认删除客户信息编号为"' + ids + '"的数据项？').then(() => {
        return delCustomer(ids)
      }).then(() => {
        this.getList()
        this.$modal && this.$modal.msgSuccess && this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },

    // 导出（使用项目全局 download 方法）
    handleExport() {
      // fallback: 如果全局 this.download 存在就使用，否则提示
      if (this.download) {
        this.download('system/customer/export', { ...this.queryParams }, `customer_${new Date().getTime()}.xlsx`)
      } else {
        this.$modal && this.$modal.msgWarning && this.$modal.msgWarning("导出功能未实现")
      }
    },

    // 重置表单（安全实现，避免 $refs 未定义）
    resetForm(refName) {
      if (!refName) return
      const ref = this.$refs[refName]
      if (ref) {
        if (typeof ref.resetFields === "function") {
          ref.resetFields()
        } else if (typeof ref.reset === "function") {
          ref.reset()
        }
      }
    },

    // 重置新增/编辑表单数据
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

    // 辅助：简单的时间格式化（避免 parseTime 未定义导致模板报错）
    parseTime(time, pattern = '{y}-{m}-{d} {h}:{i}:{s}') {
      if (!time) return ''
      // 如果 time 已经是字符串 "YYYY-MM-DD" 直接返回截取
      if (typeof time === 'string' && time.includes('-')) {
        return time.split('T')[0]
      }
      const date = time instanceof Date ? time : new Date(time)
      const y = date.getFullYear()
      const m = (date.getMonth() + 1 + '').padStart(2, '0')
      const d = (date.getDate() + '').padStart(2, '0')
      return `${y}-${m}-${d}`
    }
  }
}
</script>

<style scoped>
.small-padding {
  padding: 0 6px;
}
.fixed-width {
  width: 140px;
}
.mb8 {
  margin-bottom: 8px;
}
</style>
