import React from 'react';
import { PageHOC } from '../components';
import { useGlobalContext } from '../context';
const Home = () => {
  const {account} = useGlobalContext();
  return (
    <div>
     {console.log("account from home",account)}
    </div>
  )
};

export default PageHOC(
  Home,
  <>Welcome to Game Web3 <br/> a game made by Red Hawks Team </>,
  <>Connect your wallet <br/> to start playing Web3 game</>
)