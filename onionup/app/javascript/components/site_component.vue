<template>
  <div class="site">
    <p><strong>{{site.url}}</strong></p>
    <p>{{site.ping_ids.length}}</p>
    <p> Site ID: {{site.id}}</p>

  </div>
</template>

<script>
  import axios from 'axios';
  export default {
    name: 'Site',
    props: ['siteProp'],
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

    created(){
      
    },

    methods:{
      greet: function(){
        alert('hello');
      },

      login: function(){
        axios.post(`https://localhost:3000/api/session`,{
          user: {
            username: this.user.username,
            password: this.user.password
          }
        }).then(res => {
          alert(`logged in as ${res.data.username}`)
        }).catch(e => {
        console.log(e);
        this.errors.push(e)
        })
      },
    },
    
    computed: {
      site: function(){
        
        return this.siteProp
      },
      info: function(){
        return this.user.username+" "+this.user.password;
        
      }
    }
  }
</script>

<style scoped>

  
</style>