import { Line, mixins } from 'vue-chartjs';
//The mixins automatically create chartData as a prop or data. And add a watcher. If data has changed, the chart will update. However keep in mind the limitations of vue and javascript for mutations on arrays and objects.
//THIS MUST RECEIVE CHARTDATA AS A PROP. NO OTHER NAME IS ALLOWED
export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['chartData', 'options', 'labels'],
  mounted () {
    // console.log(this.data)
    let chartData = this.chartData;
    console.log('chartdata', this.chartData)
    // let chartData = [5,6,7,8]
    let labels = this.labels;

    // console.log('linechart', chartData)
    // console.log('data:', chartData)
    this.renderChart({
      labels: labels,
      datasets: [
        {
          label: 'Response Time',
          backgroundColor: '#f87979',
          data: chartData
        }
      ]
    })
  }
}