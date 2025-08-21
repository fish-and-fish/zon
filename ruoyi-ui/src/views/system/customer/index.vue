<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="50px">
      <el-form-item label="" prop="customerId">
        <el-input
          v-model="queryParams.customerId"
          placeholder="请输入客户编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="companyName">
        <el-input
          v-model="queryParams.companyName"
          placeholder="请输入公司名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="customerName">
        <el-input
          v-model="queryParams.customerName"
          placeholder="请输入客户名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>

      <!-- 状态类 下拉框 -->
      <el-form-item label="" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态类" clearable>
          <el-option v-for="opt in statusOptions" :key="opt.value" :label="opt.label" :value="opt.value"/>
        </el-select>
      </el-form-item>

      <!-- 客户类型 下拉框 -->
      <el-form-item label="" prop="customerType">
        <el-select v-model="queryParams.customerType" placeholder="请选择客户类型" clearable>
          <el-option v-for="opt in customerTypeOptions" :key="opt.value" :label="opt.label" :value="opt.value"/>
        </el-select>
      </el-form-item>

      <!-- 客户来源 下拉框 -->
      <el-form-item label="" prop="customerSource">
        <el-select v-model="queryParams.customerSource" placeholder="请选择客户来源" clearable>
          <el-option v-for="opt in customerSourceOptions" :key="opt.value" :label="opt.label" :value="opt.value"/>
        </el-select>
      </el-form-item>

      <!-- 国家地区 下拉框 -->
      <el-form-item label="" prop="countryRegion">
        <el-select v-model="queryParams.countryRegion" placeholder="请选择国家地区" clearable filterable>
          <el-option v-for="c in countryList" :key="c.code" :label="c.name" :value="c.code"/>
        </el-select>
      </el-form-item>

      <el-form-item label="" prop="customerLevel">
        <el-input
          v-model="queryParams.customerLevel"
          placeholder="请输入客户等级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="followupDate">
        <el-date-picker clearable
                        v-model="queryParams.followupDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择跟进日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="" prop="position">
        <el-input
          v-model="queryParams.position"
          placeholder="请输入职位"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="contactPhone">
        <el-input
          v-model="queryParams.contactPhone"
          placeholder="请输入联系电话"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="email">
        <el-input
          v-model="queryParams.email"
          placeholder="请输入邮箱"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="otherContact">
        <el-input
          v-model="queryParams.otherContact"
          placeholder="请输入其他联系方式"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="companyWebsite">
        <el-input
          v-model="queryParams.companyWebsite"
          placeholder="请输入公司网站"
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
        >新增
        </el-button>
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
        >修改
        </el-button>
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
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:customer:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="customerList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <!--      <el-table-column label="自增主键ID" align="center" prop="id" />-->
      <el-table-column label="客户编号" align="center" prop="customerId" width="100px"/>
      <el-table-column label="公司名称" align="center" prop="companyName" width="140px"/>
      <el-table-column label="客户名称" align="center" prop="customerName" width="120px"/>
      <el-table-column label="状态类" align="center">
        <template slot-scope="scope">
          {{ getStatusNameByValue(scope.row.status) }}
        </template>
      </el-table-column>
      <el-table-column label="客户类型" align="center" prop="customerType"/>
      <el-table-column label="客户来源" align="center" prop="customerSource" width="100px"/>
      <el-table-column
        label="客户描述"
        align="center"
        prop="customerDescription"
        min-width="300"
        show-overflow-tooltip>
        <template slot-scope="scope">
    <span
      class="desc-cell"
      @click="openDescDialog(scope.row.customerDescription)"
      style="cursor: pointer; color: #409EFF;"
    >
      {{ scope.row.customerDescription }}
    </span>
        </template>
      </el-table-column>

      <el-dialog
        title="客户描述详情"
        :visible.sync="descDialogVisible"
        width="60%"
        center
        class="desc-dialog"
      >
        <div class="desc-content">
          {{ descDialogContent }}
        </div>
      </el-dialog>
      <el-table-column label="国家地区" align="center">
        <template slot-scope="scope">
          {{ getCountryNameByCode(scope.row.countryRegion) }}
        </template>
      </el-table-column>
      <el-table-column label="客户等级" align="center" prop="customerLevel"/>
      <!--      <el-table-column label="跟进内容" align="center" prop="followupContent" />-->
      <!--      <el-table-column label="跟进日期" align="center" prop="followupDate" width="180">-->
      <!--        <template slot-scope="scope">-->
      <!--          <span>{{ parseTime(scope.row.followupDate, '{y}-{m}-{d}') }}</span>-->
      <!--        </template>-->
      <!--      </el-table-column>-->
      <el-table-column label="职位" align="center" prop="position"/>
      <el-table-column label="联系电话" align="center" prop="contactPhone" width="100px"/>
      <el-table-column label="邮箱" align="center" prop="email" width="100px"/>
      <el-table-column label="其他联系方式" align="center" prop="otherContact" width="120px"/>
      <el-table-column label="公司网站" align="center" prop="companyWebsite" width="100px"/>
      <el-table-column
        label="公司地址"
        align="center"
        prop="companyAddress"
        min-width="400"
        show-overflow-tooltip>
        <template slot-scope="scope">
    <span
      class="desc-cell"
      @click="openDescDialog(scope.row.companyAddress)"
      style="cursor: pointer; color: #409EFF;"
    >
      {{ scope.row.companyAddress }}
    </span>
        </template>
      </el-table-column>

      <el-dialog
        title="公司地址详情"
        :visible.sync="descDialogVisible"
        width="60%"
        center
        class="desc-dialog"
      >
        <div class="desc-content">
          {{ descDialogContent }}
        </div>
      </el-dialog>

      <!-- 文件预览弹窗 -->
      <el-dialog
        title="文件预览"
        :visible.sync="previewDialogVisible"
        width="80%"
        center
        class="preview-dialog"
      >
        <div class="preview-content">
          <div v-if="previewDialogContent">
            <h4 style="margin-bottom: 20px;">{{ previewDialogContent.originalFilename }}</h4>
            <template v-if="isImageFile(previewDialogContent.originalFilename)">
              <img :src="previewDialogContent.url" alt="预览图片" style="max-width: 100%; max-height: 70vh;">
            </template>
            <template v-else-if="isPdfFile(previewDialogContent.originalFilename)">
              <embed :src="previewDialogContent.url" type="application/pdf" style="width: 100%; height: 70vh;">
            </template>
            <template v-else>
              <p>该文件类型无法在线预览，请<a :href="previewDialogContent.url" target="_blank">点击下载</a>后查看。</p>
            </template>
            <div style="margin-top: 20px;">
              <el-button size="small" type="primary" :href="previewDialogContent.url" target="_blank" download>
                下载文件
              </el-button>
            </div>
          </div>
        </div>
      </el-dialog>

      <el-table-column label="附件" align="center" width="200px">
        <template slot-scope="scope">
          <div v-if="scope.row.attachment">
            <template v-for="(file, index) in parseAttachment(scope.row.attachment)">
              <el-popover
                :key="index"
                placement="right"
                trigger="hover"
                width="220"
              >
                <img :src="file.url" alt="预览" style="max-width: 200px; max-height: 200px;" />

                <el-link
                  slot="reference"
                  :underline="false"
                  @click="openFilePreview(file)"
                  style="cursor: pointer; color: #409EFF; display: block; margin-bottom: 5px;"
                >
                  {{ file.originalFilename }}
                </el-link>
              </el-popover>
            </template>
          </div>
          <span v-else></span>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:customer:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:customer:remove']"
          >删除
          </el-button>
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
    <el-dialog :title="title" :visible.sync="open" width="1200px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-row :gutter="12">
          <el-col :span="6">
            <el-form-item label="国家地区" prop="countryRegion">
              <el-select v-model="form.countryRegion" placeholder="请选择国家地区" filterable :disabled="isEdit">
                <el-option v-for="c in countryList" :key="c.code" :label="c.name" :value="c.code"/>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="9">
            <el-form-item label="公司名称" prop="companyName">
              <el-input v-model="form.companyName" placeholder="请输入公司名称" :disabled="isEdit"/>
            </el-form-item>
          </el-col>
          <el-col :span="9">
            <el-form-item label="客户名称" prop="customerName">
              <el-input v-model="form.customerName" placeholder="请输入客户名称" :disabled="isEdit"/>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="12">
          <el-col :span="6">
            <el-form-item label="状态类" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态类">
                <el-option v-for="opt in statusOptions" :key="opt.value" :label="opt.label" :value="opt.value"/>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="9">
            <el-form-item label="客户类型" prop="customerType">
              <el-select v-model="form.customerType" placeholder="请选择客户类型">
                <el-option v-for="opt in customerTypeOptions" :key="opt.value" :label="opt.label" :value="opt.value"/>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="9">
            <el-form-item label="客户来源" prop="customerSource">
              <el-select v-model="form.customerSource" placeholder="请选择客户来源">
                <el-option v-for="opt in customerSourceOptions" :key="opt.value" :label="opt.label" :value="opt.value"/>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="客户描述" prop="customerDescription">
          <el-input v-model="form.customerDescription" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="跟进记录">
          <el-table :data="form.followups" border style="width: 100%">
            <el-table-column label="跟进内容" align="center">
              <template slot-scope="scope">
                <el-input v-model="scope.row.content" placeholder="请输入跟进内容"></el-input>
              </template>
            </el-table-column>

            <el-table-column label="跟进时间" align="center" width="200">
              <template slot-scope="scope">
                <el-date-picker
                  v-model="scope.row.date"
                  type="date"
                  value-format="yyyy-MM-dd"
                  placeholder="选择日期">
                </el-date-picker>
              </template>
            </el-table-column>

            <el-table-column label="操作" align="center" width="120">
              <template slot-scope="scope">
                <el-button type="text" size="small" @click="removeFollowup(scope.$index)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>

          <el-button type="primary" size="mini" @click="addFollowup" style="margin-top: 10px;">
            新增跟进
          </el-button>
        </el-form-item>

        <el-row :gutter="12">
          <el-col :span="12">
            <el-form-item label="客户等级" prop="customerLevel">
              <el-input v-model="form.customerLevel" placeholder="请输入客户等级"/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="职位" prop="position">
              <el-input v-model="form.position" placeholder="请输入职位"/>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="12">
          <el-col :span="8">
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input v-model="form.contactPhone" placeholder="请输入联系电话"/>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱"/>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="其他联系方式" prop="otherContact">
              <el-input v-model="form.otherContact" placeholder="请输入其他联系方式"/>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="公司网站" prop="companyWebsite">
          <el-input v-model="form.companyWebsite" placeholder="请输入公司网站"/>
        </el-form-item>

        <el-form-item label="公司地址" prop="companyAddress">
          <el-input v-model="form.companyAddress" type="textarea" placeholder="请输入公司地址"/>
        </el-form-item>

        <el-form-item label="上传附件" prop="attachment">
          <FileUpload
            v-model="fileAttachments"
            :limit="3"
            :fileSize="10"
            :fileType="['pdf', 'docx', 'xlsx', 'jpg', 'png', 'jpeg']"
            :disabled="false"
            @on-success="handleAttachmentUploadSuccess"
          />
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
import {listCustomer, getCustomer, delCustomer, addCustomer, updateCustomer} from "@/api/system/customer";
import countryList from "@/utils/dict/CountryList";
import FileUpload from "@/components/FileUpload/index.vue";

