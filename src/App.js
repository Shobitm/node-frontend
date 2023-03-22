import React, { useState } from 'react';
import './App.css';

function App() {
  const [userInput, setUserInput] = useState({name: '', price: ''});
  const [products, setProducts] = useState([]);

const url = process.env.REACT_APP_API_URL;

  const fetchProducts = async () => {
    const response = await fetch(url);
    const data = await response.json();
    setProducts(data);
  }
  const addProduct = async () => {
    console.log(JSON.stringify(userInput),)
    const resp = await fetch(url, {
      method: 'POST', 
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(userInput),
    })
    const data = await resp.json();
    await fetchProducts();
    console.log(data);
  }
  
  return (
    <div className="App">
      <button onClick={fetchProducts}>Fetch Products</button>
      <div>
        <label>Item</label>
        <input value = {userInput.name} onChange = {(e) => setUserInput({...userInput, name: e.target.value})} />
      </div>
      <div>
        <label>Price</label>
        <input value = {userInput.price} onChange = {(e) => setUserInput({...userInput, price: +e.target.value})} />
      </div>
      <button onClick={addProduct}>Add Product</button>
      {products.map((product) => {
        return (
          <div key={product.id} style={{display: "flex", alignItems: "center", justifyContent: "flex-start", gap: '40px'}}>
            <h3>{product.name}</h3>
            <p>{product.price}</p>
          </div>
        )
      })}
    </div>
  );
}

export default App;
