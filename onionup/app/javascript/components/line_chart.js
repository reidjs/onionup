import { Line, mixins } from 'vue-chartjs';
//The mixins automatically create chartData as a prop or data. And add a watcher. If data has changed, the chart will update. However keep in mind the limitations of vue and javascript for mutations on arrays and objects.
export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['datasets', 'options'],
  mounted () {
    let datasets = this.datasets
    let options = this.options
    this.renderChart({
      labels: ['a', 'b', 'c'], datasets: datasets, options: options

    })
  }
}