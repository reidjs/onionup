<template>
  <div>
    <h1> Welcome!, Sign up to start checking the status of your favorite Onion sites.</h1>
    <label>Username: </label><input type="text" v-model="user.username"><br />
    <label>Password: </label><input type="text" v-model="user.password"><br />
    <button v-on:click="login">Log in</button>
  </div>
</template>


<script>
  import axios from 'axios';
  export default {
    name: 'login-form',
    data() {
      return{
        user: {
          username: 'username',
          password: 'password'
        }
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
          alert(`logged in as ${res.data.username}`)
        })
        .catch(e => {
          console.log(e);
          this.errors.push(e)
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