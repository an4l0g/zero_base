import styled, { css } from "styled-components";

export const Velocimeter = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem;
    padding-right: 1rem;
    text-shadow: 1px 1px 1px ${theme.colors.dark()};
  `}
`;

export const Velocity = styled.div`
  ${({ theme }) => css`
    width: 100%;
    display: flex;
    justify-content: flex-end;
    align-items: flex-end;
    gap: 0.5rem;

    small {
      color: ${theme.colors.primary()};
    }

    span {
      font-size: 3rem;
      font-weight: 900;
      margin: 0;
      line-height: 2.4rem;
    }
  `}
`;

export const InfosVeh = styled.ul`
  width: 100%;
  display: flex;
  gap: 0.5rem;
  justify-content: flex-end;
  list-style: none;
  padding: 0;
`;

export const Info = styled.li`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-size: 1.2rem;
    width: 1.8rem;
    height: 1.8rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 3px;
    overflow: hidden;
    position: relative;
    background-color: ${theme.colors.dark(0.5)};

    & > svg {
      z-index: 1;
    }

    &.gear {
      padding: 0 0.2rem;
      display: flex;
      gap: 0.2rem;
      width: auto;

      & > svg {
        font-size: 1rem;
        color: ${theme.colors.primary()};
        flex: 1;
      }
    }
  `}
`;

export const StatusIndicator = styled.div`
  ${({ theme, height }) => css`
    background-color: ${theme.colors.primary(0.5)};
    position: absolute;
    bottom: 0;
    width: 100%;
    height: ${height}%;
    transition: height 0.5s;
  `}
`;
