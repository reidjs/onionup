<template >
  <div v-if="currentUser" class="sidebar">
    <div class="sidebar-logo">
      <p class="logo-image">
        <router-link to="/">OnionUp</router-link>
        
      </p>
    </div>
    <div>
      <router-link to="/">
        <div class="sidebar-menu">
          <div class="menu-inner-wrapper">
            <p>
              <i class="fa fa-bar-chart" aria-hidden="true"></i>
                Home
              <!-- <i id="arrow" class="fa fa-angle-up" aria-hidden="true"></i> -->
            </p>
          </div>
        </div>
      </router-link>
      <div v-on:click="toggleMenu(1)" class="sidebar-menu">
          <div class="menu-inner-wrapper">
            <p>
              <i class="fa fa-window-restore" aria-hidden="true"></i>
              Sites
            </p>
            <i id="arrow" class="fa fa-angle-up" aria-hidden="true"></i>
          </div>
      </div>
      <div id="menu-list-1" class="menu-list hidden">
        <div>
        <ul class="dropdown">
          <router-link to="sites/1">
            <li class="site-link">
            site 1
            </li>
          </router-link>
          <router-link to="site/2">
            <li class="site-link">
            site 2
            </li>
          </router-link>
        </ul>
      </div>
      </div>
     
      <div class="sidebar-menu">
        <a v-on:click="logout">
          <div class="menu-inner-wrapper">
            <p class="logout-div">
              <i class="fa fa-user user-fa" aria-hidden="true"></i>
              Logout
            </p>
            <!-- <i id="arrow" class="fa fa-angle-up" aria-hidden="true"></i> -->
          </div>
        </a>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  name: "sidebar",
  computed: {
    currentUser() {
      return this.$store.state.session.currentUser;
    }
  },
  methods: {
    logout: function() {
      this.$store.dispatch("logout").then(() => this.$router.push("login"));
      console.log("logout");
    },
    toggleMenu: function(i) {
      const el = document.getElementById(`menu-list-${i}`);
      el.classList.contains("hidden")
        ? el.classList.remove("hidden")
        : el.classList.add("hidden");
      const fa = document.getElementById("arrow");
      if (fa.classList.contains("fa-angle-down")) {
        fa.classList.remove("fa-angle-down");
        fa.classList.add("fa-angle-up");
      } else if (fa.classList.contains("fa-angle-up")) {
        fa.classList.remove("fa-angle-up");
        fa.classList.add("fa-angle-down");
      }
    }
  },
  data() {
    return {
      // currentUser: Boolean(window.currentUser)
    };
  }
};
</script>