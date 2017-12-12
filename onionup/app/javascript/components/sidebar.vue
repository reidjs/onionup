
<template >

      <div v-if="currentUser" class="sidebar">
        <div class="sidebar-logo">
          <p class="logo-image">
            ONION UP
          </p>
        </div>
        <div>
          <div>
            <ul class="dropdown">
              <li>
                <router-link to="/">Go to /</router-link>
              </li>
              <li>
                <router-link to="/">Go to /</router-link>
              </li>
              <li>
                <router-link to="/">Go to /</router-link>
              </li>
            </ul>
          </div>
          <div>
            <router-link to="/site">go to site</router-link>
          </div>
          <div>
            <router-link to="/login">go to login</router-link>
          </div>
          <div>
            <router-link to="/signup">go to signup</router-link>
          </div>
          
          
          
        </div>
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