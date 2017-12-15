<template>
  <div class="site-show-container">
    <h1>{{siteData.url}}</h1>
    <!-- <h2 v-if="loading">Loading</h2> -->
    <div id="show-chart">
      <LineChart
        :pings="pings"
        :options="options"
      >
      </LineChart>
    </div>
    <h1>Received: {{pings}}</h1>
  </div>
</template>

<script>
  //UPDATING CHART DATA (see last comment)
  // https://github.com/apertureless/vue-chartjs/issues/44
  // debugger
  //SHould show spinner until site data is loaded in
  import LineChart from './line_chart'
  import values from 'lodash/values'
  // let data = [20, 10, 30]
  // let loading = true
  export default {
    name: 'graph',
    props:['id'],
    mounted() {
      // console.log('mounted')
      this.$store.dispatch("clearSites");
      this.$store.dispatch("clearPings");
      this.$store.dispatch("getSite", this.id);
      this.$store.dispatch("pingSite", this.id);
      // console.log(this.$store.state.pings)
      // console.log(this.pings)
      // console.log(this.$store.state)
      // console.log(this.$store.state.pings)
    },
    data() {
      let data = values(this.$store.state.pings);
      // this.pings()
      // console.log(data)
      return {
        options: {
          scales: {
              xAxes: [{
                  ticks: {
                      beginAtZero:false
                  }
              }]
          },
          responsive: false,
          maintainAspectRatio: false
        }

      }
    },
    components: {
      LineChart 
    },
    computed: {
      pings: function(){
        let pings = this.$store.state.pings
        // console.log('trying to send pings', pings)
        if (pings === undefined) 
          return []
        let responseTimes = []
        let labels = []
        let loadTimes = []
        console.log(values(pings))
        values(pings).map(ping => {
          if (ping.responseTime === null) {
            responseTimes.push(0)
            loadTimes.push(0)
          }
          else {
            responseTimes.push(ping.responseTime)
            loadTimes.push(ping.loadTime)
          }
          labels.push(ping.created_at)
        })
        // console.log('res', responseTimes)
        // console.log('sending', responseTimes)
        return {
          responseTimes,
          labels,
          loadTimes
        }
      },
      sites: function(){
        return this.$store.state.sites
      },
      siteData: function(){
        const sites = values(this.$store.state.sites)
        if (sites[0])
          return sites[0]
        else 
          return "Loading site data"
      }
    }
  }
</script>