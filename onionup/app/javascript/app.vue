<template>
  <div id="app">
    <SessionForm></SessionForm>
  </div>
</template>

<script>
import SessionForm from './components/session_form'
export default {
  name: 'app',
  components:{
    SessionForm
  }
}
</script>

<style scoped>

p {
  font-size: 3em;
  text-align: center;
}
</style>
