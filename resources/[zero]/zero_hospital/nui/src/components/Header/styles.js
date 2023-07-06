import styled, { css } from "styled-components";

export const Header = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.primary(0.05)};
    width: 100%;
    height: 4.6rem;
    border-radius: 5px 5px 0 0;
    box-shadow: 0px 3px 5px ${theme.colors.dark(0.3)};
    border-top: 3px solid ${theme.colors.primary()};
    padding: 0 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
  `}
`;

export const Title = styled.h1`
  ${({ theme }) => css`
    text-transform: uppercase;
    font-weight: 100;
    color: ${theme.colors.shape(0.8)};

    span {
      color: ${theme.colors.primary()};
    }
  `}
`;

export const Right = styled.div`
  display: flex;
  align-items: center;
  gap: 1rem;
`;
