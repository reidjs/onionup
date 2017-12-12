<template>
  <div class="auth-form">
    <div class="auth-inner-wrapper">
      <h1> Welcome back, login to get started</h1>
      <ul id="error-list">
        <li class="error-msg"v-for="(error) in errors" :key="error[0]" >
          {{error}}
        </li>
      </ul>
      <div class="form-name form">
        <label class="label-username">Username </label><input type="text" v-model="user.username">
      </div>
      <div class="form-password form">
        <label class="label-password">Password </label>
        <div class="pw-submit">
          <input type="password" v-model="user.password">
          <button v-on:click="login">Log in</button>
        </div>
      </div>
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
        axios.post(`http://localhost:3000/api/session`,
          user
        )
        .then(res => { 
          alert(`logged in as ${res.data.username}`)
        })
        .catch(e => {
          console.log(e);
          // debugger
          this.errors.push(e.response.data[0])
        })
      },
    },
    computed: {
      info: function(){
        return this.user.username+" "+this.user.password; 
      }
    }
  }
</script>

<style scoped>

</style>