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
              <a :href="'/#/sites/' + key">
                <Site v-bind:siteProp='sites[key]' v-bind:pingProp='pings'></Site>
              </a>
            </div>
          </li>
        </ul>
      </div>
      <button v-on:click="getSite">get site id 1</button>
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
      computed: {
        siteKeys(){
          return Object.keys(this.$store.state.sites)
        },
        pingKeys(){
          return Object.keys(this.$store.state.pings)
        },
        pings(){
          return this.$store.state.pings
        },
        sites(){
          return this.$store.state.sites
        }
    },
    created(){
      this.$store.dispatch("getSites")
    },
    methods:{
      getSite: function(){
        this.$store.dispatch("getSite", 1)
    },
      
  }
}
</script>
