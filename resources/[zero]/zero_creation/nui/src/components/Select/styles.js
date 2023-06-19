import { css, styled } from "styled-components";

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

export const Select = styled.div`
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

    &:hover {
      background-color: ${theme.colors.dark(0.3)};
    }
  `}
`;

export const Placeholder = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    text-transform: uppercase;
    font-size: 0.7rem;

    & > svg {
      color: ${theme.colors.primary()};
    }
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

export const Options = styled.ul`
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
    flex-direction: column;
    gap: 0.5rem;
    max-height: 200px;
    overflow-x: hidden;
    overflow-y: auto;
    z-index: 2;
  `}
`;

export const Option = styled.li`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-size: 0.8rem;
    letter-spacing: 1;
    font-weight: 400;
    text-transform: uppercase;
    padding: 0 0.5rem;
    min-height: 40px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    border-radius: 3px;
    border-bottom: 1px solid ${theme.colors.shape(0.07)};

    &:last-child {
      border-bottom: none;
    }
  `}
`;

export const Input = styled.input`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.1)};
    width: 100%;
    min-height: 40px;
    border-radius: 3px;
    font-weight: 100;
    letter-spacing: 1px;
    border: 1px solid ${theme.colors.shape(0.05)};
    padding: 0 0.5rem;
    color: ${theme.colors.shape()};
    outline: none;

    &::placeholder {
      color: ${theme.colors.shape(0.5)};
    }
  `}
`;

export const Empty = styled.strong`
  ${({ theme }) => css`
    height: 4rem;
    display: flex;
    align-items: center;
    font-weight: 100;
    color: ${theme.colors.shape()};
    letter-spacing: 2px;
    text-transform: uppercase;
  `}
`;
