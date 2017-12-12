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
import Sidebar from './components/sidebar'
  import IndexComponent from './components/index_component'
  import SiteShowComponent from './components/site_show_component';
  import LoginForm from './components/login_form'
  import SignupForm from './components/signup_form'

const routes = [
  { path: '/', 
    component: IndexComponent,
    meta: { 
      requiresAuth: true
    }

  },
    { path: '/site', component: SiteShowComponent },
    { path: '/login', component: LoginForm },
    { path: '/signup', component: SignupForm },
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
    Sidebar,
    IndexComponent,
    SiteShowComponent,
    LoginForm,
    SignupForm
  },
}


</script>

<style scoped>

</style>
