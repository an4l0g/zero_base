import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    background-image: linear-gradient(
      to right,
      ${theme.colors.dark(0.9)},
      ${theme.colors.dark(0.5)},
      ${theme.colors.dark(0)}
    );
    padding: 2rem;
    position: absolute;
    left: 0;
    width: 50%;
    display: flex;
    flex-direction: column;
    height: 100vh;
    gap: 5rem;
  `}
`;

export const Header = styled.div`
  display: flex;
  gap: 2rem;
  width: 100%;
  justify-content: center;
  align-items: center;
`;

export const Title = styled.h1`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    padding-top: 1rem;
    padding-left: 1rem;
    position: relative;
    width: 70%;
    height: 125px;

    & > span {
      position: absolute;
      font-size: 2.8rem;
      font-weight: 700;
      letter-spacing: 2px;
      text-shadow: 1px 1px ${theme.colors.dark(0.5)};
    }

    &::before {
      position: absolute;
      content: "";
      clip-path: polygon(20% 0, 100% 0, 80% 100%, 0 100%);
      background-color: ${theme.colors.primary(0.8)};
      width: 100%;
      height: 5.5rem;
    }
  `}
`;

export const Description = styled.p`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-size: 1.2rem;
  `}
`;

export const Tabs = styled.div`
  width: 60%;
  flex: 1;
  display: flex;
  align-items: flex-start;
  gap: 2rem;
`;

export const TabsList = styled.ul`
  list-style: none;
  padding: 0;
  width: 5rem;
  height: 100%;
  gap: 1.5rem;
  display: flex;
  align-items: flex-start;
  flex-direction: column;
`;

export const TabButton = styled.li`
  ${({ theme, active }) => css`
    background-color: ${theme.colors.dark(0.2)};
    width: 5rem;
    height: 5rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: ${theme.colors.shape()};
    border-radius: 2px;
    border: 2px solid ${theme.colors.primary(0)};
    outline: 2px solid ${theme.colors.primary(1)};
    gap: 0.2rem;
    transition: all 0.5s;
    cursor: pointer;

    & > svg {
      font-size: 1.5rem;
      color: ${theme.colors.primary()};
    }

    & > span {
      text-transform: uppercase;
      font-size: 0.6rem;
    }

    &:hover {
      background-color: ${theme.colors.shape(0.05)};
    }

    ${active &&
    css`
      background-color: ${theme.colors.shape(0.05)};
    `}

    &.finish {
      background-color: ${theme.colors.primary()};

      & > svg {
        color: ${theme.colors.shape()};
      }
    }
  `}
`;
