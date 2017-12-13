import { Line, mixins } from 'vue-chartjs';
//The mixins automatically create chartData as a prop or data. And add a watcher. If data has changed, the chart will update. However keep in mind the limitations of vue and javascript for mutations on arrays and objects.
export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['chartData', 'options'],
  
  mounted () {
    // let datasets = 
    //   [
    //     {
    //       label: 'GitHub Commits',
    //       backgroundColor: '#f87979',
    //       data: [40, 20, 12, 39, 10, 40, 39, 80, 40, 20, 12, 11]
    //     }
    //   ]
    let data = this.chartData
    // console.log(data)
    this.renderChart({datasets: data}, this.options);
  }
}