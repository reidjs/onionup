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
        <label class="label-username">Username </label>
        <input type="text" placeholder="What's your name?" @keydown.enter="login" v-model="user.username">
      </div>
      <div class="form-password form">
        <label class="label-password">Password </label>
        <div class="pw-submit">
          <input type="password" @keydown.enter="login" v-model="user.password">
          <button v-on:click="login">SIGN UP</button>
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
      login: function() {
        let user = {
          "user": {
            "username": this.user.username,
            "password": this.user.password
          } 
        }
        axios.post(`http://localhost:3000/api/users`,
          user
        )
        .then(res => { 
          this.$router.go('/');
          // alert(`logged in as ${res.data.username}`)
        })
        .catch(e => {
          console.log(e);
          this.errors.push(e.response.data[0])
        })
      },
    }
  }
</script>
