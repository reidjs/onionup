
<template >

      <div v-if="currentUser" class="sidebar">
        <h1>sidebar</h1>
        <router-link to="/">Go to /</router-link>
        <router-link to="/site">go to site</router-link>
        <router-link to="/login">go to login</router-link>
        <router-link to="/signup">go to signup</router-link>
      </div>


  
</template>


<<script>

  export default {
    name: 'sidebar',
    data(){
      return {
          currentUser: Boolean(window.currentUser)
        }
    }
  }



</script>