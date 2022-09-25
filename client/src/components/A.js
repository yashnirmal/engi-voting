import React,{useContext,useEffect} from 'react';
import web3StuffContext from "../context/Web3StuffContext";


export default function A() {

  let { web3, contract, account } = useContext(web3StuffContext);
  useEffect(()=>{
    console.log(web3, contract, account);
  },[web3, contract, account])
  
  function connectToWallet() {}

  return (
    <div>
      <button onClick={connectToWallet}>Connect to wallet</button>
      <p>{account}</p>
    </div>
  );
}
