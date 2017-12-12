<template>
  <div id="app">
  
    <router-link to="/session">SessionForm</router-link>
    
      <router-view></router-view>
      <hr/>
  </div>
</template>

<script>
import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);
import SessionForm from './components/session_form'
import IndexComponent from './components/index_component'

const routes = [
  { path: '/', component: IndexComponent },
  { path: '/session', component: SessionForm }
  
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
