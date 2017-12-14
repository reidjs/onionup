<template>
  <div>
    <h1>Site URL here</h1>
    <LineChart 
      :datasets="datasets"
      :options="options"
    >
    </LineChart>
    <button v-on:click="push">Add data!</button>
  </div>
</template>

<script>
  //UPDATING CHART DATA (see last comment)
  // https://github.com/apertureless/vue-chartjs/issues/44
  // debugger
  import LineChart from './line_chart'
  let data = [20, 10, 30]
  export default {
    name: 'graph',
    methods: {
      push: function() {
        // console.log(data)
        data.push(50)
        
        console.log(data)
      }
    },
    props:['id'],
    data() {
      console.log('id: ', this.id, 'asdf') 
      return {
        datasets:
        [
          {
            label: 'Stuff',
            backgroundColor: '#f87979',
            data: data
          }
        ],
        options: {
          scales: {
              xAxes: [{
                  ticks: {
                      beginAtZero:true
                  }
              }]
          }
        } 
      }
    },
    components: {
      LineChart 
    }
  }
</script>