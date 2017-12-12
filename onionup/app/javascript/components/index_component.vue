
<template>
  <div id="main">
    <h1>Sites</h1>   
    <ul v-if="sites && sites.length">
      <li v-for="site in sites">
        <p>{{site.url}}</p> 
        <hr/>
      </li>
    </ul>


    <h1>Pings</h1>    
    <ul v-if="pings && pings.length">
      <li v-for="ping in pings">
        <p>{{ping.id}}</p> 
        <p>{{ping.id}}</p> 
        <hr/>
      </li>
    </ul> 

    {{pings}}
    <br/>
    {{sites}}
  </div>
</template>


<script>
  import axios from 'axios';

  export default {
    name: 'IndexComponent',
    data(){
      return{
        
        sites:[],
        pings:[],
      }
    },
    created(){
      axios.get(`http://localhost:3000/api/ping`)
      .then(res => {

        this.sites = res.data.sites;
        // this.pings = res.data.pings;
      })
      .catch(e => {
        console.log('error');
        
      })
    }
  }



</script>