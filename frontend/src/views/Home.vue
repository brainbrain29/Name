<template>
  <div class="home">
    <!-- 欢迎区域 -->
    <div class="hero-section">
      <div class="hero-content">
        <h1 class="hero-title">欢迎使用日程规划助手</h1>
        <p class="hero-subtitle">让生活更有序，让时间更有价值</p>
        <div class="hero-actions">
          <el-button type="primary" size="large" @click="goToSchedule">
            <el-icon><Calendar /></el-icon>
            开始规划日程
          </el-button>
          <el-button size="large" @click="goToUserCenter">
            <el-icon><User /></el-icon>
            用户中心
          </el-button>
        </div>
      </div>
      <div class="hero-image">
        <el-icon class="hero-icon"><Calendar /></el-icon>
      </div>
    </div>

    <!-- 功能特色 -->
    <div class="features-section">
      <div class="container">
        <h2 class="section-title">功能特色</h2>
        <div class="features-grid">
          <div class="feature-card">
            <div class="feature-icon">
              <el-icon><Calendar /></el-icon>
            </div>
            <h3>智能日程管理</h3>
            <p>轻松添加、编辑和删除日程事项，支持优先级分类和完成状态跟踪</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">
              <el-icon><Clock /></el-icon>
            </div>
            <h3>时间提醒</h3>
            <p>智能提醒系统，确保您不会错过任何重要事项</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">
              <el-icon><TrendCharts /></el-icon>
            </div>
            <h3>进度统计</h3>
            <p>可视化统计您的日程完成情况，帮助您更好地管理时间</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">
              <el-icon><User /></el-icon>
            </div>
            <h3>个人中心</h3>
            <p>个性化设置，管理您的账户信息和偏好设置</p>
          </div>
        </div>
      </div>
    </div>

    <!-- 今日概览 -->
    <div class="overview-section">
      <div class="container">
        <h2 class="section-title">今日概览</h2>
        <div class="overview-cards">
          <div class="overview-card">
            <div class="overview-icon today">
              <el-icon><Calendar /></el-icon>
            </div>
            <div class="overview-content">
              <h3>{{ todaySchedules.length }}</h3>
              <p>今日事项</p>
            </div>
          </div>
          <div class="overview-card">
            <div class="overview-icon completed">
              <el-icon><Check /></el-icon>
            </div>
            <div class="overview-content">
              <h3>{{ completedCount }}</h3>
              <p>已完成</p>
            </div>
          </div>
          <div class="overview-card">
            <div class="overview-icon upcoming">
              <el-icon><Clock /></el-icon>
            </div>
            <div class="overview-content">
              <h3>{{ upcomingSchedules.length }}</h3>
              <p>待办事项</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 快速操作 -->
    <div class="quick-actions-section">
      <div class="container">
        <h2 class="section-title">快速操作</h2>
        <div class="quick-actions">
          <el-button type="primary" size="large" @click="goToSchedule">
            <el-icon><Plus /></el-icon>
            添加新日程
          </el-button>
          <el-button size="large" @click="goToSchedule">
            <el-icon><View /></el-icon>
            查看所有日程
          </el-button>
          <el-button size="large" @click="goToUserCenter">
            <el-icon><Setting /></el-icon>
            个人设置
          </el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useScheduleStore } from '@/stores/schedule'
import { 
  Calendar, 
  User, 
  Clock, 
  TrendCharts, 
  Check, 
  Plus, 
  View, 
  Setting 
} from '@element-plus/icons-vue'

const router = useRouter()
const scheduleStore = useScheduleStore()

// 计算属性
const todaySchedules = computed(() => scheduleStore.todaySchedules)
const upcomingSchedules = computed(() => scheduleStore.upcomingSchedules)
const completedCount = computed(() => 
  todaySchedules.value.filter(schedule => schedule.completed).length
)

// 方法
const goToSchedule = () => {
  router.push('/schedule')
}

const goToUserCenter = () => {
  router.push('/user')
}
</script>

<style scoped>
.home {
  min-height: 100vh;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

/* 欢迎区域 */
.hero-section {
  display: flex;
  align-items: center;
  justify-content: space-between;
  min-height: 60vh;
  padding: 80px 20px;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
  backdrop-filter: blur(10px);
  border-radius: 0 0 50px 50px;
  margin-bottom: 80px;
}

.hero-content {
  flex: 1;
  max-width: 600px;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 700;
  color: white;
  margin-bottom: 20px;
  line-height: 1.2;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.hero-subtitle {
  font-size: 1.25rem;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 40px;
  line-height: 1.6;
}

.hero-actions {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

.hero-actions .el-button {
  padding: 15px 30px;
  font-size: 16px;
  border-radius: 50px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease;
}

.hero-actions .el-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
}

.hero-image {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
}

.hero-icon {
  font-size: 15rem;
  color: rgba(255, 255, 255, 0.3);
  animation: float 3s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
}

/* 功能特色 */
.features-section {
  padding: 80px 0;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  margin-bottom: 80px;
}

.section-title {
  text-align: center;
  font-size: 2.5rem;
  font-weight: 700;
  color: white;
  margin-bottom: 60px;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 40px;
  margin-top: 60px;
}

.feature-card {
  background: rgba(255, 255, 255, 0.95);
  padding: 40px 30px;
  border-radius: 20px;
  text-align: center;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.feature-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
}

.feature-icon {
  width: 80px;
  height: 80px;
  margin: 0 auto 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2rem;
  color: white;
}

.feature-card h3 {
  font-size: 1.5rem;
  font-weight: 600;
  color: #2c3e50;
  margin-bottom: 15px;
}

.feature-card p {
  color: #666;
  line-height: 1.6;
  font-size: 1rem;
}

/* 今日概览 */
.overview-section {
  padding: 80px 0;
  margin-bottom: 80px;
}

.overview-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-top: 60px;
}

.overview-card {
  background: rgba(255, 255, 255, 0.95);
  padding: 40px 30px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  gap: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.overview-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

.overview-icon {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
  color: white;
}

.overview-icon.today {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.overview-icon.completed {
  background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
}

.overview-icon.upcoming {
  background: linear-gradient(135deg, #FF9800 0%, #F57C00 100%);
}

.overview-content h3 {
  font-size: 2.5rem;
  font-weight: 700;
  color: #2c3e50;
  margin: 0;
}

.overview-content p {
  color: #666;
  font-size: 1rem;
  margin: 5px 0 0 0;
}

/* 快速操作 */
.quick-actions-section {
  padding: 80px 0;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
}

.quick-actions {
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-wrap: wrap;
  margin-top: 60px;
}

.quick-actions .el-button {
  padding: 20px 40px;
  font-size: 16px;
  border-radius: 50px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease;
}

.quick-actions .el-button:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .hero-section {
    flex-direction: column;
    text-align: center;
    padding: 60px 20px;
  }
  
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-icon {
    font-size: 8rem;
    margin-top: 40px;
  }
  
  .features-grid {
    grid-template-columns: 1fr;
    gap: 30px;
  }
  
  .overview-cards {
    grid-template-columns: 1fr;
  }
  
  .quick-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .quick-actions .el-button {
    width: 100%;
    max-width: 300px;
  }
}
</style>
