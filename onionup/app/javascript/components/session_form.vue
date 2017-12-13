<template>
  <div class="test">
    <input type="text" v-model="title"><br />
    <h1>{{title}}</h1>
    <p v-if='showName'>{{user.firstName}}</p>
    <p v-else> Nobody</p>
    <ul>
      <li v-for='item in items'>{{item.title}}</li>
    </ul>
    <button v-on:click="greet"> Say Greeting</button>

    <br />
    <br />
    <hr/>
    <h1> User session form below:</h1>
    <label>Username: </label><input type="text" v-model="user.username"><br />
    <label>Password: </label><input type="text" v-model="user.password"><br />
    
    <button v-on:click="login">Log in</button>
    
    <h2>{{info}}</h2>
    
    <hr/>
    <br />

    
    <ul v-if="posts && posts.length">
      <li v-for="post in posts">
        <p><strong>{{post.title}}</strong></p>
        
        <p>{{post.body}}</p>
        <hr/>
      </li>
    </ul>

    <ul v-if="errors && errors.length">
      <li v-for="error in errors">
        {{error.message}}
      </li>
    </ul>

    <br />


  </div>
  





</template>

<script>
  import axios from 'axios';
  export default {
    name: 'session-form',
    data() {
      return{
        title:'hello world',
        posts:[],
        errors:[],
        user: {
          firstName: 'jay',
          lastName: 'park',
          username: 'username',
          password: 'password'

        },
        postBody: '',
        success:[],
        errors:[],
        showName: true,
        items: [
          {title: 'Item one'},
          {title: 'Item two'},
          {title: 'Item three'} 
        ]
      }
    },

   

    methods:{
      greet: function(){
        alert('hello');
      },



      login: function(){
          axios.post(`/api/session`,{
            user: {
              username: this.user.username,
              password: this.user.password
            }
          })
      .then(res => {
        this.$router.go('/');
        // alert(`logged in as ${res.data.username}`)
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