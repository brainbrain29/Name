import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue'
import Schedule from '@/views/Schedule.vue'
import UserCenter from '@/views/UserCenter.vue'
import DataView from '@/views/DataView.vue'
import Test from '@/views/Test.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/schedule',
    name: 'Schedule',
    component: Schedule
  },
  {
    path: '/user',
    name: 'UserCenter',
    component: UserCenter
  },
  {
    path: '/data-view',
    name: 'DataView',
    component: DataView
  },
  {
    path: '/test',
    name: 'Test',
    component: Test
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router

