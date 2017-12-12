<template>
  <div id="app">
    <router-link to="/session">SessionForm</router-link>
    <hr/>
    <router-view></router-view>
    
  </div>
</template>

<script>
  import Vue from 'vue';
  import VueRouter from 'vue-router';

  Vue.use(VueRouter);
  import SessionForm from './components/session_form'
  import IndexComponent from './components/index_component'
  import SiteShowComponent from './components/site_show_component';

  const routes = [
    { path: '/', component: IndexComponent },
    { path: '/session', component: SessionForm },
    { path: '/site', component: SiteShowComponent }
    
  ]

  const router = new VueRouter({
    routes // short for `routes: routes`
  })


  export default {
    name: 'app',

    router
  }


</script>

<style scoped>

p {
  font-size: 3em;
  text-align: center;
}
</style>
