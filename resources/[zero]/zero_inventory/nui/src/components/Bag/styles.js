import styled from "styled-components";

export const Container = styled.div`
  display: flex;
  flex-direction: column;
  gap: 25px;
`;

export const WrapItems = styled.div`
  display: flex;
  flex-wrap: wrap;
  align-items: flex-start;
  gap: 20px;
  width: 380px;
  overflow-x: hidden;
  overflow-y: auto;

  &.player {
    height: 550px;
    max-height: 550px;
  }

  &.chest,
  &.bag,
  &.ground,
  &.trunk,
  &.glovebox {
    max-height: 550px;
    height: 550px;
  }
`;
