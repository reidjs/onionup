<template>
  <div class="site">
    <div>
      <p v-if="lastPing.status" class="site-fa">
        <i class="fa fa-arrow-circle-up up" aria-hidden="true"></i>
      </p>
      <p v-else class="site-fa">
        <i class="fa fa-arrow-circle-down down" aria-hidden="true"></i>
      </p>
    </div>
    <div>
      <p>Site url:</p>
      <p id="url">{{site.url}}</p>
    </div>
    <div>
      <p>Response Time:</p>
      <p id="response">{{lastPing.responseTime}}</p>
      <p id="unit">ms</p>
    </div>
    <div>
      <p>Updated at:</p>
      <p>{{lastPing.created_at}}</p>
    </div>
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
        status: true,
       
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

      lastPing: function(){
        const ping = this.siteProp.ping_ids[this.siteProp.ping_ids.length - 1];
        const stat = this.pingProp[ping]
        console.log(stat)
        return stat;
      }
    }
  }
</script>

