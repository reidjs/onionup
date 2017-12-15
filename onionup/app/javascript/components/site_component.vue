<template>
  <div  class="site">
    <div v-if="lastPing" class="site-inner-wrapper site-status">
      <div >
        <p v-if="lastPing.status" class="site-fa">
          <i class="fa fa-arrow-circle-up up" aria-hidden="true"></i>
        </p>
        <p v-else class="site-fa">
          <i class="fa fa-arrow-circle-down down" aria-hidden="true"></i>
        </p>
      </div>
      <div class="site-url">
        <p class="data-title">Site url:</p>
        <p id="url">{{site.url}}</p>
      </div>
      <div class="site-response">
        <p class="data-title">Response Time:</p>
        <div class="site-stat">
          <p id="response">{{lastPing.responseTime}}</p>
          <p id="unit">ms</p>
        </div>
      </div>
       <div class="site-load">
        <p class="data-title ">HTTP Load:</p>
        <div class="site-stat">
          <p id="response">{{lastPing.loadTime}}</p>
          <p id="unit">ms</p>
        </div>
      </div>
      <div class="site-updated left-indent-30">
        <p class="data-title ">Updated at:</p>
        <p>{{lastPing.created_at}}</p>
      </div>
    </div>
    <div v-else class="site-inner-wrapper">
      <div>
        <p class="data-title ">Site url:</p>
        <p id="url">{{site.url}}</p>
      </div>
    </div>
   
  </div>

</template>

<script>
  import axios from 'axios';
  export default {
    name: 'Site',
    props: ['siteProp'],

    
    data() {
      // console.log(this.pingProps[this.site.ping_ids[site.ping_ids.length-1]].status)
      
      return{
        status: true,
        site:this.siteProp
      }
    },

    created(){
      
      
    },

    methods:{

  
    },
    computed: {
      lastPing: function(){
        
        const lastping = this.pings[this.pings.length-1]
        console.log('lastping', lastping, "this:", this)
        return lastping
        // this.LastPing=lastping;
      },
      pings: function(){
        console.log("pings calculation")
        //get every ping in the global store whos id is included in the  ping_id array of the site prop
        return Object.values(this.$store.state.pings).filter( (ping) => this.siteProp.ping_ids.includes(ping.id) )
      }

    }
  }
</script>

