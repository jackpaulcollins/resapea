import React, { useState } from 'react';
import { useNavigate } from "react-router-dom";
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import axios from 'axios';
import { API_ROOT } from '../../apiRoot'

const Registration = (props) => {
  const navigate = useNavigate();
  const [ first_name, setFirstName ] = useState('');
  const [ last_name, setLastName  ] = useState('');
  const [ username, setUsername  ] = useState('');
  const [ email, setEmail ] = useState('');
  const [ password, setPassword ] = useState('');
  const [ password_confirmation, setPasswordConfirmation  ] = useState('');

  async function handleSubmit(e) {
    e.preventDefault();
    let data = await axios.post(`${API_ROOT}/api/registrations`, {
      user: {
        first_name: first_name,
        last_name: last_name,
        email: email,
        username: username,
        password: password,
        password_confirmation: password_confirmation
      }
    },
    { withCredentials: true})
    if (data) {
      props.handleLogin(data)
      navigate("/");
    }
  }
  
  return (
    <div className="container">
      <div className="login-registration-container">
        <h1>Register</h1>
        <Form onSubmit={e => handleSubmit(e)}>
          <Form.Group className="mb-1" controlId="first_name">
            <Form.Control 
              type="text" 
              placeholder="First Name" 
              name="first_name" 
              value={first_name}
              onChange={e => setFirstName(e.target.value)} 
            />
          </Form.Group>
          <Form.Group className="mb-1" controlId="last_name">
            <Form.Control 
              type="text" 
              placeholder="Last Name" 
              name="last_name"
              value={last_name} 
              onChange={e => setLastName(e.target.value)} 
            />
          </Form.Group>
          <Form.Group className="mb-1" controlId="username">
            <Form.Control 
              type="text" 
              placeholder="username" 
              name="username"
              value={username} 
              onChange={e => setUsername(e.target.value)} 
            />
          </Form.Group>
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
          <Form.Group className="mb-1" controlId="password_confirmation">
            <Form.Control 
              type="password" 
              placeholder="Confirm your password" 
              name="password_confirmation" 
              value={password_confirmation}
              onChange={e => setPasswordConfirmation(e.target.value)} 
            />
          </Form.Group>
          <Button className="button" variant="primary" type="submit">
            Submit
          </Button>
        </Form>
      </div>
    </div>
    );
  }

export default Registration;