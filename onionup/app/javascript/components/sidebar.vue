
<template >


      <div v-if="currentUser" class="sidebar">
        <div class="sidebar-logo">
          <p class="logo-image">
            ONION UP
          </p>
        </div>
        <div>
          <div v-on:click="toggleMenu(1)" class="menu">
             <p>Menu</p>
          </div>
           <div id="menu-list-1" class="menu-list">
              <div>
              <ul class="dropdown">
                <li>
                  <router-link to="1">sub-menu-1</router-link>
                </li>
                <li>
                  <router-link to="2">sub-menu-2</router-link>
                </li>
                <li>
                  <router-link to="3">sub-menu-3</router-link>
                </li>
              </ul>
            </div>
             
            </div>
            
          </div>
          <div class="menu">
            <router-link to="/site">go to site</router-link>
          </div>
          <div class="menu">
            <router-link to="/login">go to login</router-link>
          </div>
          <div class="menu">
            <router-link to="/signup">go to signup</router-link>
          </div>
          <div class="menu">
            <button v-on:click="logout">Logout</button>
          </div>
          
          
          
        </div>
      </div>


  
</template>


<<script>

  export default {
    name: 'sidebar',
    computed: {
      currentUser () {
        return this.$store.state.session.currentUser
      } 
    },
    methods: {
      logout: function () {
        this.$store.dispatch('logout')
      },
      toggleMenu: function(i) {
        const el = document.getElementById(`menu-list-${i}`);
        el.classList.contains('hidden') ? 
          el.classList.remove('hidden') : 
          el.classList.add('hidden');
      }
    },
    data(){
      return {
          // currentUser: Boolean(window.currentUser)
        }
    }
  }



</script>