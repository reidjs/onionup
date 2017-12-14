import { Line, mixins } from 'vue-chartjs';
//The mixins automatically create chartData as a prop or data. And add a watcher. If data has changed, the chart will update. However keep in mind the limitations of vue and javascript for mutations on arrays and objects.

export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['data'],
  mounted () {
    console.log(this.data)
    this.renderChart(this.data)
  },
  watch: {
    'data': {
      handler: function(newData, oldData) {
        console.log('data', newData)
      }
    },
    deep: true
  }
}