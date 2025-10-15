<template>
  <el-dialog
    v-model="dialogVisible"
    :title="isEdit ? '编辑日程' : '添加日程'"
    width="90%"
    :close-on-click-modal="false"
    :close-on-press-escape="true"
    class="mobile-dialog"
    @close="handleClose"
  >
    <el-form
      ref="formRef"
      :model="formData"
      :rules="rules"
      label-width="70px"
      label-position="top"
      class="mobile-form"
    >
      <el-form-item label="标题" prop="title">
        <el-input
          v-model="formData.title"
          placeholder="请输入日程标题"
          maxlength="50"
          show-word-limit
        />
      </el-form-item>
      
      <el-form-item label="描述" prop="description">
        <el-input
          v-model="formData.description"
          type="textarea"
          placeholder="请输入日程描述"
          :rows="2"
          maxlength="200"
          show-word-limit
        />
      </el-form-item>
      
      <el-row :gutter="15">
        <el-col :span="12">
          <el-form-item label="日期" prop="date">
            <el-date-picker
              v-model="formData.date"
              type="date"
              placeholder="选择日期"
              format="MM-DD"
              value-format="YYYY-MM-DD"
              style="width: 100%"
              size="large"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="时间" prop="time">
            <el-time-picker
              v-model="formData.time"
              placeholder="选择时间"
              format="HH:mm"
              value-format="HH:mm"
              style="width: 100%"
              size="large"
            />
          </el-form-item>
        </el-col>
      </el-row>
      
      <el-row :gutter="15">
        <el-col :span="12">
          <el-form-item label="优先级" prop="priority">
            <el-select v-model="formData.priority" placeholder="选择优先级" style="width: 100%" size="large">
              <el-option label="高" value="high">
                <div class="priority-option">
                  <span class="priority-dot high"></span>
                  <span>高</span>
                </div>
              </el-option>
              <el-option label="中" value="medium">
                <div class="priority-option">
                  <span class="priority-dot medium"></span>
                  <span>中</span>
                </div>
              </el-option>
              <el-option label="低" value="low">
                <div class="priority-option">
                  <span class="priority-dot low"></span>
                  <span>低</span>
                </div>
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="分类" prop="category">
            <el-select v-model="formData.category" placeholder="选择分类" style="width: 100%" size="large">
              <el-option label="工作" value="工作" />
              <el-option label="学习" value="学习" />
              <el-option label="生活" value="生活" />
              <el-option label="健康" value="健康" />
              <el-option label="其他" value="其他" />
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      
      <el-form-item label="提醒设置">
        <div class="reminder-setting">
          <el-switch
            v-model="formData.reminder"
            size="large"
          />
          <span class="reminder-text">{{ formData.reminder ? '开启提醒' : '关闭提醒' }}</span>
        </div>
        <div v-if="formData.reminder" class="reminder-time">
          <el-select v-model="formData.reminderTime" placeholder="选择提醒时间" size="large" style="width: 100%">
            <el-option label="提前5分钟" value="5" />
            <el-option label="提前10分钟" value="10" />
            <el-option label="提前15分钟" value="15" />
            <el-option label="提前30分钟" value="30" />
            <el-option label="提前1小时" value="60" />
            <el-option label="提前1天" value="1440" />
          </el-select>
        </div>
      </el-form-item>
    </el-form>
    
    <template #footer>
      <div class="dialog-footer">
        <el-button size="large" @click="handleClose" class="cancel-btn">取消</el-button>
        <el-button type="primary" size="large" @click="handleSave" :loading="loading" class="save-btn">
          {{ isEdit ? '更新' : '添加' }}
        </el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, computed, watch, nextTick } from 'vue'
import { ElMessage } from 'element-plus'
import dayjs from 'dayjs'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  schedule: {
    type: Object,
    default: null
  }
})

const emit = defineEmits(['update:modelValue', 'save', 'close'])

const formRef = ref()
const loading = ref(false)

// 表单数据
const formData = ref({
  title: '',
  description: '',
  date: dayjs().format('YYYY-MM-DD'),
  time: dayjs().format('HH:mm'),
  priority: 'medium',
  category: '工作',
  reminder: false,
  reminderTime: '15'
})

// 表单验证规则
const rules = {
  title: [
    { required: true, message: '请输入日程标题', trigger: 'blur' },
    { min: 2, max: 50, message: '标题长度在 2 到 50 个字符', trigger: 'blur' }
  ],
  description: [
    { max: 200, message: '描述长度不能超过 200 个字符', trigger: 'blur' }
  ],
  date: [
    { required: true, message: '请选择日期', trigger: 'change' }
  ],
  time: [
    { required: true, message: '请选择时间', trigger: 'change' }
  ],
  priority: [
    { required: true, message: '请选择优先级', trigger: 'change' }
  ],
  category: [
    { required: true, message: '请选择分类', trigger: 'change' }
  ]
}

// 计算属性
const dialogVisible = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

const isEdit = computed(() => !!props.schedule)

// 监听日程数据变化
watch(() => props.schedule, (newSchedule) => {
  if (newSchedule) {
    formData.value = {
      title: newSchedule.title || '',
      description: newSchedule.description || '',
      date: newSchedule.date || dayjs().format('YYYY-MM-DD'),
      time: newSchedule.time || dayjs().format('HH:mm'),
      priority: newSchedule.priority || 'medium',
      category: newSchedule.category || '工作',
      reminder: newSchedule.reminder || false,
      reminderTime: newSchedule.reminderTime || '15'
    }
  } else {
    // 重置表单数据
    formData.value = {
      title: '',
      description: '',
      date: dayjs().format('YYYY-MM-DD'),
      time: dayjs().format('HH:mm'),
      priority: 'medium',
      category: '工作',
      reminder: false,
      reminderTime: '15'
    }
    nextTick(() => {
      formRef.value?.clearValidate()
    })
  }
}, { immediate: true })

