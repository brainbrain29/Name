<template>
  <div class="layout">
    <!-- 顶部导航栏 -->
    <el-header class="header">
      <div class="header-content">
        <div class="logo">
          <el-icon class="logo-icon"><Calendar /></el-icon>
          <span class="logo-text">日程规划助手</span>
        </div>
        
        <el-menu
          :default-active="activeIndex"
          class="nav-menu"
          mode="horizontal"
          @select="handleSelect"
        >
          <el-menu-item index="/">
            <el-icon><House /></el-icon>
            <span>首页</span>
          </el-menu-item>
          <el-menu-item index="/schedule">
            <el-icon><Calendar /></el-icon>
            <span>日程管理</span>
          </el-menu-item>
          <el-menu-item index="/user">
            <el-icon><User /></el-icon>
            <span>用户中心</span>
          </el-menu-item>
        </el-menu>

        <div class="user-info">
          <el-dropdown @command="handleCommand">
            <span class="user-dropdown">
              <el-avatar :size="32" :src="userInfo.avatar">
                <el-icon><User /></el-icon>
              </el-avatar>
              <span class="username">{{ userInfo.name }}</span>
              <el-icon class="el-icon--right"><ArrowDown /></el-icon>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="profile">
                  <el-icon><User /></el-icon>
                  个人资料
                </el-dropdown-item>
                <el-dropdown-item command="settings">
                  <el-icon><Setting /></el-icon>
                  设置
                </el-dropdown-item>
                <el-dropdown-item divided command="logout">
                  <el-icon><SwitchButton /></el-icon>
                  退出登录
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
    </el-header>

    <!-- 主要内容区域 -->
    <el-main class="main-content">
      <router-view />
    </el-main>

    <!-- 移动端底部导航 -->
    <MobileBottomNav />

    <!-- 桌面端底部信息 -->
    <el-footer class="footer desktop-only">
      <div class="footer-content">
        <p>&copy; 2024 日程规划助手. 让生活更有序，让时间更有价值.</p>
      </div>
    </el-footer>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { 
  Calendar, 
  House, 
  User, 
  ArrowDown, 
  Setting, 
  SwitchButton 
} from '@element-plus/icons-vue'
import MobileBottomNav from './MobileBottomNav.vue'

const router = useRouter()
const route = useRoute()

// 用户信息
const userInfo = ref({
  name: '管理员',
  avatar: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png'
})

// 当前激活的菜单项
const activeIndex = computed(() => route.path)

// 菜单选择处理
const handleSelect = (index) => {
  router.push(index)
}

// 用户下拉菜单处理
const handleCommand = (command) => {
  switch (command) {
    case 'profile':
      ElMessage.info('跳转到个人资料页面')
      break
    case 'settings':
      ElMessage.info('跳转到设置页面')
      break
    case 'logout':
      ElMessage.success('已退出登录')
      router.push('/')
      break
  }
}
</script>

<style scoped>
.layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.header {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  padding: 0;
  height: 60px !important;
  position: sticky;
  top: 0;
  z-index: 1000;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.logo {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 20px;
  font-weight: bold;
  color: #409eff;
}

.logo-icon {
  font-size: 24px;
}

.logo-text {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.nav-menu {
  border-bottom: none;
  background: transparent;
}

.nav-menu .el-menu-item {
  border-bottom: none;
  color: #606266;
  font-weight: 500;
}

.nav-menu .el-menu-item:hover,
.nav-menu .el-menu-item.is-active {
  color: #409eff;
  background-color: rgba(64, 158, 255, 0.1);
}

.user-info {
  display: flex;
  align-items: center;
}

.user-dropdown {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 8px 12px;
  border-radius: 6px;
  transition: background-color 0.3s;
}

.user-dropdown:hover {
  background-color: rgba(0, 0, 0, 0.05);
}

.username {
  font-weight: 500;
  color: #303133;
}

.main-content {
  flex: 1;
  padding: 0;
  background: transparent;
}

.footer {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  border-top: 1px solid rgba(0, 0, 0, 0.1);
  height: 60px !important;
  padding: 0;
}

.footer-content {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.footer-content p {
  margin: 0;
  color: #909399;
  font-size: 14px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .header-content {
    padding: 0 15px;
  }
  
  .logo-text {
    display: none;
  }
  
  .nav-menu .el-menu-item span {
    display: none;
  }
  
  .username {
    display: none;
  }
  
  .desktop-only {
    display: none;
  }
  
  .main-content {
    padding-bottom: 80px;
  }
}

@media (min-width: 769px) {
  .mobile-bottom-nav {
    display: none;
  }
}
</style>

