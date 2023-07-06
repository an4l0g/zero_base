import styled, { css } from "styled-components";

export const Menu = styled.ul`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.2)};
    width: 12.5rem;
    display: flex;
    flex-direction: column;
    list-style: none;
    padding: 0.5rem;
    border-radius: 10px;
    box-shadow: 5px 5px 3px ${theme.colors.dark(0.1)};
  `}
`;

export const ItemMenu = styled.li`
  ${({ theme }) => css`
    height: 3.1rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0 0.5rem;
    border-bottom: 1px solid ${theme.colors.primary(0.1)};
    color: ${theme.colors.shape()};
    font-weight: 100;
    cursor: pointer;
    border-radius: 5px;

    &:hover,
    &.active {
      background-color: ${theme.colors.primary(0.1)};
    }

    & > svg {
      color: ${theme.colors.primary()};
    }

    &:last-child {
      border: 0;
    }
  `}
`;
