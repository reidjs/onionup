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
        <footer class="index">
      <div class="profile">
        <h2>Artem</h2>
        <div class="links">
          <a href="www.linkedin.com/in/artem-kharshan"><i class="fa fa-linkedin-square" aria-hidden="true"></i>

</a>
          <a href="https://github.com/snorkleboy"><i class="fa fa-github-alt" aria-hidden="true"></i>
</a>
        </div>
      </div>
      <div class="profile">
        <h2>Chris</h2>
        <div class="links">
          <a href="https://www.linkedin.com/in/"><i class="fa fa-linkedin-square" aria-hidden="true"></i>

</a>
          <a href="https://www.github.com/"><i class="fa fa-github-alt" aria-hidden="true"></i>
</a>
        </div>
      </div>
      <div class="profile">
        <h2>Jay</h2>
        <div class="links">
          <a href="https://www.linkedin.com/in/"><i class="fa fa-linkedin-square" aria-hidden="true"></i>

</a>
          <a href="https://www.github.com/"><i class="fa fa-github-alt" aria-hidden="true"></i>
</a>
        </div>
      </div>
      <div class="profile">
        <h2>Reid</h2>
        <div class="links">
          <a href="https://www.linkedin.com/in/reidsherman"><i class="fa fa-linkedin-square" aria-hidden="true"></i>

</a>
          <a href="https://www.github.com/reidjs"><i class="fa fa-github-alt" aria-hidden="true"></i>
</a>
        </div>
      </div>
    </footer>
  </div>

</template>

<script>
  import Vue from 'vue';
  import VueRouter from 'vue-router';
  // import SessionForm from './components/session_form'
  import Sidebar from './components/sidebar'

  import IndexComponent from './components/index_component'
  import SiteShowComponent from './components/site_show_component';
  import LoginForm from './components/login_form'
  import SignupForm from './components/signup_form'
  import Vuex from 'vuex';
  import Vuetify from 'vuetify';
  import VeeValidate from 'vee-validate';


  
  import('../../app/assets/stylesheets/vuetify.css');
  Vue.use(Vuetify);
  Vue.use(VueRouter);
  Vue.use(Vuex);
 

  const config = {
    errorBagName: 'frontendErrors', // change if property conflicts
  }

   Vue.use(VeeValidate, config);

  import { store } from './store';


  const routes = [
    
    // { path: '/', component: SignupForm, meta: { requiresUnAuth: true} },
    { path: '/', component: IndexComponent,meta: { requiresAuth: true }},
    { path: '/sites/:id', component: SiteShowComponent , meta: { requiresAuth: true}, props: true },
    { path: '/login', component: LoginForm, meta: { requiresUnAuth: true} },
    { path: '/signup', component: SignupForm, meta: { requiresUnAuth: true} },
]

  const router = new VueRouter({
    // mode: 'history',
    routes // short for `routes: routes`
  })

router.beforeEach((to, from, next) => {
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
    },
    pings: function() {
      return this.$store.getters.pings
    }
  },
  store,
  components:{
    Sidebar
  },
}

</script>

