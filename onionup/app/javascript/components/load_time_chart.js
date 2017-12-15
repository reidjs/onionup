import { Line, mixins } from 'vue-chartjs';
//The mixins automatically create chartData as a prop or data. And add a watcher. If data has changed, the chart will update. However keep in mind the limitations of vue and javascript for mutations on arrays and objects.
//THIS MUST RECEIVE CHARTDATA AS A PROP. NO OTHER NAME IS ALLOWED
export default {
  extends: Line,
  props: ['pings', 'options'],
  mounted () {
    this.renderChart({
      labels: ['Data Incoming'],
      datasets: [
        {
          label: 'Load Times',
          // backgroundColor: '#000000',
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
            label: 'Load Times',
            backgroundColor: "rgba(255,26,14,0.2)",
            data: newData.loadTimes
          }
        ]
      });
    },
    deep: true //because we are sending an object
  }
}