<template>
  <div class="auth-form">
    <div class="auth-inner-wrapper">
      <h1> Welcome back, login to get started</h1>
      <ul id="error-list">
         <li class="error-msg">
          {{errors}}
        </li>
      </ul>
      <div class="form-name form">
        <label class="label-username">Username </label><input type="text" v-model="user.username">
      </div>
      <div class="form-password form">
        <label class="label-password">Password </label>
        <div class="pw-submit">
          <input type="password" v-model="user.password">
          <button v-on:click="login">LOG IN</button>    
        </div>
      </div>
       <p class="account-prompt">Don't have an account?
        <router-link v-on:click.native="clearErrors" to="/signup">Click Here</router-link> to create one!
      </p> 
    </div>
  </div>  
</template>


<script>
  import axios from 'axios';
  export default {
    name: 'login-form',
    data() {
      return{
        user: {
          username: '',
          password: ''
        }
      }
    },
    computed:{
      errors () {
        return this.$store.getters.errors
      }
    },
    methods:{
      login: function() {
        let user = {
          "user": {
            "username": this.user.username,
            "password": this.user.password
          } 
        }
      this.$store.dispatch('logCurrentUserIn',user).then( ()=>{
        console.log("login redirect to '/'")
        this.$router.push('/')})
      console.log("user log in", user);
      
      },
      clearErrors: function() {
        this.$store.dispatch('clearErrors');
      }
    },

  }
</script>
