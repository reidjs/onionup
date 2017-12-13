<template>
  <div class="site-form">
      <h1>Add Site</h1>
      <ul id="error-list">
        <li class="error-msg">
          {{errors}}
        </li>
      </ul>
      <div class="form-site-url form">
        <label class="label-site-url">URL (clearnet or .onion)</label>
        <input type="text" placeholder="http://www.example.onion" @keydown.enter="addSite" v-model="site.url">
      </div>
      <button v-on:click="addSite">Add Site</button>
  </div>
</template>

<script>
  export default {
    name: 'site-form',
    data() {
      return{
        site: {
          url: ''
        }
      }
    },
    computed:{
      errors () {
        return this.$store.getters.errors
      },
      currentUser() {
        return this.$store.state.session.currentUser;
      }
    },
    methods:{
      addSite: function() {
        let site = {
          "site": {
            "url": this.user.url
          } 
        }
      

        
        this.$store.dispatch('addSite', site).then(()=>this.$router.push('/'));                                                     

      },
      clearErrors: function() {
        this.$store.dispatch('clearErrors');
      }
    }
  }
</script>
