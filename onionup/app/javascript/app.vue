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
  import Sidebar from './components/sidebar'
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
    
    { path: '/', component: SignupForm, meta: { requiresUnAuth: true} },
    { path: '/sites', component: IndexComponent,meta: { requiresAuth: true }},
    { path: '/sites/:id', component: SiteShowComponent ,meta: { requiresAuth: true} },
    { path: '/login', component: LoginForm, meta: { requiresUnAuth: true} },
    { path: '/signup', component: SignupForm, meta: { requiresUnAuth: true} },
]

  const router = new VueRouter({
    routes // short for `routes: routes`ion
  })

router.beforeEach((to, from, next) => {
  console.log("before each",store.state.session)
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (!store.state.session ) {
      console.log('not signed in redirect')
      next({
        path: '/login',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
        // this route requires not being signd in, check if logged in
    // if yes, redirect to /.
  }else if(to.matched.some(record => record.meta.requiresUnAuth)){
      if (store.state.session.currentUser ) {
            next({
              path: '/',
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

