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
import SessionForm from './components/session_form'
import OtherThing from './components/otherThing'
import LoginForm from './components/login_form'
import SignupForm from './components/signup_form'

const routes = [
  { path: '/', component: SessionForm },
  { path: '/ot', component: OtherThing },
  { path: '/login', component: LoginForm },
  { path: '/signup', component: SignupForm },
]

const router = new VueRouter({
  routes // short for `routes: routes`
})


export default {
  name: 'app',
  components:{
    SessionForm,
    OtherThing,
    LoginForm,
    SignupForm
  },
  router
}


</script>

<style scoped>

</style>
