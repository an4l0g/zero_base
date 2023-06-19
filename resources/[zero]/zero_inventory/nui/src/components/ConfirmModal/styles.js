import styled, { css } from "styled-components";

export const Wrap = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 3;
`;

export const Backdrop = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.5)};
    position: absolute;
    z-index: 3;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
  `}
`;

export const Container = styled.form`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.8)};
    border: 3px solid ${theme.colors.shape()};
    position: absolute;
    z-index: 4;
    width: 200px;
    border-radius: 5px;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 1rem;
    gap: 1rem;
  `}
`;

export const Title = styled.strong`
  ${({ theme }) => css`
    font-size: 0.8rem;
    color: ${theme.colors.text_primary};
  `}
`;

export const InputAmount = styled.input`
  ${({ theme }) => css`
    background-color: rgba(255, 255, 255, 0.05);
    color: ${theme.colors.text_primary};
    width: 100%;
    height: 30px;
    border: 0;
    border-radius: 5px;
    outline: none;
    padding: 0 0.5rem;
  `}
`;

export const BtnConfirm = styled.button`
  ${({ theme }) => css`
    background-color: transparent;
    border: 0;
    color: ${theme.colors.text_primary};
    transition: color 0.2s;
    cursor: pointer;

    &:disabled {
      color: ${theme.colors.text_secondary};
      cursor: not-allowed;
    }

    &:hover {
      color: ${theme.colors.text_secondary};
    }
  `}
`;
