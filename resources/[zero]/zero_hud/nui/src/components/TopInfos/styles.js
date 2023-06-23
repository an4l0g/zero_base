import styled, { css } from "styled-components";

export const Wrap = styled.ul`
  position: absolute;
  display: flex;
  flex-wrap: wrap;
  top: 1rem;
  right: 25px;
  list-style: none;
  gap: 1rem;
`;

export const Info = styled.li`
  ${({ theme, talking }) => css`
    background-image: linear-gradient(
      to left,
      ${theme.colors.dark(0.3)},
      transparent
    );
    padding: 0 1rem;
    color: ${theme.colors.shape()};
    height: 30px;
    display: flex;
    font-weight: 100;
    gap: 0.6rem;
    align-items: center;
    border-radius: 10px;
    font-size: 0.9rem;

    ${talking &&
    css`
      color: ${theme.colors.primary()};
    `}

    & > svg {
      color: ${theme.colors.primary()};
    }
  `}
`;
