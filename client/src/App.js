import React, { Component } from "react";
import ConnectedDevice from "./components/ConnectedDevice";

const endpoint = "ws://azazel.banshai.com:3000";

class App extends Component {
  state = {
    response: false,
    devices: []
  };

  componentDidMount() {
    const socket = new WebSocket(endpoint);
    socket.onmessage = ({ data }) => {
      if (data.match(/connected$/g)) return;
      let device = JSON.parse(data);
      if (this.state.devices.filter(item => item.id === device.id).length) {
        this.setState({
          devices: this.state.devices.map(
            item => (item.id === device.id ? device : item)
          )
        });
      } else {
        this.setState({
          devices: [...this.state.devices, device]
        });
      }
    };
  }

  render() {
    return (
      <div>
        {this.state.devices.map(item => (
          <ConnectedDevice key={item.id} data={item} />
        ))}
      </div>
    );
  }
}

export default App;
