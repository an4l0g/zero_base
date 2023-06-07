import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.05)};
    border: 1px solid ${theme.colors.shape(0.1)};
    width: 100%;
    padding: 1rem 1rem 0;
    border-radius: 5px;
    position: relative;
    min-height: 11rem;
    display: flex;
    justify-content: space-around;
    align-items: flex-end;
    overflow: hidden;
  `}
`;

export const Parent1 = styled.img`
  ${({ theme }) => css`
    position: absolute;
    height: 10rem;
    margin-left: -7rem;
    filter: drop-shadow(5px 5px 5px ${theme.colors.dark(0.5)});
  `}
`;

export const Parent2 = styled.img`
  ${({ theme }) => css`
    position: absolute;
    margin-right: -7rem;
    height: 10rem;
    filter: drop-shadow(5px 5px 5px ${theme.colors.dark(0.5)});
  `}
`;
