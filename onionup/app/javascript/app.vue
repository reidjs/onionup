<template>
  <div id="app">

    <main class='main-content'>
      <transition name="fade" mode="out-in">
        <Sidebar></Sidebar>
      </transition>
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
  import SessionForm from './components/session_form'
  import IndexComponent from './components/index_component'
  import SiteShowComponent from './components/site_show_component';
  import LoginForm from './components/login_form'
  import SignupForm from './components/signup_form'
  import Vuex from 'vuex';
  
  Vue.use(VueRouter);
  Vue.use(Vuex);

  import { store } from './store';

  console.log("APP",window.currentUser);

  const routes = [
    
    // { path: '/', component: SignupForm, meta: { requiresUnAuth: true} },
    { path: '/', component: IndexComponent,meta: { requiresAuth: true }},
    { path: '/sites/:id', component: SiteShowComponent ,meta: { requiresAuth: true} },
    { path: '/login', component: LoginForm, meta: { requiresUnAuth: true} },
    { path: '/signup', component: SignupForm, meta: { requiresUnAuth: true} },
]

  const router = new VueRouter({
    // mode: 'history',
    routes // short for `routes: routes`
  })

router.beforeEach((to, from, next) => {
  console.log("before each", to , from)
  if (to.matched.some(record => record.meta.requiresAuth)) {

    if (!store.state.session.currentUser ) {
      next({
        path: '/login',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  }else if(to.matched.some(record => record.meta.requiresUnAuth)){
      if (store.state.session.currentUser ) {
            next({
              path: '/',
              query: { redirect: to.fullPath }
            })
          } else {
            next()
          }
  }  else {
    next()
  }
})



 export default {
  name: 'app',
  router,
  computed: {
    sites: function() {
      return this.$store.getters.sites
    },
    session: function() {
      return this.$store.getters.session
    }
  },
  store,
  components:{
    Sidebar
  },
}

</script>

