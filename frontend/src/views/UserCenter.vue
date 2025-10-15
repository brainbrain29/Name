<template>
  <div class="user-center">
    <!-- 移动端头部 -->
    <div class="mobile-header">
      <div class="header-content">
        <div class="user-info">
          <el-avatar :size="60" :src="userInfo.avatar" class="user-avatar">
            <el-icon><User /></el-icon>
          </el-avatar>
          <div class="user-details">
            <h1 class="username">{{ userInfo.name }}</h1>
            <p class="user-role">{{ userInfo.role }}</p>
          </div>
        </div>
        <el-button class="logout-btn" @click="handleLogout">
          退出登录
        </el-button>
      </div>
    </div>

    <!-- 统计卡片 -->
    <div class="stats-section">
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-number">{{ totalSchedules }}</div>
          <div class="stat-label">本周日志</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">{{ completedSchedules }}</div>
          <div class="stat-label">完成任务数</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">{{ completionRate }}%</div>
          <div class="stat-label">完成率</div>
        </div>
      </div>
    </div>

    <!-- 功能菜单 -->
    <div class="menu-section">
      <div class="menu-item" @click="goToDataView">
        <div class="menu-icon">
          <el-icon><TrendCharts /></el-icon>
        </div>
        <span class="menu-text">数据视图</span>
        <el-icon class="menu-arrow"><ArrowRight /></el-icon>
      </div>
      <div class="menu-item" @click="goToTeam">
        <div class="menu-icon">
          <el-icon><UserFilled /></el-icon>
        </div>
        <span class="menu-text">我的团队</span>
        <el-icon class="menu-arrow"><ArrowRight /></el-icon>
      </div>
    </div>

    <!-- 更换头像对话框 -->
    <el-dialog v-model="showAvatarDialog" title="更换头像" width="400px">
      <div class="avatar-upload">
        <el-upload
          class="avatar-uploader"
          action="#"
          :show-file-list="false"
          :before-upload="handleAvatarUpload"
        >
          <img v-if="newAvatar" :src="newAvatar" class="avatar" />
          <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
        </el-upload>
        <p class="upload-tip">点击上传头像，支持 JPG、PNG 格式</p>
      </div>
      <template #footer>
        <el-button @click="showAvatarDialog = false">取消</el-button>
        <el-button type="primary" @click="saveAvatar">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useScheduleStore } from '@/stores/schedule'
import { ElMessage, ElMessageBox } from 'element-plus'
import { 
  User, 
  Edit, 
  Setting, 
  Star, 
  TrendCharts, 
  Operation, 
  Download, 
  Upload, 
  Delete, 
  Warning, 
  Plus,
  ArrowRight,
  UserFilled
} from '@element-plus/icons-vue'

const router = useRouter()
const scheduleStore = useScheduleStore()

// 响应式数据
const showAvatarDialog = ref(false)
const newAvatar = ref('')

// 用户信息
const userInfo = ref({
  name: '管理员',
  email: 'admin@example.com',
  phone: '138****8888',
  role: '系统管理员',
  avatar: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
  timezone: 'Asia/Shanghai',
  theme: 'light',
  notifications: true,
  defaultPriority: 'medium',
  language: 'zh-CN'
})

// 计算属性
const totalSchedules = computed(() => scheduleStore.schedules.length)
const completedSchedules = computed(() => scheduleStore.completedSchedules.length)
const completionRate = computed(() => {
  if (totalSchedules.value === 0) return 0
  return Math.round((completedSchedules.value / totalSchedules.value) * 100)
})

const highPriorityRate = computed(() => {
  const highPriority = scheduleStore.schedules.filter(s => s.priority === 'high').length
  if (totalSchedules.value === 0) return 0
  return Math.round((highPriority / totalSchedules.value) * 100)
})

const weeklyAdded = computed(() => {
  const oneWeekAgo = new Date()
  oneWeekAgo.setDate(oneWeekAgo.getDate() - 7)
  return scheduleStore.schedules.filter(s => 
    new Date(s.createdAt) > oneWeekAgo
  ).length
})

const weeklyCompleted = computed(() => {
  const oneWeekAgo = new Date()
  oneWeekAgo.setDate(oneWeekAgo.getDate() - 7)
  return scheduleStore.schedules.filter(s => 
    s.completed && new Date(s.createdAt) > oneWeekAgo
  ).length
})

const dailyAverage = computed(() => {
  if (totalSchedules.value === 0) return 0
  return Math.round(totalSchedules.value / 30) // 假设30天
})

// 方法
const updateUserInfo = () => {
  ElMessage.success('设置已保存')
}

const handleAvatarUpload = (file) => {
  const reader = new FileReader()
  reader.onload = (e) => {
    newAvatar.value = e.target.result
  }
  reader.readAsDataURL(file)
  return false
}

const saveAvatar = () => {
  if (newAvatar.value) {
    userInfo.value.avatar = newAvatar.value
    ElMessage.success('头像更新成功')
  }
  showAvatarDialog.value = false
  newAvatar.value = ''
}

const exportData = () => {
  ElMessage.info('数据导出功能开发中...')
}

