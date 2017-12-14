import { Line, mixins } from 'vue-chartjs';
//The mixins automatically create chartData as a prop or data. And add a watcher. If data has changed, the chart will update. However keep in mind the limitations of vue and javascript for mutations on arrays and objects.

export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['datasets', 'options', 'labels', 'test'],
  mounted () {
    // console.log('here')
    console.log(this.test)
    let datasets = this.datasets;
    let options = this.options;
    //Labels should be an array of strings 
    let labels = this.labels;
    // labels = ['a']
    // console.log(datasets)
    //I know I can dereference these, I just don't want to.
    this.renderChart({
      labels: labels, datasets: datasets, options: options
    })
  }
}