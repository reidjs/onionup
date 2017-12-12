
<template>
  <div id="main">
    <h1>Sites</h1>   
    <ul v-if="siteKeys && siteKeys.length">
      <li v-for="key in siteKeys">
        <p>{{sites[key].url}}</p> 

        <ul v-if="pingKeys && pingKeys.length"> 
          <li v-for="pingKey in pingKeys">
            <p>{{pings[pingKey].status}}</p>
            <p>{{pings[pingKey].created_at}}</p>
          </li>
        </ul>
        
      </li>
    </ul>


    <h1>Pings</h1>    
    <ul v-if="pingKeys && pingKeys.length">
      <li v-for="key in pingKeys">
        <p>{{pings[key]}}</p> 
        
        
      </li>
    </ul> 

    <h1>{{pings}}</h1>
    <br/>
    
  </div>
</template>


<script>
  import axios from 'axios';

  export default {
    name: 'IndexComponent',
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
        
      })
      .catch(e => {
        console.log('error');
        
      })
    }
  }



</script>