import styled, { css } from "styled-components";

export const Backdrop = styled.div`
  position: fixed;
  z-index: 2;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
`;

export const Container = styled.ul`
  ${({ theme, posX, posY }) => css`
    background-color: ${theme.colors.shape(0.8)};
    border: 3px solid ${theme.colors.shape()};
    width: fit-content;
    display: flex;
    flex-direction: column;
    gap: 1rem;
    position: fixed;
    z-index: 2;
    top: ${posY}px;
    left: calc(${posX}px + 0.5rem);
    list-style: none;
    padding: 1rem 1.1rem;
    border-radius: 5px;
  `}
`;

export const Option = styled.li`
  ${({ theme }) => css`
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: white;
    font-size: 0.78rem;
    transition: color 0.3s;

    & > svg {
      font-size: 0.8rem;
    }

    &:hover {
      color: ${theme.colors.text_secondary};
    }
  `}
`;
