import styled, { createGlobalStyle, css } from "styled-components";

export const theme = {
  colors: {
    shape: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
    dark: (opacity = 1) => `rgba(0, 0, 0, ${opacity})`,
    primary: (opacity = 1) => `rgba(0, 153, 255, ${opacity})`,
    accept: (opacity = 1) => `rgba(0, 204, 102, ${opacity})`,
    reject: (opacity = 1) => `rgba(255, 26, 26, ${opacity})`,
  },
  fonts: {
    family: {
      primary: "'Geologica', sans-serif",
    },
  },
};

export const GlobalStyle = createGlobalStyle`
    ${({ theme }) => css`
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        -webkit-font-smoothing: antialiased;
      }

      html {
        width: 100%;
      }

      body {
        width: 100%;
        height: 100vh;
        margin: 0;
        padding: 0;
        position: relative;
        background: ${theme.colors.dark()};
      }

      body,
      h1,
      h2,
      h3,
      h4,
      h5,
      h6,
      input,
      button,
      textarea {
        font-family: ${theme.fonts.family.primary};
      }

      strong {
        font-weight: normal;
        display: block;
        font-size: 0.8rem;
      }

      p {
        font-size: 0.8rem;
        margin-top: 0.6rem;
        font-weight: 100;
        color: ${theme.colors.shape(0.7)};
      }

      span.author {
        margin-top: 0.6rem;
        font-size: 0.7rem;
        color: ${theme.colors.primary()};
      }

      ::-webkit-scrollbar {
        width: 2px;
      }

      /* Track */
      ::-webkit-scrollbar-track {
        background: ${theme.colors.dark()};
      }

      /* Handle */
      ::-webkit-scrollbar-thumb {
        background: ${theme.colors.primary()};
      }

      /* Handle on hover */
      ::-webkit-scrollbar-thumb:hover {
        background: ${theme.colors.primary()};
      }
    `}
`;

export const Wrap = styled.div`
  position: relative;
  width: 100%;
  height: 100vh;
`;

export const Background = styled.div`
  background-image: url("https://media.discordapp.net/attachments/1059878373737893918/1140508131890299001/BACKGROUND_ZERO_2.png?width=1192&height=671");
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  width: 100%;
  height: 100vh;
  position: absolute;
  top: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
`;

export const Filter = styled.div`
  ${({ theme }) => css`
    width: 100%;
    height: 100vh;
    background-color: ${theme.colors.dark(0.5)};
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    position: absolute;
    gap: 5rem;
    top: 0;
    left: 0;
  `}
`;

export const Title = styled.h1`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    letter-spacing: 1px;
  `}
`;

export const List = styled.div`
  display: flex;
  gap: 2rem;
`;

export const ActionList = styled.div`
  display: flex;
  gap: 2rem;
`;

export const Logo = styled.img`
  width: 50rem;
  opacity: 0.1;
`;

export const Button = styled.button`
  ${({ theme }) => css`
    background-color: ${theme.colors.primary(0.05)};
    color: ${theme.colors.shape()};
    padding: 1rem 2rem;
    border-radius: 10px;
    border: 2px solid ${theme.colors.primary(0.3)};
    font-size: 1.2rem;
    transition: background-color 0.5s;
    cursor: pointer;

    &:hover {
      background-color: ${theme.colors.primary(0.3)};
    }
  `}
`;
