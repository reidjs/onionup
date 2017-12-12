
<template >

      <div v-if="currentUser" class="sidebar">
        <h1>sidebar</h1>
        <router-link to="/">Go to /</router-link>
        <router-link to="/ot">Go to /ot</router-link>
      </div>


  
</template>


<<script>

  export default {
    name: 'sidebar',
    data(){
      return {
          currentUser: Boolean(window.currentUser.username)
        }
    }
  }



</script>