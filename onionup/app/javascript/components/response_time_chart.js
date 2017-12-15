import { Line, mixins } from 'vue-chartjs';
//The mixins automatically create chartData as a prop or data. And add a watcher. If data has changed, the chart will update. However keep in mind the limitations of vue and javascript for mutations on arrays and objects.
//THIS MUST RECEIVE CHARTDATA AS A PROP. NO OTHER NAME IS ALLOWED
export default {
  extends: Line,
  props: ['pings'],
  mounted () {
    this.renderChart({
      labels: ['Data Incoming'],
      datasets: [
        {
          label: 'Response Time',
          backgroundColor: '#fc4d51',
          data: []
        }
      ]
    });
  },
  watch: { 
    pings: function(newData, oldData){
      // console.log('pings received', newData)
      this.renderChart({
        labels: newData.labels,
        datasets: [
          {
            label: 'Response Time (ms)',
            backgroundColor: "#fc4d51",
            data: newData.responseTimes
          }
        ],
        options: newData.options
      });
    },
    deep: true //because we are sending an object
  }
}