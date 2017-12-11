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
    <hr/>
    <br />


    <input type="text" v-model="postBody"/>
    <ul v-if="errors && errors.length">
      <li v-for="error of errors">
        {{error.message}}
      </li>
    </ul>
    <button v-on:click="post">post Post</button>
    <h3>{{success}}</h3>
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
          username: 'Username',
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
    //created method executes when the component is created
    created(){
      
      axios.get(`http://jsonplaceholder.typicode.com/posts`)
      .then(res => {
        
        this.posts = res.data.splice(90)
      })
      .catch(e => {
        console.log(e);
        this.errors.push(e)
      })
    },

   

    methods:{
      greet: function(){
        alert('hello');
      },
      login: function(){
        console.log(this.user.username+" "+this.user.password);
      },
      post: function(){

        console.log(this.postBody)
        axios.post(`http://jsonplaceholder.typicode.com/posts`, {
          body: this.postBody
        }).then(res => this.success.push(res.data));
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