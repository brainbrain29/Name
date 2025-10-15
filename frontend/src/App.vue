<template>
  <div id="app">
    <Layout />
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useScheduleStore } from '@/stores/schedule'
import Layout from '@/components/Layout.vue'

const scheduleStore = useScheduleStore()

onMounted(() => {
  // 初始化数据
  scheduleStore.loadSchedules()
})
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

#app {
  font-family: 'Helvetica Neue', Helvetica, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', '微软雅黑', Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

body {
  margin: 0;
  padding: 0;
}
</style>
