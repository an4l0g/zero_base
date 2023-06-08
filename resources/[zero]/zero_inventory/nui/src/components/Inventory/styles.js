import styled, { css } from "styled-components";

export const Container = styled.div`
  width: 1200px;
  height: 600px;
  display: flex;
  justify-content: center;
  gap: 50px;
  align-items: center;
`;

export const Bags = styled.div`
  display: flex;
  height: 100%;
  flex-direction: column;
  gap: 2rem;
`;

export const Head = styled.div`
  display: flex;
  gap: 10px;
  align-items: center;
`;

export const Line = styled.div`
  ${({ theme }) => css`
    background-image: linear-gradient(
      to right,
      transparent,
      rgba(255, 255, 255, 0.1),
      transparent
    );
    flex: 1;
    height: 2px;
  `}
`;

export const HeadTitle = styled.strong`
  ${({ theme }) => css`
    color: ${theme.colors.text_primary};
    font-size: 0.8rem;
    font-weight: 100;
    text-transform: uppercase;
  `}
`;

export const Kg = styled.div`
  ${({ theme }) => css`
    font-size: 0.8rem;
    color: ${theme.colors.text_primary};
    font-weight: 400;

    &.full {
      color: ${theme.colors.error()};
    }
  `}
`;
