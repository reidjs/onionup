import { Line, mixins } from 'vue-chartjs';
//The mixins automatically create chartData as a prop or data. And add a watcher. If data has changed, the chart will update. However keep in mind the limitations of vue and javascript for mutations on arrays and objects.
//THIS MUST RECEIVE CHARTDATA AS A PROP. NO OTHER NAME IS ALLOWED
export default {
  extends: Line,
  props: ['pings', 'options', 'labels'],
  mounted () {
    // debugger
    // console.log(this.data)
    // let chartData = this.chartData;
    // console.log('chartdata', chartData)
    // let chartData = [5,6,7,8]
    // let labels = this.labels;
    // if (chartData === undefined)
      // chartData = [];
    // console.log('linechart', chartData)
    // console.log('data:', chartData)
    this.renderChart({
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
      datasets: [
        {
          label: 'GitHub Commits',
          backgroundColor: '#f87979',
          data: []
        }
      ]
    })
  },
  watch: { 
    pings: function(newData, oldData){
      console.log('pings reced', newData)
      this.renderChart({
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        datasets: [
          {
            label: 'GitHub Commits',
            backgroundColor: '#f87979',
            data: newData
          }
        ]
      })
    }
  }
}