export default {
  components: {
    // 注册FileUpload组件
    FileUpload
  },
  name: "Customer",
  data() {
    return {
      // UI / control
      loading: false,
      showSearch: true,
      ids: [],
      single: true,
      multiple: true,
      isEdit: false,
      total: 0,
      customerList: [],
      title: "",
      open: false,
      descDialogVisible: false,
      descDialogContent: "",
      addressDialogVisible: false,  // 新增
      addressDialogContent: "",     // 新增
      // 新增：文件附件数组和预览弹窗状态
      fileAttachments: [],
      previewDialogVisible: false,
      previewDialogContent: null,
      // 下拉选项（可以根据需要改为从后端拉取）
      statusOptions: [
        {label: "活跃P2", value: "P2"},      // 注意：实际存储值我这里用 "P2"
        {label: "非活跃", value: "INACTIVE"}
      ],
      customerTypeOptions: [
        {label: "订单客户", value: "订单客户"},
        {label: "样单客户", value: "样单客户"},
        {label: "重潜客户", value: "重潜客户"},
        {label: "轻潜客户", value: "轻潜客户"},
        {label: "无潜客户", value: "无潜客户"}
      ],
      customerSourceOptions: [
        {label: "阿里国际站", value: "阿里国际站"},
        {label: "邮件", value: "邮件"},
        {label: "公司客户", value: "公司客户"},
        {label: "展会", value: "展会"},
        {label: "领英", value: "领英"},
        {label: "ins", value: "ins"},
        {label: "Facebook", value: "Facebook"},
        {label: "Tiktok", value: "Tiktok"},
        {label: "1688", value: "1688"}
      ],
      countryList,
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
        // followupContent: null,
        // followupDate: null,
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
        // createdAt: null,
        // followupContent: null,
        // followupDate: null,
        followups: [],
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
          {required: true, message: "客户编号不能为空", trigger: "blur"},
          // 简单格式校验示例（可根据真实规则调整）：A1开头 + 至少后续 6~20 字符
          // { pattern: /^A1[A-Za-z0-9\-_]{6,20}$/, message: "客户ID 格式不正确（示例 A1CN0000101）", trigger: "blur" }
        ],
        companyName: [
          {required: true, message: "公司名称不能为空", trigger: "blur"}
        ],
        customerName: [
          {required: true, message: "客户名称不能为空", trigger: "blur"}
        ],
        status: [
          {required: true, message: "状态类不能为空", trigger: "change"}
        ],
        customerType: [
          {required: true, message: "客户类型不能为空", trigger: "change"}
        ],
        customerSource: [
          {required: true, message: "客户来源不能为空", trigger: "change"}
        ],
        countryRegion: [
          {required: true, message: "国家地区不能为空", trigger: "change"}
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    openDescDialog(content) {
      this.descDialogContent = content;
      this.descDialogVisible = true;
    },
    // 添加这个方法
    getStatusNameByValue(value) {
      const status = this.statusOptions.find(opt => opt.value === value);
      return status ? status.label : value;
    },
    // 原来的国家地区转换方法
    getCountryNameByCode(code) {
      const country = this.countryList.find(c => c.code === code);
      return country ? country.name : code;
    },

    handleAttachmentUploadSuccess(response, file) {
      // if (response && file) {
      //   const fileUrl = response.url || (response.data && response.data.url) || '';
      //   if (fileUrl) {
      //     const originalFilename = file.name || (response.data && response.data.originalFilename) || response.originalFilename || 'unknown_file';
      //     const fileObj = {
      //       url: fileUrl,
      //       originalFilename: originalFilename,
      //       name: file.fileName
      //     };
      //     this.fileAttachments.push(fileObj);
      //   }
      // }
    },
    addFollowup() {
      this.form.followups.push({
        content: '',
        date: ''
      })
    },
    removeFollowup(index) {
      this.form.followups.splice(index, 1)
    },
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
        // createdAt: null,
        // followupContent: null,
        // followupDate: null,
        followups: [],
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

    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加客户信息"
      this.isEdit = false   // 新增模式下可编辑
    },

    handleUpdate(row) {
      this.reset();
      const id = row.id;
      getCustomer(id).then(response => {
        const data = response.data;
        this.form = Object.assign({}, this.form, data);
        this.form.followups = JSON.parse(data.followupJson || "[]");

        // 回显附件
        if (data.attachment) {
          try {
            const attachments = JSON.parse(data.attachment);
            if (Array.isArray(attachments)) {
              this.fileAttachments = attachments; // [{"url":"...","originalFilename":"..."}]
            } else {
              this.fileAttachments = [attachments];
            }
          } catch (e) {
            // 如果解析失败，说明是旧格式
            this.fileAttachments = [{url: data.attachment, originalFilename: data.attachment.split('/').pop()}];
          }
        }
        this.open = true;
        this.title = "修改客户信息";
        this.isEdit = true;
      });
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // 把附件存为 JSON 数组
          this.form.attachment = this.fileAttachments.length > 0
            ? JSON.stringify(this.fileAttachments)
            : JSON.stringify([]);

          const payload = {
            ...this.form,
            followupJson: JSON.stringify(this.form.followups)
          };

          if (this.form.id != null) {
            updateCustomer(payload).then(() => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addCustomer(payload).then(() => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
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
      }).catch(() => {
      })
    },

    // 导出（使用项目全局 download 方法）
    handleExport() {
      // fallback: 如果全局 this.download 存在就使用，否则提示
      if (this.download) {
        this.download('system/customer/export', {...this.queryParams}, `customer_${new Date().getTime()}.xlsx`)
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
    // 修改reset方法，确保重置附件数据
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
        followups: [],
        position: null,
        contactPhone: null,
        email: null,
        otherContact: null,
        companyWebsite: null,
        companyAddress: null,
        attachment: null
      }
      // 重置附件相关数据
      this.fileAttachments = [];
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
    },

    // 解析附件数据
    parseAttachment(attachmentData) {
      if (!attachmentData) return [];
      try {
        const attachments = JSON.parse(attachmentData);
        if (Array.isArray(attachments)) {
          return attachments.map(attach => ({
            url: attach.url,
            originalFilename: attach.originalFilename || attach.url.split('/').pop()
          }));
        } else if (typeof attachments === "object") {
          return [attachments];
        } else {
          return [{url: attachmentData, originalFilename: attachmentData.split('/').pop()}];
        }
      } catch {
        return [{url: attachmentData, originalFilename: attachmentData.split('/').pop()}];
      }
    },
    // 文件预览方法
    openFilePreview(fileInfo) {
      this.previewDialogContent = fileInfo;
      this.previewDialogVisible = true;
    },

    // 判断是否为图片文件
    isImageFile(filename) {
      const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
      const extension = filename.split('.').pop().toLowerCase();
      return imageExtensions.includes(extension);
    },

    // 判断是否为PDF文件
    isPdfFile(filename) {
      return filename.toLowerCase().endsWith('.pdf');
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

.desc-dialog .el-dialog {
  max-width: 400px; /* 最大宽度限制 */
  width: 60%; /* 基础宽度 */
}

.desc-content {
  max-height: 60vh; /* 最大高度限制，防止内容过长 */
  overflow-y: auto; /* 添加滚动条 */
  padding: 10px;
}

.preview-dialog .el-dialog {
  max-width: 90vw; /* 最大宽度限制 */
  width: 80%; /* 基础宽度 */
}

.preview-content {
  max-height: 70vh; /* 最大高度限制，防止内容过长 */
  overflow-y: auto; /* 添加滚动条 */
  padding: 10px;
}
</style>
