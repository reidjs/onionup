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
  import Sidebar from './components/sidebar';
  import IndexComponent from './components/index_component'
  import SiteShowComponent from './components/site_show_component';
  import LoginForm from './components/login_form'
  import SignupForm from './components/signup_form'
  import Vuex from 'vuex';
  import Vuetify from 'vuetify';
  
  import('../../node_modules/vuetify/dist/vuetify.css');
  Vue.use(Vuetify);
  Vue.use(VueRouter);
  Vue.use(Vuex);

  import { store } from './store';

  console.log("APP",window.currentUser);

  const routes = [
    
    // { path: '/', component: SignupForm, meta: { requiresUnAuth: true} },
    { path: '/', component: IndexComponent,meta: { requiresAuth: true }},
    { path: '/site/:id', component: SiteShowComponent ,meta: { requiresAuth: true} },
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
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    //  debugger
    console.log("requires auth", 'Store:',store.state.session)
    if (!store.state.session.currentUser ) {
      console.log('not signed in redirect', store.state.session.currentUser, "values",Object.values(store.state.session),Object.keys(store.state.session))
      console.log('not signed in redirect', store.state.session)
      
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
        console.log("signed in redirect", store.state.session)
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

