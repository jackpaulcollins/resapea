import React, { Component } from 'react';
import { Routes, Route } from "react-router-dom";
import Login from './auth/Login'
import axios from "axios";
import 'bootstrap/dist/css/bootstrap.min.css';
import Registration from './auth/Registration';
import { API_ROOT } from '../apiRoot'

export default class App extends Component {
  constructor() {
    super();

    this.state = {
      isLoggedIn: false,
      user: {}
    }

    this.handleLogin = this.handleLogin.bind(this)
    this.handleLogout = this.handleLogout.bind(this)
  }

  checkLoginStatus() {
    axios
      .get(`${API_ROOT}/api/logged_in`, { withCredentials: true })
      .then(response => {
        if (
          response.data.logged_in &&
          this.state.isLoggedIn === false
        ) {
          this.setState({
            isLoggedIn: true,
            user: response.data.user
          });
        } else if (
          !response.data.logged_in &
          (this.state.isLoggedIn === true)
        ) {
          this.setState({
            isLoggedIn: false,
            user: {}
          });
        }
      })
      .catch(error => {
        console.log("check login error", error);
      });
  }

  handleSuccessfulAuth(data) {
    this.handleLogin(data);
  }

  componentDidMount() {
    this.checkLoginStatus();
  }

  handleLogin(data) {
    this.setState({
      isLoggedIn: true,
      user: data.data.user
    })

  }

  handleLogout() {
    axios.delete(`${API_ROOT}/api/logout`, {withCredentials: true}).then(
      this.setState({
        isLoggedIn: false,
        user: {}
      })
    )
  }

  render() {
    return(
      <div>
        <Login />
        <Registration />
      </div>
    );
  }
}