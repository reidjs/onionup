<template>
  <div>
    <!-- <h2 v-if="loading">Loading</h2> -->
    <LineChart
      :pings="pings"
      :options="options"
      :labels="labels"
    >
    </LineChart>
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
      console.log(data)
      return {
        options: {
          scales: {
              xAxes: [{
                  ticks: {
                      beginAtZero:false
                  }
              }]
          },
            response: false,
            maintainAspectRatio: true
        },
        labels: [0, 1, 2, 3, 4]
      //   chartData: {
      //     datasets:
      //     [
      //       {
      //         label: 'Ping Response Time',
      //         backgroundColor: '#f87979',
      //         data: data
      //       }
      //     ]
      //   },
      //   options: {
      //     scales: {
      //         xAxes: [{
      //             ticks: {
      //                 beginAtZero:true
      //             }
      //         }]
      //     }
      //   }
      //   // test: this.$store.state.pings
      // }
      }
    },
    components: {
      LineChart 
    },
    computed: {
      pings: function(){
        // return this.$store.state.pings
        // return values(this.$store.state.pings)
        // loading = false;
        let pings = this.$store.state.pings
        console.log('trying to send pings', pings)
        if (pings === undefined) 
          return []
        let responseTimes = []
        // console.log(values(pings))
        values(pings).map(ping => {
          if (ping.responseTime === null)
            responseTimes.push(0)
          else
            responseTimes.push(ping.responseTime)
        })
        // console.log('res', responseTimes)
        console.log('sending', responseTimes)
        return responseTimes
        // return 
        // {
        //   datasets:
        //   [
        //     {
        //       label: 'Ping Response Time',
        //       backgroundColor: '#f87979',
        //       data: responseTimes
        //     }
        //   ]
        // }
      },
      sites: function(){
        return this.$store.state.sites
      },
      siteURL: function(){
        return this.$store.state.sites[this.id]
      }
    }
  }
</script>