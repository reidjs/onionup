<template>
  <div>
    <h1>Site URL here</h1>
    <!-- <h2 v-if="loading">Loading</h2> -->
    <LineChart
      :chartData="chartData"
      :options="options"
      :test="pings"
    >
    </LineChart>
    <h1>a{{pings}}</h1>
    <button v-on:click="push">Add data!</button>
  </div>
</template>

<script>
  //UPDATING CHART DATA (see last comment)
  // https://github.com/apertureless/vue-chartjs/issues/44
  // debugger
  //SHould show spinner until site data is loaded in
  import LineChart from './line_chart'
  import values from 'lodash/values'
  let data = [20, 10, 30]
  // let loading = true
  export default {
    name: 'graph',
    methods: {
      push: function() {
        // console.log(data)
        data.push(50)
        
        // console.log(data)
      }
    },
    props:['id'],
    mounted() {
      // console.log('mounted')
      this.$store.dispatch("clearSites");
      this.$store.dispatch("clearPings");
      this.$store.dispatch("getSite", this.id);
      this.$store.dispatch("pingSite", this.id);
      // console.log(this.$store.state)
      // console.log(this.$store.state.pings)
    },
    data() {
      let data = this.$store.state.pings;
      return {
        chartData: {
          datasets:
          [
            {
              label: 'Ping Response Time',
              backgroundColor: '#f87979',
              data: [4,5,6]
            }
          ]
        },
        options: {
          scales: {
              xAxes: [{
                  ticks: {
                      beginAtZero:true
                  }
              }]
          }
        }
        // test: this.$store.state.pings
      }
    },
    components: {
      LineChart 
    },
    computed: {
      pings: function(){
        return this.$store.state.pings
        // loading = false;
      },
      sites: function(){
        return this.$store.state.sites
      }
    }
  }
</script>