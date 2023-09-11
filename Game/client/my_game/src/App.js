import logo from './logo.svg';
import './App.css';
import io from "socket.io-client";
import {useEffect, useState} from 'react'
const socket = io.connect("http://localhost:3000")

function App() {
  const [mess,setmess] = useState("")
  const [mess_recie,setmess_recie] =useState("")
   const sendMessage = () => {
    socket.emit( "send_mess",mess )
  }

  useEffect(() => {
    socket.on("recieve_mess" , (data) => {
      setmess_recie(data)
    })
  },[socket])
  return (
    <div className="App">
      <input type='text'
      onChange={(event) => {
        setmess(event.target.value);
      }}
      />
      <button onClick = {sendMessage}>Send Massage</button>
      <div>message</div> 
      <div>
        {mess_recie}
      </div>
    </div>
  );
}

export default App;
