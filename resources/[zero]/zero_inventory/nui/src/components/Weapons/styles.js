import styled from "styled-components";

export const Container = styled.div`
  display: flex;
  flex-direction: column;
  gap: 25px;
  position: relative;
`;

export const WrapItems = styled.div`
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  width: 190px;
  height: 550px;
  max-height: 550px;
  overflow-x: hidden;
  overflow-y: auto;
`;
