<template>
  <div class="schedule">
    <div class="container">
      <!-- 页面头部 -->
      <div class="page-header">
        <h1 class="page-title">日程管理</h1>
        <div class="header-actions">
          <el-button type="primary" @click="showAddDialog = true">
            <el-icon><Plus /></el-icon>
            添加日程
          </el-button>
          <el-button @click="refreshData">
            <el-icon><Refresh /></el-icon>
            刷新
          </el-button>
        </div>
      </div>

      <!-- 筛选和搜索 -->
      <div class="filter-section">
        <div class="filter-controls">
          <el-input
            v-model="searchKeyword"
            placeholder="搜索日程..."
            class="search-input"
            @input="handleSearch"
          >
            <template #prefix>
              <el-icon><Search /></el-icon>
            </template>
          </el-input>
          
          <el-select v-model="filterCategory" placeholder="分类筛选" @change="handleFilter">
            <el-option label="全部分类" value="" />
            <el-option label="工作" value="工作" />
            <el-option label="学习" value="学习" />
            <el-option label="生活" value="生活" />
            <el-option label="健康" value="健康" />
          </el-select>
          
          <el-select v-model="filterPriority" placeholder="优先级筛选" @change="handleFilter">
            <el-option label="全部优先级" value="" />
            <el-option label="高" value="high" />
            <el-option label="中" value="medium" />
            <el-option label="低" value="low" />
          </el-select>
        </div>
      </div>

      <!-- 日程列表 -->
      <div class="schedule-content">
        <el-tabs v-model="activeTab" @tab-change="handleTabChange">
          <el-tab-pane label="今日日程" name="today">
            <div class="schedule-list">
              <div v-if="filteredTodaySchedules.length === 0" class="empty-state">
                <el-icon class="empty-icon"><Calendar /></el-icon>
                <p>今日暂无日程安排</p>
              </div>
              <div v-else>
                <ScheduleCard
                  v-for="schedule in filteredTodaySchedules"
                  :key="schedule.id"
                  :schedule="schedule"
                  @edit="handleEdit"
                  @delete="handleDelete"
                  @toggle-complete="handleToggleComplete"
                />
              </div>
            </div>
          </el-tab-pane>
          
          <el-tab-pane label="待办事项" name="upcoming">
            <div class="schedule-list">
              <div v-if="filteredUpcomingSchedules.length === 0" class="empty-state">
                <el-icon class="empty-icon"><Clock /></el-icon>
                <p>暂无待办事项</p>
              </div>
              <div v-else>
                <ScheduleCard
                  v-for="schedule in filteredUpcomingSchedules"
                  :key="schedule.id"
                  :schedule="schedule"
                  @edit="handleEdit"
                  @delete="handleDelete"
                  @toggle-complete="handleToggleComplete"
                />
              </div>
            </div>
          </el-tab-pane>
          
          <el-tab-pane label="已完成" name="completed">
            <div class="schedule-list">
              <div v-if="filteredCompletedSchedules.length === 0" class="empty-state">
                <el-icon class="empty-icon"><Check /></el-icon>
                <p>暂无已完成事项</p>
              </div>
              <div v-else>
                <ScheduleCard
                  v-for="schedule in filteredCompletedSchedules"
                  :key="schedule.id"
                  :schedule="schedule"
                  @edit="handleEdit"
                  @delete="handleDelete"
                  @toggle-complete="handleToggleComplete"
                />
              </div>
            </div>
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>

    <!-- 添加/编辑日程对话框 -->
    <ScheduleDialog
      v-model="showAddDialog"
      :schedule="editingSchedule"
      @save="handleSave"
      @close="handleCloseDialog"
    />
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { useScheduleStore } from '@/stores/schedule'
import { ElMessage, ElMessageBox } from 'element-plus'
import { 
  Plus, 
  Refresh, 
  Search, 
  Calendar, 
  Clock, 
  Check 
} from '@element-plus/icons-vue'
import ScheduleCard from '@/components/ScheduleCard.vue'
import ScheduleDialog from '@/components/ScheduleDialog.vue'

const scheduleStore = useScheduleStore()

