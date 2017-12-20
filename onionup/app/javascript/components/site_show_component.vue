<template>
  <div class="site-show-container">
    <h1 v-if="siteData.alias">{{siteData.alias}}</h1>
    <h2>{{siteData.url}}</h2>
    <!-- <h2 v-if="loading">Loading</h2> -->
    <h1>HTTP Response (Through Tor)</h1>
    <div id="chart">
      <ResponseTimeChart
        :pings="pings"
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

      this.$store.dispatch("getSite", this.id);
    },
    data() {
      let data = values(this.$store.state.pings);
      // this.pings()
      // console.log(data)
      return {
    
      }
    },
    components: {
      LoadTimeChart,
      DualChart,
      ResponseTimeChart 
    },
    computed: {
      pings: function(){
        let options = {
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
          maintainAspectRatio: true
        }
        // let pings = this.$store.state.pings;
        let pings = [];
        let id = Number(this.id);
        let ping_ids = []
        //make sure site is loaded in
        if (this.$store.state.sites[id]) {
          ping_ids = this.$store.state.sites[id].ping_ids;
        } else {
          return []
        }
        // console.log(ping_ids, this.$store.state.pings)
        if (ping_ids) {
          ping_ids.map(p_id => {
            if(this.$store.state.pings[p_id]) pings.push(this.$store.state.pings[p_id])
          })
        }
        // console.log('my pings', pings)
        // debugger
        // let mypings = this.$store.state.site.
        // debugger 
        // console.log('trying to send pings', pings)

        let responseTimes = [];
        let times = [];
        let dates = [];
        let loadTimes = [];
        let averageLoadTime = 0;
        // console.log(values(pings))
        let averageResponseTime = 0;
        let maxResponseTime = 0;
        let labels = [];
        let maxLoadTime = 0;
        let minResponseTime = null;
        let minLoadTime = null;
        let latestPingDate;
        let latestPingTime;
        let i = 0;

        if (pings !== undefined) {
          console.log("pings",pings)
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
            let datetime = new Date(ping.created_at)
            times.push(datetime.toLocaleTimeString())
            dates.push(datetime.toLocaleDateString())
            labels.push(i)
            i++;
          })

          if (pings.length > 0) {
          averageResponseTime = Math.floor(averageResponseTime/pings.length)
          averageLoadTime = Math.floor(averageLoadTime/pings.length)
          }
        }
        // console.log('res', responseTimes)
        // console.log('sending', responseTimes)

        return {
          responseTimes,
          times,
          labels,
          loadTimes,
          options,
          latestPingDate,
          latestPingTime,
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
        // console.log('site id', this.id)
        const site = this.$store.state.sites[this.id]
        console.log('site:', site)
        if (site) {
          return site
        } else {
          return {}
        }
      }
    }
  }
</script>