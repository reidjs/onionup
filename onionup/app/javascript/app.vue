<template>
  <div id="app">
    <h1>inner!</h1>
    <p>
    <!-- use router-link component for navigation. -->
    <!-- specify the link by passing the `to` prop. -->
    <!-- `<router-link>` will be rendered as an `<a>` tag by default -->
    <router-link to="/">Go to /</router-link>
    <router-link to="/ot">Go to /ot</router-link>
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
import Vuex from 'vuex';

Vue.use(VueRouter);
Vue.use(Vuex);
import SessionForm from './components/session_form';
import OtherThing from './components/otherThing';
import { store } from './store';

const routes = [
  { path: '/', component: SessionForm },
  { path: '/ot', component: OtherThing }
]

const router = new VueRouter({
  routes // short for `routes: routes`
})


export default {
  name: 'app',
  computed: {
    sites: function() {
      return this.$store.getters.sites
    },
    session: function() {
      return this.$store.getters.session
    }
  },
  store: store,
  components:{
    SessionForm,
    OtherThing
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
