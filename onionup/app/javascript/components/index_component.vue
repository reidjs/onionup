
<template>
  <div id="main">
    <h1>Uptime Checker</h1>
    <hr/>
    
    <ul v-if="siteKeys && siteKeys.length">
      <li v-for="key in siteKeys">
        <router-link to='/site'>

          <Site v-bind:siteProp='sites[key]'></Site>
        </router-link>
      </li>
    </ul>
 
    <br/>
    
  </div>
</template>


<script>
  import axios from 'axios';
  import Site from './site_component';


  export default {
    name: 'IndexComponent',
    components: {
      Site
    },
    data(){
      return{
        
        siteKeys:[],
        pingKeys:[],
        sites:{},
        pings:{}
      }
    },
    created(){
      
      axios.get(`http://localhost:3000/api/ping`)
      .then(res => {
        
        this.siteKeys = Object.keys(res.data.sites);
        this.pingKeys = Object.keys(res.data.pings);
        this.sites = res.data.sites;
        this.pings = res.data.pings;
        this.keys = res.data.keys;
        console.log(res.data);
        
      })
      .catch(e => {
        console.log('error');
        
      })
    }
  }



</script>

<style>
  td,th{
    border: 1px solid #dddddd;
  }
  li{
    list-style:none 
  }
</style>