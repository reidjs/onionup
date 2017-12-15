<template>
  <div class="site-show-container">
    <h1 v-if="siteData.alias">{{siteData.alias}}</h1>
    <h2>{{siteData.url}}</h2>
    <!-- <h2 v-if="loading">Loading</h2> -->
    <h1>HTTP Response (Through Tor)</h1>
    <div id="chart">
      <ResponseTimeChart
        :pings="pings"
        :options="options"
      >
      </ResponseTimeChart>
    </div>
    <div class="data-box-container">
      <div class="data-box">
        <h2>Average Response Time</h2>
        <p>{{pings.averageResponseTime}}</p>
        <footer>ms</footer>
      </div>
      <div class="data-box">
        <h2>Max Response Time</h2>
        <p>{{pings.maxResponseTime}}</p>
        <footer>ms</footer>
      </div>
      <div class="data-box">
        <h2>Min Response Time</h2>
        <p>{{pings.minResponseTime}}</p>
        <footer>ms</footer>
      </div>
    </div>
    <h1>Page Load (Through Tor) </h1>
    <div id="chart">
      <LoadTimeChart
        :pings="pings"
        :options="options"
      >
      </LoadTimeChart>
    </div>
    <div class="data-box-container">
      <div class="data-box">
        <h2>Average Load Time</h2>
        <p>{{pings.averageLoadTime}}</p>
        <footer>ms</footer>
      </div>
      <div class="data-box">
        <h2>Max Load Time</h2>
        <p>{{pings.maxLoadTime}}</p>
        <footer>ms</footer>
      </div>
      <div class="data-box">
        <h2>Min Load Time</h2>
        <p>{{pings.minLoadTime}}</p>
        <footer>ms</footer>
      </div>
    </div>
    <h1>Combined</h1>
    <div id="chart">
      <DualChart
        :pings="pings"
        :options="options"
      >
      </DualChart>
    </div>
  </div>
</template>

<script>
  //UPDATING CHART DATA (see last comment)
  // https://github.com/apertureless/vue-chartjs/issues/44
  // debugger
  //SHould show spinner until site data is loaded in
  import DualChart from './dual_chart'
  import LoadTimeChart from './load_time_chart'
  import ResponseTimeChart from './response_time_chart'
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
                      beginAtZero:false,
                      lineWidth:3,
                      fontSize:18
                  }
              }]
          },
          responsive: false,
          maintainAspectRatio: false
        }

      }
    },
    components: {
      LoadTimeChart,
      DualChart,
      ResponseTimeChart 
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
        let averageLoadTime = 0;
        // console.log(values(pings))
        let averageResponseTime = 0;
        let maxResponseTime = 0;
        let maxLoadTime = 0;
        let minResponseTime = null;
        let minLoadTime = null;
        values(pings).map(ping => {
          if (ping.responseTime === null) {
            responseTimes.push(0)
            loadTimes.push(0)
          }
          else {
            responseTimes.push(ping.responseTime)
            loadTimes.push(ping.loadTime)
          }
          averageResponseTime += ping.responseTime
          averageLoadTime += ping.loadTime
          if (ping.responseTime > maxResponseTime)
            maxResponseTime = ping.responseTime
          if (ping.loadTime > maxLoadTime)
            maxLoadTime = ping.loadTime
          if (ping.responseTime < minResponseTime || minResponseTime === null)
            minResponseTime = ping.responseTime
          if (ping.loadTime < minLoadTime || minLoadTime === null)
            minLoadTime = ping.loadTime
          let time = new Date(ping.created_at)
          labels.push(time.toLocaleString())
        })
        // console.log('res', responseTimes)
        // console.log('sending', responseTimes)
        if (pings.length > 0) {
          averageResponseTime = averageResponseTime/pings.length
          averageLoadTime = averageLoadTime/pings.length
        }
        return {
          responseTimes,
          labels,
          loadTimes,
          averageResponseTime,
          averageLoadTime,
          maxResponseTime,
          maxLoadTime,
          minResponseTime,
          minLoadTime
        }
      },
      sites: function(){
        return this.$store.state.sites
      },
      siteData: function(){
        const sites = values(this.$store.state.sites)
        if (sites[0]) {
          return sites[0]
        } else {
          return "Loading site data"
        }
      }
    }
  }
</script>