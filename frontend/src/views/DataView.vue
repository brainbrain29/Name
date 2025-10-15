<template>
  <div class="data-view">
    <!-- 移动端头部 -->
    <div class="mobile-header">
      <div class="header-content">
        <el-button class="back-btn" @click="goBack">
          <el-icon><ArrowLeft /></el-icon>
        </el-button>
        <div class="header-title">
          <el-icon class="title-icon"><TrendCharts /></el-icon>
          <h1>数据视图</h1>
        </div>
      </div>
    </div>

    <!-- 工作量趋势图 -->
    <div class="chart-section">
      <div class="section-header">
        <el-icon class="section-icon"><TrendCharts /></el-icon>
        <h2>工作量趋势图</h2>
      </div>
      <div class="chart-container">
        <div class="chart-placeholder">
          <div class="chart-grid">
            <div class="grid-line" v-for="i in 5" :key="i" :style="{ top: (i-1) * 20 + '%' }"></div>
            <div class="grid-line-h" v-for="i in 6" :key="i" :style="{ left: (i-1) * 20 + '%' }"></div>
            
            <!-- 数据点 -->
            <div class="data-point blue" style="left: 0%; top: 75%;" data-value="5"></div>
            <div class="data-point blue" style="left: 25%; top: 70%;" data-value="6"></div>
            <div class="data-point blue" style="left: 50%; top: 80%;" data-value="4"></div>
            <div class="data-point blue" style="left: 75%; top: 80%;" data-value="4"></div>
            <div class="data-point blue" style="left: 100%; top: 65%;" data-value="7"></div>
            
            <div class="data-point orange" style="left: 0%; top: 50%;" data-value="10"></div>
            <div class="data-point orange" style="left: 25%; top: 40%;" data-value="12"></div>
            <div class="data-point orange" style="left: 50%; top: 60%;" data-value="8"></div>
            <div class="data-point orange" style="left: 75%; top: 60%;" data-value="8"></div>
            <div class="data-point orange" style="left: 100%; top: 30%;" data-value="14"></div>
            
            <!-- 连接线 -->
            <svg class="chart-lines" viewBox="0 0 100 100" preserveAspectRatio="none">
              <polyline class="line blue" points="0,75 25,70 50,80 75,80 100,65" />
              <polyline class="line orange" points="0,50 25,40 50,60 75,60 100,30" />
            </svg>
          </div>
          <div class="chart-labels">
            <div class="y-labels">
              <span>20</span>
              <span>15</span>
              <span>10</span>
              <span>5</span>
              <span>0</span>
            </div>
            <div class="x-labels">
              <span>9-15</span>
              <span>9-16</span>
              <span>9-17</span>
              <span>9-18</span>
              <span>9-19</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 心情分布 -->
    <div class="chart-section">
      <div class="section-header">
        <el-icon class="section-icon"><Star /></el-icon>
        <h2>心情分布</h2>
      </div>
      <div class="pie-chart-container">
        <div class="pie-chart">
          <div class="pie-segment blue" style="--start: 0deg; --end: 72deg;">
            <div class="segment-label">迷茫</div>
          </div>
          <div class="pie-segment teal" style="--start: 72deg; --end: 144deg;">
            <div class="segment-label">疲惫</div>
          </div>
          <div class="pie-segment yellow" style="--start: 144deg; --end: 216deg;">
            <div class="segment-label">轻松</div>
          </div>
          <div class="pie-segment orange" style="--start: 216deg; --end: 288deg;">
            <div class="segment-label">充实</div>
          </div>
          <div class="pie-segment red" style="--start: 288deg; --end: 360deg;">
            <div class="segment-label">焦虑</div>
          </div>
        </div>
      </div>
    </div>

    <!-- AI洞察 -->
    <div class="chart-section">
      <div class="section-header">
        <el-icon class="section-icon"><InfoFilled /></el-icon>
        <h2>AI洞察</h2>
      </div>
      <div class="insights-container">
        <div class="insight-card">
          <h3>工作节奏建议</h3>
          <p>您在周二和周五效率较高，建议安排比较重要的工作！</p>
        </div>
        <div class="insight-card">
          <h3>情绪健康提醒</h3>
          <p>最近一周您的工作状态良好，充实轻松的情绪占比较高...</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft, TrendCharts, Star, InfoFilled } from '@element-plus/icons-vue'

