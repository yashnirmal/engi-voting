import "./App.css";
import {useState,useEffect,useContext} from "react";
import Web3StuffContextProvider from "./context/Web3StuffContext.js";
import A from "./components/A";

function App() {



  return (
    <>
    <Web3StuffContextProvider>
      <A />
  
    </Web3StuffContextProvider>
    </>
  );
}

export default App;
