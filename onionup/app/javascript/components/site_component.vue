<template>
  <div class="site">

    <p v-if="status">
      <i class="fa fa-arrow-circle-up up" aria-hidden="true"></i>
    </p>
    <p v-else>
      <i class="fa fa-arrow-circle-down down" aria-hidden="true"></i>
    </p>
   
    
    <p><strong>{{site.url}}</strong></p>
    <p>{{site.ping_ids.length}}</p>
    <p> Site ID: {{site.id}}</p>

  </div>
</template>

<script>
  import axios from 'axios';
  export default {
    name: 'Site',
    props: ['siteProp','pingProp'],

    
    data() {
      // console.log(this.pingProps[this.site.ping_ids[site.ping_ids.length-1]].status)
      
      return{
        status: false,
        
        
       
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

      ping: function(){
        return this.pingProp
      },

      info: function(){
        return this.user.username+" "+this.user.password;
        
      }
    }
  }
</script>