const router = useRouter()

const goBack = () => {
  router.back()
}
</script>

<style scoped>
.data-view {
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
  gap: 15px;
}

.back-btn {
  background: #f5f5f5;
  border: 1px solid #e0e0e0;
  color: #666;
  border-radius: 8px;
  padding: 8px;
}

.header-title {
  display: flex;
  align-items: center;
  gap: 10px;
}

.title-icon {
  font-size: 1.2rem;
  color: #409eff;
}

.header-title h1 {
  font-size: 1.3rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0;
}

/* 图表区域 */
.chart-section {
  margin: 20px;
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.section-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px solid #f0f0f0;
}

.section-icon {
  font-size: 1.2rem;
  color: #409eff;
}

.section-header h2 {
  font-size: 1.1rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0;
}

/* 折线图 */
.chart-container {
  position: relative;
  height: 200px;
  background: white;
  border-radius: 8px;
  overflow: hidden;
}

.chart-placeholder {
  position: relative;
  width: 100%;
  height: 100%;
}

.chart-grid {
  position: relative;
  width: 100%;
  height: 100%;
  background: #fafafa;
}

.grid-line {
  position: absolute;
  width: 100%;
  height: 1px;
  background: #e0e0e0;
  opacity: 0.5;
}

.grid-line-h {
  position: absolute;
  height: 100%;
  width: 1px;
  background: #e0e0e0;
  opacity: 0.5;
}

.data-point {
  position: absolute;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  transform: translate(-50%, -50%);
}

.data-point.blue {
  background: #409eff;
  border: 2px solid white;
  box-shadow: 0 0 0 2px #409eff;
}

.data-point.orange {
  background: #ff9800;
  border: 2px solid white;
  box-shadow: 0 0 0 2px #ff9800;
}

.chart-lines {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.line {
  fill: none;
  stroke-width: 2;
}

.line.blue {
  stroke: #409eff;
}

.line.orange {
  stroke: #ff9800;
}

.chart-labels {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.y-labels {
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 10px 5px;
  font-size: 0.8rem;
  color: #666;
}

.x-labels {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  display: flex;
  justify-content: space-between;
  padding: 5px 10px;
  font-size: 0.8rem;
  color: #666;
}

/* 饼图 */
.pie-chart-container {
  display: flex;
  justify-content: center;
  padding: 20px 0;
}

.pie-chart {
  position: relative;
  width: 200px;
  height: 200px;
  border-radius: 50%;
  background: conic-gradient(
    #409eff 0deg 72deg,
    #20c997 72deg 144deg,
    #ffc107 144deg 216deg,
    #ff9800 216deg 288deg,
    #f56565 288deg 360deg
  );
}

.pie-segment {
  position: absolute;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  clip-path: polygon(50% 50%, 50% 0%, calc(50% + 50% * cos(var(--end) * 3.14159 / 180)) calc(50% - 50% * sin(var(--end) * 3.14159 / 180)), calc(50% + 50% * cos(var(--start) * 3.14159 / 180)) calc(50% - 50% * sin(var(--start) * 3.14159 / 180)));
}

.segment-label {
  position: absolute;
  font-size: 0.8rem;
  font-weight: 500;
  color: white;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
}

/* AI洞察 */
.insights-container {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.insight-card {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 15px;
  border-left: 4px solid #409eff;
}

.insight-card h3 {
  font-size: 1rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0 0 8px 0;
}

.insight-card p {
  font-size: 0.9rem;
  color: #666;
  line-height: 1.5;
  margin: 0;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .chart-section {
    margin: 15px;
    padding: 15px;
  }
  
  .chart-container {
    height: 150px;
  }
  
  .pie-chart {
    width: 150px;
    height: 150px;
  }
}
</style>
