<template>
  <div id="app">
    <h1>inner!</h1>

    <SessionForm></SessionForm>
  <OtherThing></OtherThing>
  </div>


  </div>
</template>

<script>
import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);
import SessionForm from './components/session_form'
import OtherThing from './components/otherThing'

export default {
  name: 'app',
  components:{
    SessionForm,
    OtherThing
  }
}


</script>

<style scoped>

p {
  font-size: 3em;
  text-align: center;
}
</style>
