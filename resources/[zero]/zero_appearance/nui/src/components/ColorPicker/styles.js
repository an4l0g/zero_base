import styled, { css } from "styled-components";

export const Container = styled.div`
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
`;

export const Label = styled.label`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    font-size: 0.7rem;
  `}
`;

export const Picker = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.5)};
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 40px;
    position: relative;
    border-radius: 3px;
    cursor: pointer;
    padding: 0.3rem;

    &:hover {
      background-color: ${theme.colors.dark(0.3)};
    }
  `}
`;

export const Placeholder = styled.div`
  ${({ theme, bgColor }) => css`
    background-color: ${bgColor};
    color: ${theme.colors.shape()};
    width: 100%;
    height: 100%;
    border-radius: 3px;
  `}
`;

export const Backdrop = styled.div`
  width: 100%;
  height: 100vh;
  position: fixed;
  top: 0;
  left: 0;
  z-index: 1;
`;

export const Colors = styled.ul`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.98)};
    width: 100%;
    padding: 0;
    padding: 1rem;
    position: absolute;
    top: 45px;
    border-radius: 3px;
    list-style: none;
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 0.4rem;
    max-height: 200px;
    overflow-x: hidden;
    overflow-y: auto;
    z-index: 2;
  `}
`;

export const Option = styled.div`
  ${({ bgColor }) => css`
    background-color: ${bgColor};
    width: 2rem;
    height: 2rem;
  `}
`;
