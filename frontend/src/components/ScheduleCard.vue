<template>
  <div class="schedule-card" :class="{ completed: schedule.completed }">
    <div class="card-header">
      <div class="priority-indicator" :class="schedule.priority"></div>
      <div class="schedule-title">
        <h3>{{ schedule.title }}</h3>
        <span class="category-tag">{{ schedule.category }}</span>
      </div>
      <div class="card-actions">
        <el-button 
          type="primary" 
          size="small" 
          :icon="schedule.completed ? 'Refresh' : 'Check'"
          @click="$emit('toggle-complete', schedule)"
        >
          {{ schedule.completed ? '未完成' : '完成' }}
        </el-button>
        <el-button size="small" @click="$emit('edit', schedule)">
          <el-icon><Edit /></el-icon>
        </el-button>
        <el-button size="small" type="danger" @click="$emit('delete', schedule)">
          <el-icon><Delete /></el-icon>
        </el-button>
      </div>
    </div>
    
    <div class="card-content">
      <p class="description">{{ schedule.description }}</p>
      
      <div class="schedule-meta">
        <div class="meta-item">
          <el-icon><Calendar /></el-icon>
          <span>{{ formatDate(schedule.date) }}</span>
        </div>
        <div class="meta-item">
          <el-icon><Clock /></el-icon>
          <span>{{ schedule.time }}</span>
        </div>
        <div class="meta-item">
          <el-icon><Flag /></el-icon>
          <span>{{ getPriorityText(schedule.priority) }}</span>
        </div>
      </div>
    </div>
    
    <div class="card-footer">
      <div class="created-time">
        创建于 {{ formatDateTime(schedule.createdAt) }}
      </div>
      <div class="status-indicator" :class="{ completed: schedule.completed }">
        <el-icon v-if="schedule.completed"><Check /></el-icon>
        <el-icon v-else><Clock /></el-icon>
        <span>{{ schedule.completed ? '已完成' : '进行中' }}</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Calendar, Clock, Flag, Check, Edit, Delete } from '@element-plus/icons-vue'
import dayjs from 'dayjs'

const props = defineProps({
  schedule: {
    type: Object,
    required: true
  }
})

defineEmits(['edit', 'delete', 'toggle-complete'])

const formatDate = (date) => {
  return dayjs(date).format('YYYY年MM月DD日')
}

const formatDateTime = (dateTime) => {
  return dayjs(dateTime).format('MM-DD HH:mm')
}

const getPriorityText = (priority) => {
  const priorityMap = {
    high: '高优先级',
    medium: '中优先级',
    low: '低优先级'
  }
  return priorityMap[priority] || priority
}
</script>

<style scoped>
.schedule-card {
  background: white;
  border-radius: 15px;
  padding: 25px;
  margin-bottom: 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  border-left: 4px solid #e0e0e0;
  position: relative;
  overflow: hidden;
}

.schedule-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.schedule-card.completed {
  opacity: 0.7;
  background: #f8f9fa;
}

.schedule-card.completed .schedule-title h3 {
  text-decoration: line-through;
  color: #999;
}

.card-header {
  display: flex;
  align-items: flex-start;
  gap: 15px;
  margin-bottom: 15px;
}

.priority-indicator {
  width: 4px;
  height: 100%;
  border-radius: 2px;
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
}

.priority-indicator.high {
  background: linear-gradient(135deg, #ff6b6b, #ee5a24);
}

.priority-indicator.medium {
  background: linear-gradient(135deg, #feca57, #ff9ff3);
}

.priority-indicator.low {
  background: linear-gradient(135deg, #48dbfb, #0abde3);
}

.schedule-title {
  flex: 1;
  margin-left: 10px;
}

.schedule-title h3 {
  font-size: 1.3rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0 0 8px 0;
  line-height: 1.4;
}

.category-tag {
  display: inline-block;
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 500;
}

.card-actions {
  display: flex;
  gap: 8px;
  flex-shrink: 0;
}

.card-content {
  margin-bottom: 20px;
}

.description {
  color: #666;
  line-height: 1.6;
  margin: 0 0 15px 0;
  font-size: 0.95rem;
}

.schedule-meta {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 6px;
  color: #666;
  font-size: 0.9rem;
}

.meta-item .el-icon {
  color: #409eff;
  font-size: 1rem;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 15px;
  border-top: 1px solid #f0f0f0;
}

.created-time {
  color: #999;
  font-size: 0.85rem;
}

.status-indicator {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 0.9rem;
  font-weight: 500;
}

.status-indicator .el-icon {
  font-size: 1rem;
}

.status-indicator:not(.completed) {
  color: #f39c12;
}

.status-indicator.completed {
  color: #27ae60;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .schedule-card {
    padding: 20px;
  }
  
  .card-header {
    flex-direction: column;
    gap: 10px;
  }
  
  .card-actions {
    width: 100%;
    justify-content: flex-end;
  }
  
  .schedule-meta {
    flex-direction: column;
    gap: 10px;
  }
  
  .card-footer {
    flex-direction: column;
    gap: 10px;
    align-items: flex-start;
  }
}
</style>
