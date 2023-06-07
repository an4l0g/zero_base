import styled, { css } from "styled-components";
import * as Slider from "@radix-ui/react-slider";

export const Container = styled.div`
  ${({ ruler }) => css`
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 1rem;

    ${ruler &&
    css`
      margin-bottom: 1rem;
    `}
  `}
`;

export const Label = styled.label`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    font-size: 0.7rem;
  `}
`;

export const Wrap = styled.div`
  display: flex;
  align-items: center;
  gap: 1rem;
`;

export const Display = styled.input`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.3)};
    min-width: 2rem;
    height: 2rem;
    color: ${theme.colors.shape()};
    border-radius: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 0;
    outline: none;
    text-align: center;

    &::-webkit-outer-spin-button,
    &::-webkit-inner-spin-button {
      -webkit-appearance: none;
      margin: 0;
    }

    /* Firefox */
    &[type="number"] {
      -moz-appearance: textfield;
    }
  `}
`;

export const FullSlider = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
`;

export const Root = styled(Slider.Root)`
  position: relative;
  display: flex;
  align-items: center;
  user-select: none;
  touch-action: none;
  min-width: 200px;
  width: 100%;
  height: 20px;
`;

export const Track = styled(Slider.Track)`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.5)};
    position: relative;
    flex-grow: 1;
    border-radius: 9999px;
    height: 6px;
  `}
`;

export const Range = styled(Slider.Range)`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape()};
    position: absolute;
    border-radius: 9999px;
    height: 100%;
  `}
`;

export const Thumb = styled(Slider.Thumb)`
  ${({ theme }) => css`
    display: block;
    width: 12px;
    height: 12px;
    background-color: ${theme.colors.primary()};
    box-shadow: 0 2px 10px ${theme.colors.dark(0.5)};
    outline: none;
    border-radius: 2px;
    cursor: pointer;
  `}
`;

export const Ruler = styled.div`
  width: 100%;
  height: 1px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
`;

export const Max = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    margin-top: 1rem;
    font-size: 0.7rem;
  `}
`;

export const Middle = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    margin-top: 1rem;
    font-size: 0.7rem;
  `}
`;

export const Min = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    margin-top: 1rem;
    font-size: 0.7rem;
  `}
`;
