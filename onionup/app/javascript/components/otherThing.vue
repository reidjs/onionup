
<template>
  <div id="otherThing">
      <h1>I am otherThing</h1>
      {{stat}}

      <h1>I am otherThing</h1>
  </div>

  
</template>


<<script>

  export default {
    name: 'otherThing',
    data(){
        console.log(this)
        return{
            stat: "statyy"
        }
    }
  }



</script>