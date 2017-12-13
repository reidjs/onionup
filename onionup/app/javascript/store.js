import Vuex from 'vuex';
import Vue from 'vue';
Vue.use(Vuex);
import axios from 'axios';
let getUser = undefined;

if (window.currentUser) {
  console.log("BOOTSTRAP");
  getUser = window.currentUser;
}

// console.log("STORE",window.currentUser);

export const store = new Vuex.Store({
  state: {
    sites: {},
    session: { currentUser:getUser},
    errors: {}
  },
  getters: {
    sites: state => state.sites,
    session: state => state.session
  },
  mutations: {
    ADD_CURRENT_USER (state, payload) {
      const currentUser = {
        id: payload.id,
        username: payload.username
      };
      console.log("payload",payload)
      state.session.currentUser = currentUser;
    },
    ADD_SITE (state, payload) {
      const site = {
        id: payload.id,
        url: payload.url
      };
      state.sites.unshift(site); 
    },
    LOGOUT (state) {
      console.log("LOGOUT")
      state.session = {currentUser: undefined};
    }
  },
  actions: {
    addSite (context) {
      context.commit('ADD_SITE');
    },
    logCurrentUserIn (context, user) {
      console.log('logCurrentUserIn action',user);

        return axios.post(`http://localhost:3000/api/session`,
          user
        )
          .then(res => {
            console.log('addcurrenuser OK', res.data);
            // window.currentUser='true';
            context.commit('ADD_CURRENT_USER', res.data);
            
          })
          .catch(e => {
            console.log('addcurrenuser ERROR', e);
            // debugger
            this.errors.push(e.response.data[0]);
          });
      
    },
    signUserIn(context, user){
      
        return axios.post(`http://localhost:3000/api/users`,
          user
        )
          .then(res => {
            context.commit('ADD_CURRENT_USER', res.data);
            // alert(`logged in as ${res.data.username}`)
          })
          .catch(e => {
            console.log(e);
            this.errors.push(e.response.data[0]);
          });
      
    },
    logout (context) {
      return axios.delete(`http://localhost:3000/api/session`)
        .then(res => {
          context.commit('LOGOUT');
          // alert(`logged in as ${res.data.username}`)
        })
        .catch(e => {
          console.log(e);
          this.errors.push(e.response.data[0]);
        });


      
    }
  }
});