<template>
  <div class="test-page">
    <h1>测试页面</h1>
    <p>如果您能看到这个页面，说明Vue应用正常运行！</p>
    <el-button type="primary" @click="goHome">返回首页</el-button>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

const goHome = () => {
  router.push('/')
}
</script>

<style scoped>
.test-page {
  padding: 50px;
  text-align: center;
  background: white;
  min-height: 100vh;
}

h1 {
  color: #409eff;
  margin-bottom: 20px;
}

p {
  color: #666;
  margin-bottom: 30px;
}
</style>


