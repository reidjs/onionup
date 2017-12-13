<template>
  <div>
    <h1>Site URL here</h1>
    <LineChart 
    :chartData="datasets"
  >
    </LineChart>
  </div>
</template>

<script>
  import LineChart from './line_chart'
  
  export default {
    name: 'graph',
    data() {
      return {
        datasets:
        [
          {
            label: 'Stuff',
            backgroundColor: '#f87979',
            data: [40, 20, 12, 39, 10, 40, 39, 80, 40, 20, 12, 11]
          }
        ]
      }
    },
    components: {
      LineChart 
    }
  }
</script>