// 响应式数据
const activeTab = ref('today')
const searchKeyword = ref('')
const filterCategory = ref('')
const filterPriority = ref('')
const showAddDialog = ref(false)
const editingSchedule = ref(null)

// 计算属性
const todaySchedules = computed(() => scheduleStore.todaySchedules)
const upcomingSchedules = computed(() => scheduleStore.upcomingSchedules)
const completedSchedules = computed(() => scheduleStore.completedSchedules)

// 筛选后的数据
const filteredTodaySchedules = computed(() => filterSchedules(todaySchedules.value))
const filteredUpcomingSchedules = computed(() => filterSchedules(upcomingSchedules.value))
const filteredCompletedSchedules = computed(() => filterSchedules(completedSchedules.value))

// 筛选方法
const filterSchedules = (schedules) => {
  return schedules.filter(schedule => {
    const matchesKeyword = !searchKeyword.value || 
      schedule.title.toLowerCase().includes(searchKeyword.value.toLowerCase()) ||
      schedule.description.toLowerCase().includes(searchKeyword.value.toLowerCase())
    
    const matchesCategory = !filterCategory.value || schedule.category === filterCategory.value
    const matchesPriority = !filterPriority.value || schedule.priority === filterPriority.value
    
    return matchesKeyword && matchesCategory && matchesPriority
  })
}

// 方法
const handleSearch = () => {
  // 搜索逻辑已在计算属性中处理
}

const handleFilter = () => {
  // 筛选逻辑已在计算属性中处理
}

const handleTabChange = (tabName) => {
  activeTab.value = tabName
}

const refreshData = async () => {
  try {
    await scheduleStore.loadSchedules()
    ElMessage.success('数据已刷新')
  } catch (error) {
    ElMessage.error('刷新失败')
  }
}

const handleEdit = (schedule) => {
  editingSchedule.value = { ...schedule }
  showAddDialog.value = true
}

const handleDelete = async (schedule) => {
  try {
    await ElMessageBox.confirm(
      `确定要删除日程"${schedule.title}"吗？`,
      '确认删除',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }
    )
    
    await scheduleStore.deleteSchedule(schedule.id)
    ElMessage.success('删除成功')
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

const handleToggleComplete = async (schedule) => {
  try {
    await scheduleStore.toggleComplete(schedule.id)
    ElMessage.success(schedule.completed ? '已标记为未完成' : '已标记为完成')
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const handleSave = async (scheduleData) => {
  try {
    if (editingSchedule.value) {
      await scheduleStore.updateSchedule(editingSchedule.value.id, scheduleData)
      ElMessage.success('日程更新成功')
    } else {
      await scheduleStore.addSchedule(scheduleData)
      ElMessage.success('日程添加成功')
    }
    showAddDialog.value = false
    editingSchedule.value = null
  } catch (error) {
    ElMessage.error('保存失败')
  }
}

const handleCloseDialog = () => {
  showAddDialog.value = false
  editingSchedule.value = null
}
</script>

<style scoped>
.schedule {
  min-height: 100vh;
  padding: 40px 0;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 40px;
  background: rgba(255, 255, 255, 0.95);
  padding: 30px;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
}

.page-title {
  font-size: 2.5rem;
  font-weight: 700;
  color: #2c3e50;
  margin: 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.header-actions {
  display: flex;
  gap: 15px;
}

.filter-section {
  margin-bottom: 30px;
  background: rgba(255, 255, 255, 0.95);
  padding: 30px;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
}

.filter-controls {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  align-items: center;
}

.search-input {
  flex: 1;
  min-width: 300px;
}

.schedule-content {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  overflow: hidden;
}

.schedule-list {
  padding: 30px;
}

.empty-state {
  text-align: center;
  padding: 80px 20px;
  color: #909399;
}

.empty-icon {
  font-size: 4rem;
  margin-bottom: 20px;
  opacity: 0.5;
}

.empty-state p {
  font-size: 1.2rem;
  margin: 0;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .page-header {
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }
  
  .page-title {
    font-size: 2rem;
  }
  
  .filter-controls {
    flex-direction: column;
    align-items: stretch;
  }
  
  .search-input {
    min-width: auto;
  }
  
  .header-actions {
    width: 100%;
    justify-content: center;
  }
}
</style>
