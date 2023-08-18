import React from 'react';
import { PageHOC } from '../components';
const Home = () => {
  return (
    <div>
     
    </div>
  )
};

export default PageHOC(
  Home,
  <>Welcome to Game Web3 <br/> a game made by Red Hawks Team </>,
  <>Connect your wallet <br/> to start playing Web3 game</>
)