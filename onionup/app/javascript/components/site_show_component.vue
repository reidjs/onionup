<template>
  <div class="site">
    <p><strong>in site show</strong></p>
    <p></p>
  </div>
</template>

<script>
  import axios from 'axios';
  export default {
    name: 'SiteShowComponent',
    // props: ['siteProp'],
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

<style scoped>

  
</style>