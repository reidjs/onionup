<template>
  <div id="app">
    <main class='main-content'>
      <Sidebar></Sidebar>
      <transition name="fade" mode="out-in">
        <router-view></router-view>
      </transition>
    </main>
  </div>


  </div>
</template>

<script>
import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);
import SessionForm from './components/session_form'
import OtherThing from './components/otherThing'
import Sidebar from './components/sidebar'


const routes = [
  { 
    path: '/', 
    component: SessionForm,
    meta: { 
      requiresAuth: true
    }

  },

  { 
    path: '/ot',
    component: OtherThing, 
    meta: { 
      requiresAuth: true
    }

  }
]

const router = new VueRouter({
  routes // short for `routes: routes`
})

router.beforeEach((to, from, next) => {
  console.log(to);
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (!Boolean(window.currentUser.username) ) {
      next({
        path: '/login',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else {
    next()
  }
})

export default {
  name: 'app',
  router,
  components:{
    Sidebar
  }
}


</script>

<style scoped>

p {
  font-size: 3em;
  text-align: center;
}
</style>
