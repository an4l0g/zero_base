import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.2)};
    width: 20rem;
    padding: 1rem 0.5rem 0.5rem;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem;
    border: 2px solid ${theme.colors.dark(0.5)}
    transition: border-color 0.3s;
    box-shadow: 2px 2px 2px ${theme.colors.dark(0.1)};
    cursor: pointer;

    &:hover {
      background-color: ${theme.colors.primary(0.1)};
    }
  `}
`;

export const Image = styled.img`
  width: 100%;
  border-radius: 5px;
  object-fit: cover;
  object-position: center;
`;

export const Title = styled.strong`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    font-size: 1.25rem;
    letter-spacing: 1px;
  `}
`;
