import React, { useState } from 'react';
import { useNavigate } from "react-router-dom";
import Button from 'react-bootstrap/Button';
import Alert from 'react-bootstrap/Alert';
import Form from 'react-bootstrap/Form';
import axios from 'axios';
import { API_ROOT } from '../../apiRoot'

const Login = (props) => {
  const navigate = useNavigate();
  const [ email, setEmail ] = useState('');
  const [ password, setPassword ] = useState('');
  const [ authState, setAuthState ] = useState(false)

  async function handleSubmit(e) {
    e.preventDefault();
    let data = await axios.post(`${API_ROOT}/api/sessions`, {
      user: {
        email: email,
        password: password,
      }
    },
    { withCredentials: true})
    if (data.data.user) {
      props.handleLogin(data)
      navigate("/");
    } else {
      setAuthState(true)
    }
  }

  const authError = () =>{
    if (authState){
      return (
        <Alert variant="danger">
        Error Logging in, please check your email and password and try again.
        </Alert>
      )
    }
  }
  
  return (
    <div className="container">
      <div className="login-registration-container">
        <div>
          <h1>Login</h1>
        </div>
        <div>
        <Form onSubmit={e => handleSubmit(e)}>
          <Form.Group className="mb-1" controlId="email">
            <Form.Control 
              type="email" 
              placeholder="Email" 
              name="email"
              value={email}
              onChange={e => setEmail(e.target.value)} 
            />
          </Form.Group>

          <Form.Group className="mb-1" controlId="password">
            <Form.Control 
              type="password" 
              placeholder="Password" 
              name="password"
              value={password} 
              onChange={e => setPassword(e.target.value)} 
            />
          </Form.Group>
          <Button className="button" variant="primary" type="submit">
            Submit
          </Button>
        </Form>
        {authError()}
        </div>
      </div>
    </div>
    );
  }

export default Login;