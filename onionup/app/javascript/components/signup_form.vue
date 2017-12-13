<template>
  <div class="auth-form">
    <div class="auth-inner-wrapper">
      <h1> Sign up to start checking the status of your favorite Onion sites.</h1>
      <ul id="error-list">
        <li class="error-msg"v-for="(error) in errors" :key="error[0]" >
          {{error}}
        </li>
      </ul>
      <div class="form-name form">
        <label class="label-username">Username </label><input type="text" placeholder="What's your name?" v-model="user.username">
      </div>
      <div class="form-password form">
        <label class="label-password">Password </label>
        <div class="pw-submit">
          <input type="password" v-model="user.password">
          <button v-on:click="signIn">SIGN UP</button>
        </div>
      </div>
       <p class="account-prompt">Already have account?
        <router-link to="/login">Click Here</router-link> log in!
      </p>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';
  export default {
    name: 'signup-form',
    data() {
      return{
        user: {
          username: '',
          password: ''
        },
        errors: []
      }
    },
    methods:{
      signIn: function() {
        let user = {
          "user": {
            "username": this.user.username,
            "password": this.user.password
          } 
        }

        console.log("sign in", this);
        
        this.$store.dispatch('signUserIn',user).then(()=>this.$router.push('/'));                                                     

      },
    }
  }
</script>
