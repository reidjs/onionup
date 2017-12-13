<template>
  <div id="main" class="index-main">
    <div class="content-header">
      <h1><i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp;&nbsp;Uptime Checks</h1>
    </div>
    

    <div class="index-wrapper">
      <div class="cards-toolbar">
        <select>
          <option value="24">Last 24 hours</option>
          <option value="7">Last 7 days</option>
          <option value="30">Last 30 daysl</option>
          <option value="all">All history</option>
        </select>
      </div>
      <div class="cards-wrapper">
        <ul v-if="siteKeys && siteKeys.length">
          <li v-for="key in siteKeys" v-bind:key="key">
            <div class="site-box">
              <a :href="'/#/site/' + key">
                <Site v-bind:siteProp='sites[key]' v-bind:pingProp='pings'></Site>
              </a>
            </div>
          </li>
        </ul>
      </div>
    </div>
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
      axios.get(`api/ping`)
      .then(res => {  
        this.siteKeys = Object.keys(res.data.sites);
        this.pingKeys = Object.keys(res.data.pings);
        this.sites = res.data.sites;
        this.pings = res.data.pings;
        this.keys = res.data.keys;
        console.log(res.data);  
      })
      .catch(e => {
        console.log('failed to get ping request');
        
      })
    }
  }

</script>
