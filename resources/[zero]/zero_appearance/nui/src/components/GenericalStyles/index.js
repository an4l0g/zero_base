import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    background-image: linear-gradient(
      to bottom right,
      ${theme.colors.primary(0.3)},
      ${theme.colors.dark(0.3)}
    );
    background-color: ${theme.colors.dark(0.95)};
    width: 575px;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
  `}
`;

export const FloatLogo = styled.img`
  position: absolute;
  opacity: 0.1;
  width: 300px;
  height: 104px;
`;

export const Content = styled.div`
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  padding: 1rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  padding: 5rem 1rem;
  gap: 0rem;
`;

export const Header = styled.div`
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

export const HeaderDivider = styled.div`
  ${({ theme, position }) => css`
    display: flex;
    ${css`
      justify-content: ${position};
    `}
    width: 100%;
    flex: 1;
  `}
`;

export const Logo = styled.img`
  height: 35px;
`;

export const Title = styled.h1`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    font-weight: 400;
    font-size: 1rem;
    margin: 0;
    letter-spacing: 2px;
    display: flex;
    align-items: center;
    gap: 0.5rem;
  `}
`;

export const WrapIcon = styled.div`
  ${({ theme }) => css`
    width: 35px;
    height: 35px;
    border-radius: 50%;
    border: 1px solid ${theme.colors.primary(0.5)};
    color: ${theme.colors.shape()};
    display: flex;
    justify-content: center;
    align-items: center;

    & > svg {
      font-size: 1.1rem;
      width: 100%;
      margin: 0;
    }
  `}
`;

export const WrapBrokenImage = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    display: flex;
    justify-content: center;
    align-items: center;

    & > svg {
      font-size: 2.5rem;
      width: 100%;
      margin: 0;
    }
  `}
`;

export const ItemWrapIcon = styled.div`
  ${({ theme }) => css`
    min-width: 1.7rem;
    padding: 0.1rem;
    height: 1.7rem;
    border-radius: 5px;
    border: 1px solid ${theme.colors.primary(0.5)};
    color: ${theme.colors.shape()};
    display: flex;
    justify-content: center;
    background-color: ${theme.colors.dark(0.5)};
    align-items: center;
    position: absolute;
    top: 5px;
    right: 5px;
    font-size: 0.8rem;
  `}
`;

export const ItemWrapMoney = styled.div`
  ${({ theme }) => css`
    height: 1.7rem;
    border-radius: 5px;
    border: 1px solid ${theme.colors.primary(0.5)};
    color: ${theme.colors.shape()};
    display: flex;
    justify-content: center;
    background-color: ${theme.colors.dark(0.5)};
    align-items: center;
    position: absolute;
    font-size: 0.7rem;
    padding: 0 0.2rem;
    left: 7px;
    top: 7px;
  `}
`;

export const PovButton = styled.button`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.3)};
    border: 1px solid ${theme.colors.primary(0.5)};
    border-radius: 5px;
    width: 40px;
    height: 40px;
    font-size: 1.5rem;
    color: ${theme.colors.shape()};
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
  `}
`;

export const Shop = styled.div`
  display: flex;
  width: 100%;
  justify-content: space-between;
  align-items: space-between;
  gap: 0rem;
  height: calc(100% - 150px - 1rem);
`;

export const TypeList = styled.ul`
  display: flex;
  flex-direction: column;
  list-style: none;
  margin: 0;
  padding: 0;
  padding-left: 0.5rem;
  overflow-y: auto;
  overflow-x: hidden;
  direction: rtl;
  gap: 0.5rem;
`;

export const TypeItem = styled.li`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.5)};
    width: 75px;
    min-height: 75px;
    height: 50px;
    border-radius: 5px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    transition: background-color 0.5s;

    &.active {
      background-color: ${theme.colors.shape(0.1)};
    }

    &:hover {
      background-color: ${theme.colors.shape(0.1)};
    }
  `}
`;

export const TypeImage = styled.img`
  width: 32px;
  height: 32px;
`;

export const TypeTitle = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-size: 0.6rem;
  `}
`;

export const RightWrap = styled.div`
  display: flex;
  flex-direction: column;
  flex: 1;
  gap: 0.5rem;
`;

export const OptionsListWrap = styled.div`
  width: 100%;
  flex: 1;
  height: calc(100% - 150px - 1rem);
`;

export const OptionsList = styled.ul`
  list-style: none;
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  flex-wrap: wrap;
  max-height: 100%;
  overflow-x: hidden;
  overflow-y: auto;
`;

export const OptionItem = styled.li`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.3)};
    border: 1px solid ${theme.colors.primary(0.2)};
    width: 125px;
    height: 125px;
    border-radius: 5px;
    overflow: hidden;
    padding: 5px;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;

    &.active {
      background-color: ${theme.colors.primary(0.3)};
      border: 1px solid ${theme.colors.primary()};
    }

    &:hover {
      background-color: ${theme.colors.primary(0.1)};
    }
  `}
`;

export const OptionImage = styled.img`
  width: 100%;
  height: 100%;
  border-radius: 3px;
`;

export const Actions = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 0.5rem;
  width: 100%;
  height: 75px;
`;

export const WrapAction = styled.div`
  display: flex;
  gap: 0.5rem;
`;

export const CustomButton = styled.button`
  ${({ theme, customization }) => css`
    background-color: ${theme.colors.dark(0.2)};
    color: ${theme.colors.shape()};
    border: 1px solid ${theme.colors.primary(0.1)};
    width: 50px;
    height: 50px;
    padding: 0 0.5rem;
    display: flex;
    gap: 0.5rem;
    justify-content: center;
    align-items: center;
    border-radius: 5px;
    transition: background-color 0.5s;
    cursor: pointer;

    &:hover {
      background-color: ${theme.colors.dark(0.3)};
    }

    & > svg {
      font-size: 1.5rem;
      color: ${theme.colors.primary()};
      transition: color 0.5s;
    }

    ${customization &&
    css`
      background-color: ${theme.colors.primary()};

      &:hover {
        background-color: ${theme.colors.primary(0.8)};
      }

      & > svg {
        color: ${theme.colors.shape()};
      }
    `}
  `}
`;

export const BtnAction = styled.button`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.2)};
    color: ${theme.colors.shape()};
    border: 1px solid ${theme.colors.primary(0.1)};
    height: 50px;
    padding: 0 1rem;
    display: flex;
    gap: 0.5rem;
    align-items: center;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.5s;

    &:hover {
      background-color: ${theme.colors.primary(0.1)};
    }

    & > svg {
      font-size: 1.2rem;
      color: ${theme.colors.primary()};
    }
  `}
`;

export const Customization = styled.div`
  ${({ theme }) => css`
    display: flex;
    flex-direction: column;
    gap: 1rem;
    background-color: ${theme.colors.dark(0.5)};
    background-image: linear-gradient(
      to bottom right,
      ${theme.colors.primary(0.5)},
      ${theme.colors.dark(0.5)}
    );
    width: 300px;
    padding: 1rem;
    border-radius: 10px;
  `}
`;

export const ItemTitle = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    text-transform: uppercase;
  `}
`;