const importData = () => {
  ElMessage.info('数据导入功能开发中...')
}

const clearData = async () => {
  try {
    await ElMessageBox.confirm(
      '确定要清空所有日程数据吗？此操作不可恢复！',
      '确认清空',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }
    )
    ElMessage.success('数据已清空')
  } catch (error) {
    // 用户取消
  }
}

const deleteAccount = async () => {
  try {
    await ElMessageBox.confirm(
      '确定要删除账户吗？此操作不可恢复！',
      '确认删除账户',
      {
        confirmButtonText: '确定删除',
        cancelButtonText: '取消',
        type: 'error',
      }
    )
    ElMessage.success('账户已删除')
  } catch (error) {
    // 用户取消
  }
}

const handleLogout = () => {
  ElMessage.success('已退出登录')
  // 这里可以添加路由跳转到登录页
}

const goToDataView = () => {
  router.push('/data-view')
}

const goToTeam = () => {
  ElMessage.info('团队管理功能开发中...')
  // 这里可以添加路由跳转到团队页面
}
</script>

<style scoped>
.user-center {
  min-height: 100vh;
  background: #f5f5f5;
}

/* 移动端头部 */
.mobile-header {
  background: white;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 15px;
}

.user-avatar {
  border: 2px solid #f0f0f0;
}

.user-details {
  flex: 1;
}

.username {
  font-size: 1.5rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0 0 5px 0;
}

.user-role {
  color: #666;
  font-size: 0.9rem;
  margin: 0;
}

.logout-btn {
  background: #f5f5f5;
  border: 1px solid #e0e0e0;
  color: #666;
  border-radius: 8px;
  padding: 8px 16px;
  font-size: 0.9rem;
}

.logout-btn:hover {
  background: #e0e0e0;
  color: #333;
}

/* 统计卡片 */
.stats-section {
  padding: 20px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 15px;
}

.stat-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  text-align: center;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.stat-number {
  font-size: 2rem;
  font-weight: 700;
  color: #2c3e50;
  margin-bottom: 5px;
}

.stat-label {
  font-size: 0.8rem;
  color: #666;
}

/* 功能菜单 */
.menu-section {
  padding: 0 20px 20px;
}

.menu-item {
  background: white;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  gap: 15px;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.menu-item:hover {
  background: #f8f9fa;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.menu-icon {
  width: 40px;
  height: 40px;
  background: #f0f0f0;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2rem;
  color: #666;
}

.menu-text {
  flex: 1;
  font-size: 1rem;
  font-weight: 500;
  color: #2c3e50;
}

.menu-arrow {
  color: #ccc;
  font-size: 1rem;
}

.user-content {
  margin-bottom: 40px;
}

.content-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 30px;
  margin-bottom: 30px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  height: 100%;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 2px solid #f0f0f0;
}

.card-icon {
  font-size: 1.5rem;
  color: #409eff;
}

.card-header h3 {
  font-size: 1.3rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0;
}

.setting-item {
  margin-bottom: 20px;
}

.setting-item label {
  display: block;
  font-weight: 500;
  color: #2c3e50;
  margin-bottom: 8px;
}

.setting-desc {
  margin-left: 10px;
  color: #666;
  font-size: 0.9rem;
}

.chart-container {
  display: flex;
  justify-content: space-around;
  margin-bottom: 30px;
}

.chart-item {
  text-align: center;
}

.chart-circle {
  width: 80px;
  height: 80px;
  margin: 0 auto 10px;
  position: relative;
}

.circle-progress {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: conic-gradient(#409eff var(--progress, 0%), #f0f0f0 0);
  display: flex;
  align-items: center;
  justify-content: center;
}

.progress-text {
  font-size: 1.2rem;
  font-weight: 700;
  color: #2c3e50;
}

.chart-label {
  font-size: 0.9rem;
  color: #666;
  margin: 0;
}

.stats-list {
  border-top: 1px solid #f0f0f0;
  padding-top: 20px;
}

.stat-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px solid #f8f8f8;
}

.stat-row:last-child {
  border-bottom: none;
}

.stat-value {
  font-weight: 600;
  color: #409eff;
}

.action-section {
  margin-top: 40px;
}

.action-buttons {
  display: flex;
  gap: 15px;
  flex-wrap: wrap;
}

.avatar-upload {
  text-align: center;
}

.avatar-uploader {
  border: 2px dashed #d9d9d9;
  border-radius: 10px;
  width: 200px;
  height: 200px;
  margin: 0 auto 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: border-color 0.3s;
}

.avatar-uploader:hover {
  border-color: #409eff;
}

.avatar {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 8px;
}

.avatar-uploader-icon {
  font-size: 3rem;
  color: #c0c4cc;
}

.upload-tip {
  color: #666;
  font-size: 0.9rem;
  margin: 0;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .profile-header {
    flex-direction: column;
    text-align: center;
    gap: 30px;
  }
  
  .profile-stats {
    justify-content: center;
    gap: 30px;
  }
  
  .chart-container {
    flex-direction: column;
    gap: 20px;
  }
  
  .action-buttons {
    flex-direction: column;
  }
  
  .action-buttons .el-button {
    width: 100%;
  }
}
</style>
