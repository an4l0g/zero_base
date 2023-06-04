import styled, { css } from "styled-components";

export const Wrap = styled.div`
  ${({ theme }) => css`
    background-image: linear-gradient(
      to right,
      transparent,
      ${theme.colors.dark(0.7)}
    );
    padding: 1rem;
    display: flex;
    gap: 10px;
    align-items: center;
  `}
`;

export const Status = styled.div`
  ${({ theme }) => css`
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    overflow: hidden;
    border: 3px solid ${theme.colors.primary(0)};
    outline: 1px solid ${theme.colors.primary()};
    padding: 3px;
    /* border-radius: 50%; */
    border-radius: 2px;
    /* clip-path: polygon(50% 0, 100% 50%, 50% 100%, 0% 50%); */
    background-color: ${theme.colors.dark(0.3)};
    min-width: 2.2rem;
    height: 2.2rem;

    & svg {
      font-size: 1rem;
      z-index: 1;
      color: ${theme.colors.shape()};
    }
  `}
`;

export const StatusNumberWrap = styled.div`
  width: 100%;
  display: flex;
  align-items: center;
  gap: 0.2rem;
  color: white;
  z-index: 1;
  font-size: 0.7rem;
  font-weight: 100;
`;

export const StatusIndicator = styled.div`
  ${({ theme, height }) => css`
    background-color: ${theme.colors.primary(0.3)};
    width: 100%;
    height: ${height}%;
    bottom: 0;
    border-radius: 2px;
    position: absolute;
    transition: height 0.5s;
  `}
`;
