import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ space }) => css`
    display: flex;
    align-items: center;
    gap: 1rem;

    ${space &&
    css`
      margin: 2rem 0;
    `}
  `}
`;

export const WrapIcon = styled.div`
  ${({ theme }) => css`
    display: flex;
    justify-content: center;
    align-items: center;
    width: 3rem;
    height: 3rem;
    border: 2px solid ${theme.colors.primary()};
    border-radius: 50%;
    font-size: 1.5rem;
    color: ${theme.colors.shape()};
  `}
`;

export const Title = styled.h2`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    font-weight: 700;
    letter-spacing: 2px;
  `}
`;
