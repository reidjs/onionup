
<template >

      <div v-if="currentUser" class="sidebar">
        <h1>sidebar</h1>
        <router-link to="/">Go to /</router-link>
        <router-link to="/login">login</router-link>
        <router-link to="/signup">signup</router-link>
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