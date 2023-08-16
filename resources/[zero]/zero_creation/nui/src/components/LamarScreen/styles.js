import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.95)};
    width: 100%;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
  `}
`;

export const Logo = styled.img`
  width: 50rem;
  height: auto;
  opacity: 0.05;
`;

export const Content = styled.div`
  ${({ theme }) => css`
    background-image: radial-gradient(
      ${theme.colors.primary(0.05)},
      ${theme.colors.dark(0.1)}
    );
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 3rem;
  `}
`;

export const Title = styled.h1`
  ${({ theme }) => css`
    max-width: 80%;
    font-size: 1.7rem;
    line-height: 5rem;
    font-weight: normal;
    text-align: center;
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    letter-spacing: 1px;

    & > b {
      color: ${theme.colors.primary()};
    }
  `}
`;

export const Description = styled.h2`
  ${({ theme }) => css`
    max-width: 60%;
    font-size: 1.2rem;
    line-height: 3rem;
    font-weight: normal;
    text-align: center;
    color: ${theme.colors.shape(0.85)};
    text-transform: uppercase;
    letter-spacing: 1px;
  `}
`;

export const Button = styled.button`
  ${({ theme }) => css`
    font-size: 1.5rem;
    padding: 0.7rem 2rem;
    color: ${theme.colors.shape()};
    background-color: ${theme.colors.shape(0.02)};
    border-radius: 5px;
    border: 2px solid ${theme.colors.primary()};
    transition: all 0.5s;
    cursor: hover;

    &:hover {
      background-color: ${theme.colors.primary()};
      color: ${theme.colors.dark()};
    }
  `}
`;
