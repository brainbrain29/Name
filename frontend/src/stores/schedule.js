import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import dayjs from 'dayjs'

export const useScheduleStore = defineStore('schedule', () => {
  // 状态
  const schedules = ref([])
  const loading = ref(false)
  const currentDate = ref(dayjs())

  // 计算属性
  const todaySchedules = computed(() => {
    return schedules.value.filter(schedule => 
      dayjs(schedule.date).isSame(currentDate.value, 'day')
    )
  })

  const upcomingSchedules = computed(() => {
    return schedules.value.filter(schedule => 
      dayjs(schedule.date).isAfter(currentDate.value, 'day')
    ).sort((a, b) => dayjs(a.date).diff(dayjs(b.date)))
  })

  const completedSchedules = computed(() => {
    return schedules.value.filter(schedule => schedule.completed)
  })

  // 操作
  const loadSchedules = async () => {
    loading.value = true
    try {
      // 模拟API调用
      await new Promise(resolve => setTimeout(resolve, 500))
      
      // 模拟数据
      schedules.value = [
        {
          id: 1,
          title: '项目会议',
          description: '讨论新项目需求和进度安排',
          date: dayjs().format('YYYY-MM-DD'),
          time: '09:00',
          priority: 'high',
          category: '工作',
          completed: false,
          createdAt: dayjs().subtract(1, 'day').toISOString()
        },
        {
          id: 2,
          title: '健身锻炼',
          description: '健身房力量训练1小时',
          date: dayjs().format('YYYY-MM-DD'),
          time: '18:00',
          priority: 'medium',
          category: '健康',
          completed: false,
          createdAt: dayjs().subtract(2, 'day').toISOString()
        },
        {
          id: 3,
          title: '学习Vue3',
          description: '完成Vue3组合式API学习',
          date: dayjs().add(1, 'day').format('YYYY-MM-DD'),
          time: '14:00',
          priority: 'high',
          category: '学习',
          completed: false,
          createdAt: dayjs().subtract(3, 'day').toISOString()
        },
        {
          id: 4,
          title: '购物清单',
          description: '购买生活用品和食材',
          date: dayjs().add(2, 'day').format('YYYY-MM-DD'),
          time: '10:00',
          priority: 'low',
          category: '生活',
          completed: false,
          createdAt: dayjs().subtract(1, 'day').toISOString()
        }
      ]
    } catch (error) {
      console.error('加载日程失败:', error)
    } finally {
      loading.value = false
    }
  }

  const addSchedule = async (scheduleData) => {
    loading.value = true
    try {
      const newSchedule = {
        id: Date.now(),
        ...scheduleData,
        completed: false,
        createdAt: dayjs().toISOString()
      }
      schedules.value.unshift(newSchedule)
      return newSchedule
    } catch (error) {
      console.error('添加日程失败:', error)
      throw error
    } finally {
      loading.value = false
    }
  }

  const updateSchedule = async (id, scheduleData) => {
    loading.value = true
    try {
      const index = schedules.value.findIndex(schedule => schedule.id === id)
      if (index !== -1) {
        schedules.value[index] = { ...schedules.value[index], ...scheduleData }
        return schedules.value[index]
      }
      throw new Error('日程不存在')
    } catch (error) {
      console.error('更新日程失败:', error)
      throw error
    } finally {
      loading.value = false
    }
  }

  const deleteSchedule = async (id) => {
    loading.value = true
    try {
      const index = schedules.value.findIndex(schedule => schedule.id === id)
      if (index !== -1) {
        schedules.value.splice(index, 1)
        return true
      }
      throw new Error('日程不存在')
    } catch (error) {
      console.error('删除日程失败:', error)
      throw error
    } finally {
      loading.value = false
    }
  }

  const toggleComplete = async (id) => {
    const schedule = schedules.value.find(s => s.id === id)
    if (schedule) {
      return await updateSchedule(id, { completed: !schedule.completed })
    }
  }

  const setCurrentDate = (date) => {
    currentDate.value = dayjs(date)
  }

  return {
    // 状态
    schedules,
    loading,
    currentDate,
    // 计算属性
    todaySchedules,
    upcomingSchedules,
    completedSchedules,
    // 操作
    loadSchedules,
    addSchedule,
    updateSchedule,
    deleteSchedule,
    toggleComplete,
    setCurrentDate
  }
})

