import styled, { css } from "styled-components";

export const Container = styled.div`
  position: absolute;
  bottom: 1rem;
  right: 1rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
`;

export const Buttons = styled.div`
  display: flex;
  gap: 1rem;
`;

export const Button = styled.button`
  ${({ theme, active }) => css`
    background-color: ${theme.colors.dark(0.5)};
    width: 2.8rem;
    height: 2.8rem;
    border: 0;
    font-size: 1.4rem;
    display: flex;
    border-radius: 50%;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    box-shadow: ${theme.colors.dark(0.5)} 0px 20px 30px -10px;
    transition: background-color 0.5s;

    ${active &&
    css`
      background-color: ${theme.colors.primary()};
    `}

    & > svg {
      color: ${theme.colors.shape()};
      text-shadow: 1px 1px ${theme.colors.dark(0.5)};
    }

    &:hover {
      background-color: ${theme.colors.primary()};
    }
  `}
`;
