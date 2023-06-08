import styled, { css, keyframes } from "styled-components";

export const Container = styled.div`
  position: relative;
  width: 75px;
  height: 75px;
  user-select: none;
`;

export const Slot = styled.div`
  width: 100%;
  height: 100%;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 5px;
  display: flex;
  justify-content: center;
  align-items: center;
  color: rgba(255, 255, 255, 0.1);
  font-size: 32px;
  transition: background-color 0.5s;

  &:hover {
    background-color: rgba(255, 255, 255, 0.5);
  }
`;

export const ContentItem = styled.div`
  ${({ isPreview }) => css`
    border-radius: 5px;
    width: 75px;
    height: 75px;
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    font-weight: 100;
    text-transform: uppercase;

    &:hover > .onHoverAppears {
      opacity: 1;
    }

    ${isPreview &&
    css`
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 5px;
    `};
  `}
`;

export const ItemImage = styled.img`
  width: 40px;
  height: 40px;
`;

export const ItemWeight = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.text_primary};
    font-size: 0.55rem;
    position: absolute;
    top: 2px;
    right: 2px;
  `}
`;

export const ItemAmount = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.text_primary};
    position: absolute;
    font-size: 0.55rem;
    left: 3px;
    top: 3px;
  `}
`;

export const ItemName = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.text_primary};
    position: absolute;
    font-size: 0.55rem;
    bottom: 2px;
  `}
`;

export const BtnUnequip = styled.button`
  ${({ theme }) => css`
    background-color: rgba(0, 0, 0, 0.8);
    z-index: 1;
    color: ${theme.colors.error(0.5)};
    border: 0;
    width: calc(100% - 2px);
    height: calc(100% - 2px);
    display: flex;
    border-radius: 5px;
    justify-content: center;
    align-items: center;
    position: absolute;
    font-size: 2rem;
    border: 2px solid ${theme.colors.shape()};
    opacity: 0;
    transition: opacity 0.5s;
    cursor: pointer;
  `}
`;

const rotate = keyframes`
  from {
    transform: rotate(0deg)
  }
  to {
    transform: rotate(360deg)
  }
`;

export const Loading = styled.div`
  ${({ theme }) => css`
    background-color: rgba(0, 0, 0, 0.8);
    z-index: 1;
    color: ${theme.colors.error(0.5)};
    border: 0;
    width: calc(100% - 2px);
    height: calc(100% - 2px);
    display: flex;
    border-radius: 5px;
    justify-content: center;
    align-items: center;
    position: absolute;
    font-size: 1.5rem;
    border: 2px solid ${theme.colors.shape()};

    & > svg {
      animation: ${rotate} 0.5s infinite ease-in;
    }
  `}
`;
