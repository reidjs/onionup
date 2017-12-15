<template>
  <div id="main" class="index-main">
    <div class="content-header">
      <h1>
        <span class="index-header-title hover-message">    
          <i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp;&nbsp;Uptime Checks
          <div class="message-text">
            <span> 
              message box 
            </span>
          </div>
        </span>
        <div class="pinger-holder">
          <transition name="fade">
            <button class='pinger' v-on:click="pingSites" v-if="!loading">
              <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;Refresh
            </button>
            <h1 v-else class="loader"></h1>
          </transition>
        </div>
      </h1>
    </div>

    <div class="index-wrapper">
      
      <div class="cards-wrapper">
        <ul v-if="siteKeys && siteKeys.length">
          <li v-for="key in siteKeys" v-bind:key="key">
            <div class="site-box">
              <a :href="'/#/sites/' + key">
                <Site v-bind:siteProp='sites[key]'></Site>
              </a>
            </div>
          </li>
        </ul>
      </div>

     
    </div>
    <br/>  
    <!-- Vuetify button -->
    <div>
      
      <v-layout row>
        <v-flex xs12 sm6 offset-sm11>
          <v-btn
            fab
            small
            color="theme-color accent-2"
            bottom
            right
            
            @click.native.stop="dialog = !dialog">
            
            <i class="fa fa-plus white--text" aria-hidden="true"></i>
          </v-btn>
          <v-card>
            <v-dialog v-model="dialog" max-width="500px">
              <v-card>
              <v-card-text>
                <p :class= "{'control': true }">
                  <!-- <v-text-field v-validate="'url'" :class="{ 'input': true, 'is-danger': errors.has('url') }" name="url" label="Add a Site" type="text"></v-text-field>
                  <span v-show="errors.has('url')" class="help is-danger">{{ errors.first('url') }}</span> -->
                  <!-- <v-text-field name="alias-field" type="text" placeholder="alias" v-model="site.alias"></v-text-field>  -->
                  <v-text-field v-validate="'url:require_protocol'" data-vv-as="field" :class="{'input': true, 'is-danger': frontendErrors.has('url_field') }" name="url_field" type="text" placeholder="url"></v-text-field> 
                  <span v-show="frontendErrors.has('url_field')" class="help is-danger">{{ frontendErrors.first('url_field') }}</span>
                </p>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn flat color="primary" @click.native="dialog = false">Create</v-btn>
              </v-card-actions>
              </v-card>
            </v-dialog>
          </v-card>
        </v-flex>
      </v-layout>

    </div>
    <footer class="index">
      <div class="profile">
        <h2>Artem</h2>
        <div class="links">
          <a href="https://www.linkedin.com/in/"><i class="fa fa-linkedin-square" aria-hidden="true"></i>

</a>
          <a href="https://www.github.com/"><i class="fa fa-github-alt" aria-hidden="true"></i>
</a>
        </div>
      </div>
      <div class="profile">
        <h2>Chris</h2>
        <div class="links">
          <a href="https://www.linkedin.com/in/"><i class="fa fa-linkedin-square" aria-hidden="true"></i>

</a>
          <a href="https://www.github.com/"><i class="fa fa-github-alt" aria-hidden="true"></i>
</a>
        </div>
      </div>
      <div class="profile">
        <h2>Jay</h2>
        <div class="links">
          <a href="https://www.linkedin.com/in/"><i class="fa fa-linkedin-square" aria-hidden="true"></i>

</a>
          <a href="https://www.github.com/"><i class="fa fa-github-alt" aria-hidden="true"></i>
</a>
        </div>
      </div>
      <div class="profile">
        <h2>Reid</h2>
        <div class="links">
          <a href="https://www.linkedin.com/in/reidsherman"><i class="fa fa-linkedin-square" aria-hidden="true"></i>

</a>
          <a href="https://www.github.com/reidjs"><i class="fa fa-github-alt" aria-hidden="true"></i>
</a>
        </div>
      </div>
    </footer>
  </div>
  
</template>

<script>
  import axios from 'axios';
  import Site from './site_component';

  export default {
    
    data(){
      return{
        dialog: false,
        loading: false,


      }
    },

    name: 'IndexComponent',
    components: {
      Site
    },
    
    computed: {
      siteKeys(){
        return Object.keys(this.$store.state.sites)
      },
      pingKeys(){
        return Object.keys(this.$store.state.pings)
      },
      pings(){
        return this.$store.state.pings
      },
      sites(){
        return this.$store.state.sites
      }
    },

    created(){
      this.$store.dispatch("getSites")
    },
  
    methods:{
      getSite: function(){
          this.$store.dispatch("getSite", 1)
      },
      pingSites: function(){
          this.loading = true;
          this.$store.dispatch("pingSites").then(()=> this.loading = false)
      }
        
  }
}
</script>

