import React from "react";
import styled from "styled-components";

const Card = styled.div`
  border-radius: 5px;
  background-color: #efefef;
  margin: 1em;
  padding: 2em;
  box-shadow: 1px 1px 3px #121212;
  display: flex;
  justify-content: space-between;
  height: 150px;
  width: 150px;
  align-items: center;
  flex-flow: column;
`;

const Bar = styled.div`
  height: 40px;
  width: 90%;
  background-color: #424242
  transform: ${({ pitch, roll }) => `rotate(${pitch}deg) skew(${roll}deg)`};
`;

const ConnectedDevice = ({ data }) => (
  <Card>
    <h4>{data.name}</h4>
    <Bar pitch={data.pitch} roll={data.roll} />
  </Card>
);

export default ConnectedDevice;
