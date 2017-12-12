<template>
  <div id="app">
    
    <p>
    <!-- use router-link component for navigation. -->
    <!-- specify the link by passing the `to` prop. -->
    <!-- `<router-link>` will be rendered as an `<a>` tag by default -->
  
    <router-link to="/login">login</router-link>
    <router-link to="/signup">signup</router-link>
  </p>
  <!-- route outlet -->
  <!-- component matched by the route will render here -->
  <router-view></router-view>
  </div>


  </div>
</template>

<script>
  import Vue from 'vue';
  import VueRouter from 'vue-router';

  Vue.use(VueRouter);

  import IndexComponent from './components/index_component'
  import SiteShowComponent from './components/site_show_component';
  import LoginForm from './components/login_form'
  import SignupForm from './components/signup_form'

  const routes = [
    { path: '/', component: IndexComponent },
    { path: '/site', component: SiteShowComponent },
    { path: '/login', component: LoginForm },
    { path: '/signup', component: SignupForm },
    
  ]

  const router = new VueRouter({
    routes // short for `routes: routes`
  })


 export default {
  name: 'app',
  components:{
    IndexComponent,
    SiteShowComponent,
    LoginForm,
    SignupForm
  },
  router
}


</script>

<style scoped>

</style>
