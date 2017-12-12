<template>
  <div id="app">
    <h1>inner!</h1>
    <p>
    <!-- use router-link component for navigation. -->
    <!-- specify the link by passing the `to` prop. -->
    <!-- `<router-link>` will be rendered as an `<a>` tag by default -->
    <router-link to="/">Go to /</router-link>
    <router-link to="/ot">Go to /ot</router-link>
    <router-link to="/login">login</router-link>
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
import SessionForm from './components/session_form'
import OtherThing from './components/otherThing'
import LoginForm from './components/login_form'

const routes = [
  { path: '/', component: SessionForm },
  { path: '/ot', component: OtherThing },
  { path: '/login', component: LoginForm },
]

const router = new VueRouter({
  routes // short for `routes: routes`
})


export default {
  name: 'app',
  components:{
    SessionForm,
    OtherThing,
    LoginForm
  },
  router
}


</script>

<style scoped>

p {
  font-size: 3em;
  text-align: center;
}
</style>
