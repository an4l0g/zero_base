import styled, { createGlobalStyle, css } from "styled-components";

export const theme = {
  colors: {
    shape: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
    dark: (opacity = 1) => `rgba(0, 0, 0, ${opacity})`,
    primary: (opacity = 1) => `rgba(0, 153, 255, ${opacity})`,
    health: (opacity = 1) => `rgba(230, 0, 0, ${opacity})`,
    thirst: (opacity = 1) => `rgba(230, 0, 0, ${opacity})`,
    hunger: (opacity = 1) => `rgba(230, 92, 0, ${opacity})`,
    armor: (opacity = 1) => `rgba(102, 0, 255, ${opacity})`,
    oxygen: (opacity = 1) => `rgba(51, 204, 51, ${opacity})`,
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

      .Toastify__toast-container--top-right {
        top: 5rem;
      }
      .Toastify__toast-container--top-center {
        top: 5rem;
      }

      .Toastify__toast-theme--dark {
        font-family: ${theme.fonts.family.primary};
        display: flex;
        flex-direction: column;
        gap: 0.8rem;
        background-image: linear-gradient(
          to bottom right,
          ${theme.colors.dark(0.1)} 30%,
          ${theme.colors.primary(0.2)}
        );

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
      }

      :root {
        --toastify-color-dark: ${theme.colors.dark(0.7)};
        --toastify-color-progress-dark: ${theme.colors.primary()};
        --Toastify__toast-container--top-right
      }

      .Toastify__close-button {
        display: none;
      }
    `}
`;

export const WrapHud = styled.section`
  display: flex;
  justify-content: center;
  height: 100vh;
  position: relative;
`;

export const BottomRight = styled.div`
  position: absolute;
  bottom: 0;
  right: 0;
  display: flex;
  gap: 1rem;
  flex-direction: column;
  align-items: flex-end;
`;

export const ContainerNotify = styled.div`
  ${({ theme }) => css`
    width: 100%;
    display: flex;
    align-items: center;
    gap: 1rem;

    & > svg {
      font-size: 2rem;
      color: ${theme.colors.primary(0.5)};
    }
  `}
`;

export const ContentNotify = styled.div`
  flex: 1;
  display: flex;
  flex-direction: column;

  gap: 0.2rem;
`;

export const RequestActions = styled.div`
  ${({ theme }) => css`
    width: 100%;
    display: flex;
    align-items: center;
    margin-top: 0.5rem;
    gap: 0.5rem;

    & > span {
      font-size: 0.7rem;
      color: ${theme.colors.shape(0.7)};

      & > b {
        color: ${theme.colors.primary()};
      }
    }
  `}
`;