// 方法
const handleClose = () => {
  dialogVisible.value = false
  emit('close')
  // 重置表单数据
  formData.value = {
    title: '',
    description: '',
    date: dayjs().format('YYYY-MM-DD'),
    time: dayjs().format('HH:mm'),
    priority: 'medium',
    category: '工作',
    reminder: false,
    reminderTime: '15'
  }
  nextTick(() => {
    formRef.value?.clearValidate()
  })
}

const handleSave = async () => {
  try {
    await formRef.value.validate()
    loading.value = true
    
    const scheduleData = {
      ...formData.value,
      reminder: formData.value.reminder ? parseInt(formData.value.reminderTime) : 0
    }
    
    emit('save', scheduleData)
  } catch (error) {
    ElMessage.error('请检查表单填写是否正确')
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.priority-option {
  display: flex;
  align-items: center;
  gap: 8px;
}

.priority-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  display: inline-block;
}

.priority-dot.high {
  background: #ff6b6b;
}

.priority-dot.medium {
  background: #feca57;
}

.priority-dot.low {
  background: #48dbfb;
}

.form-tip {
  margin-left: 10px;
  color: #999;
  font-size: 0.85rem;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 15px;
}

:deep(.el-form-item__label) {
  font-weight: 500;
  color: #2c3e50;
}

:deep(.el-input__wrapper) {
  border-radius: 8px;
}

:deep(.el-textarea__inner) {
  border-radius: 8px;
}

:deep(.el-select .el-input__wrapper) {
  border-radius: 8px;
}

:deep(.el-date-editor) {
  border-radius: 8px;
}

:deep(.el-time-picker) {
  border-radius: 8px;
}

/* 移动端优化样式 */
.mobile-dialog {
  margin: 0 !important;
  max-height: 90vh;
  overflow-y: auto;
}

.mobile-dialog :deep(.el-dialog) {
  margin: 0 !important;
  max-height: 90vh;
  display: flex;
  flex-direction: column;
}

.mobile-dialog :deep(.el-dialog__body) {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
}

.mobile-dialog :deep(.el-dialog__header) {
  padding: 20px 20px 0;
  border-bottom: 1px solid #f0f0f0;
}

.mobile-dialog :deep(.el-dialog__footer) {
  padding: 20px;
  border-top: 1px solid #f0f0f0;
  background: #fafafa;
}

.mobile-form {
  padding: 0;
}

.mobile-form :deep(.el-form-item) {
  margin-bottom: 20px;
}

.mobile-form :deep(.el-form-item__label) {
  font-weight: 600;
  color: #2c3e50;
  margin-bottom: 8px;
  line-height: 1.4;
}

.mobile-form :deep(.el-input__wrapper) {
  border-radius: 12px;
  padding: 12px 16px;
  font-size: 16px;
}

.mobile-form :deep(.el-textarea__inner) {
  border-radius: 12px;
  padding: 12px 16px;
  font-size: 16px;
  resize: none;
}

.mobile-form :deep(.el-select .el-input__wrapper) {
  border-radius: 12px;
  padding: 12px 16px;
}

.mobile-form :deep(.el-date-editor) {
  border-radius: 12px;
}

.mobile-form :deep(.el-time-picker) {
  border-radius: 12px;
}

.reminder-setting {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 10px;
}

.reminder-text {
  font-size: 16px;
  color: #2c3e50;
  font-weight: 500;
}

.reminder-time {
  margin-top: 10px;
}

.dialog-footer {
  display: flex;
  gap: 15px;
  width: 100%;
}

.cancel-btn {
  flex: 1;
  height: 50px;
  border-radius: 25px;
  font-size: 16px;
  font-weight: 600;
  border: 2px solid #e0e0e0;
  color: #666;
}

.cancel-btn:hover {
  border-color: #409eff;
  color: #409eff;
}

.save-btn {
  flex: 1;
  height: 50px;
  border-radius: 25px;
  font-size: 16px;
  font-weight: 600;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
}

.save-btn:hover {
  background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .mobile-dialog :deep(.el-dialog) {
    width: 100% !important;
    height: 90vh !important;
    margin: 5vh 0 0 0 !important;
    border-radius: 20px 20px 0 0;
  }
  
  .mobile-dialog :deep(.el-dialog__header) {
    padding: 20px 20px 15px;
  }
  
  .mobile-dialog :deep(.el-dialog__body) {
    padding: 15px 20px;
  }
  
  .mobile-dialog :deep(.el-dialog__footer) {
    padding: 15px 20px 20px;
  }
  
  .mobile-form :deep(.el-form-item) {
    margin-bottom: 18px;
  }
  
  .mobile-form :deep(.el-form-item__label) {
    font-size: 14px;
    margin-bottom: 6px;
  }
  
  .mobile-form :deep(.el-input__wrapper),
  .mobile-form :deep(.el-textarea__inner),
  .mobile-form :deep(.el-select .el-input__wrapper) {
    padding: 14px 16px;
    font-size: 16px;
  }
  
  .dialog-footer {
    gap: 12px;
  }
  
  .cancel-btn,
  .save-btn {
    height: 48px;
    font-size: 15px;
  }
}
</style>
