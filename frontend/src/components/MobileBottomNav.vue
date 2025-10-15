<template>
  <div class="mobile-bottom-nav">
    <div class="nav-item" :class="{ active: $route.path === '/' }" @click="navigateTo('/')">
      <el-icon class="nav-icon"><House /></el-icon>
      <span class="nav-label">首页</span>
    </div>
    <div class="nav-item" :class="{ active: $route.path === '/schedule' }" @click="navigateTo('/schedule')">
      <el-icon class="nav-icon"><Document /></el-icon>
      <span class="nav-label">日志</span>
    </div>
    <div class="nav-item" :class="{ active: $route.path === '/tasks' }" @click="navigateTo('/schedule')">
      <el-icon class="nav-icon"><List /></el-icon>
      <span class="nav-label">任务</span>
    </div>
    <div class="nav-item" :class="{ active: $route.path === '/notifications' }" @click="navigateTo('/notifications')">
      <el-icon class="nav-icon"><Bell /></el-icon>
      <span class="nav-label">通知</span>
    </div>
    <div class="nav-item" :class="{ active: $route.path === '/user' }" @click="navigateTo('/user')">
      <el-icon class="nav-icon"><User /></el-icon>
      <span class="nav-label">个人中心</span>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { House, Document, List, Bell, User } from '@element-plus/icons-vue'

const router = useRouter()

const navigateTo = (path) => {
  router.push(path)
}
</script>

<style scoped>
.mobile-bottom-nav {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: white;
  border-top: 1px solid #e0e0e0;
  display: flex;
  justify-content: space-around;
  align-items: center;
  padding: 8px 0;
  z-index: 1000;
  box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.1);
}

.nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  padding: 8px 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  border-radius: 8px;
  min-width: 60px;
}

.nav-item:hover {
  background: #f5f5f5;
}

.nav-item.active {
  color: #409eff;
}

.nav-item.active .nav-icon {
  color: #409eff;
}

.nav-icon {
  font-size: 1.2rem;
  color: #999;
  transition: color 0.3s ease;
}

.nav-label {
  font-size: 0.7rem;
  color: #999;
  transition: color 0.3s ease;
}

.nav-item.active .nav-label {
  color: #409eff;
  font-weight: 500;
}

/* 为移动端底部导航留出空间 */
@media (max-width: 768px) {
  .main-content {
    padding-bottom: 80px;
  }
}
</style>
