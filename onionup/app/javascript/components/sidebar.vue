
<template >


      <div v-if="currentUser" class="sidebar">

        <!-- 
          
          <div v-if="currentUser" class="sidebar">
        <h1>sidebar</h1>
        <router-link to="/">Go to /</router-link>
        <router-link to="/site">go to site</router-link>
        <router-link to="/login">go to login</router-link>
        <router-link to="/signup">go to signup</router-link>
        <button v-on:click="logout">Logout</button>
          
          
          -->
        <div class="sidebar-logo">
          <p class="logo-image">
            ONION UP
          </p>
        </div>
        <div>
          <div v-on:click="toggleMenu(1)" class="menu">
             <div class="menu-inner-wrapper">
                <p>
                  <i class="fa fa-bar-chart" aria-hidden="true"></i>
                 Uptime
                </p>
                <i id="arrow" class="fa fa-angle-down" aria-hidden="true"></i>
              </div>
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
          <div>
          <div v-on:click="toggleMenu(2)" class="menu">
             
             <p>Reports</p>
          </div>
           <div id="menu-list-2" class="menu-list hidden">
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
          <div>
          <div v-on:click="toggleMenu(3)" class="menu">
             <p>Account</p>
          </div>
           <div id="menu-list-3" class="menu-list hidden">
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
          
          
          
        </div>
      </div>


  
</template>


<script>

  export default {
    name: 'sidebar',
    computed: {
      currentUser () {
        return this.$store.state.session.currentUser
      } 
    },
    methods: {
      logout: function () {
         this.$store.dispatch('logout').then(()=>this.$router.push('login'))
        console.log("logout")
      },
      toggleMenu: function(i) {
        const el = document.getElementById(`menu-list-${i}`);
        el.classList.contains('hidden') ? 
          el.classList.remove('hidden') : 
          el.classList.add('hidden');
        const fa = document.getElementById("arrow");
        fa.classList.contains('fa-angle-down')
      }
    },
    data(){
      return {
          // currentUser: Boolean(window.currentUser)
        }
    }
  }



</script>