<template >
  <div v-if="currentUser" class="sidebar">
    <div class="sidebar-logo">
      <p class="logo-image">
        <router-link to="/">ONION UP</router-link>
        
      </p>
    </div>
    <div>
      <div v-on:click="toggleMenu(1)" class="sidebar-menu">
          <div class="menu-inner-wrapper">
            <p>
              <i class="fa fa-bar-chart" aria-hidden="true"></i>
              Uptime
            </p>
            <i id="arrow" class="fa fa-angle-up" aria-hidden="true"></i>
          </div>
      </div>
      <div id="menu-list-1" class="menu-list hidden">
        <div>
        <ul class="dropdown">
            <li>
            <router-link to="1">sub-menu-1</router-link>
          </li>
            <li>
            <router-link to="1">sub-menu-1</router-link>
          </li>
        </ul>
      </div>
      </div>
      <div class="sidebar-menu">
        <div class="menu-inner-wrapper">
          <p>
            <i class="fa fa-bar-chart" aria-hidden="true"></i>
            <router-link to="/">Other Menu</router-link>
            <!-- <i id="arrow" class="fa fa-angle-up" aria-hidden="true"></i> -->
          </p>
        </div>
      </div>
      <div class="sidebar-menu">
        <div class="menu-inner-wrapper">
          <p>
            <i class="fa fa-bar-chart" aria-hidden="true"></i>
            <a v-on:click="logout">Logout</a>
          </p>
          <!-- <i id="arrow" class="fa fa-angle-up" aria-hidden="true"></i> -->
        </div>
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