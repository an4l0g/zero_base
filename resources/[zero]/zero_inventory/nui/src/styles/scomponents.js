import styled, { css } from "styled-components";

export const Page = styled.section`
  ${({ theme }) => css`
    background-color: rgba(0, 0, 0, 0.8);
    width: 100vw;
    height: 100vh;
    position: relative;
    transition: background-color 0.5s;
  `}
`;

export const BgImage = styled.div`
  opacity: 0.1;
  width: 100%;
  height: 100%;
  position: absolute;
`;

export const Filter = styled.div`
  ${({ theme }) => css`
    background-image: linear-gradient(
      to bottom right,
      ${theme.colors.primary(0.2)},
      ${theme.colors.secondary(0.5)}
    );
    width: 100%;
    height: 100%;
    position: absolute;
    display: flex;
    justify-content: center;
    align-items: center;
  `}
`;

export const HeadInventory = styled.div`
  position: absolute;
  top: 50px;
  left: 50px;
  display: flex;
  flex-direction: column;
  gap: 20px;
`;

export const HeadInventoryTitle = styled.h1`
  ${({ theme }) => css`
    text-transform: uppercase;
    letter-spacing: 2px;
    font-weight: 900;
    font-size: 2rem;
    color: ${theme.colors.text_primary};
  `}
`;

export const HeadInventoryDescription = styled.p`
  ${({ theme }) => css`
    color: ${theme.colors.text_secondary};
    font-size: 0.8rem;
    text-transform: uppercase;
  `}
`;

export const Key = styled.span`
  ${({ theme }) => css`
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 5px;
    color: ${theme.colors.text_primary};
    padding: 5px;
    font-size: 0.7rem;

    & > svg {
      font-size: 1.2rem;
    }
  `}
`;
