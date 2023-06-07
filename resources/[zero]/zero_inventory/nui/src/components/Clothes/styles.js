import styled, { css } from "styled-components";

export const Container = styled.div`
  width: 290px;
  min-width: 290px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 25px;
  position: relative;
`;

export const FloatItem = styled.div`
  ${({ top, left, right }) => css`
    position: absolute;
    ${top &&
    css`
      top: ${top}px;
    `};
    ${left &&
    css`
      left: ${left}px;
    `};
    ${right &&
    css`
      right: ${right}px;
    `};
  `}
`;
