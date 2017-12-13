<template>
  <div class="site">
    <p>{{site.status}}</p>
    <i class="fa fa-arrow-circle-down" aria-hidden="true"></i>
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
       

      }
    },

    created(){
      
    },

    methods:{
  
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

