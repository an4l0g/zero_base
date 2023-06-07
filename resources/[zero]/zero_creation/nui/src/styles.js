import styled, { css, createGlobalStyle } from "styled-components";

export const theme = {
  colors: {
    shape: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
    dark: (opacity = 1) => `rgba(0, 0, 0, ${opacity})`,
    primary: (opacity = 1) => `rgba(0, 153, 255, ${opacity})`,
    dark_shape: (opacity = 1) => `rgba(22, 22, 22, ${opacity})`,
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
        /* background-image: url('https://images-ext-2.discordapp.net/external/PmgXOKK-Gx8CsgtU7ThcRzHHpybHunoV4x-x1SSFfug/https/i.imgur.com/pUqwKGV.jpg?width=1920&height=1080'); */
        background-attachment: fixed;
        background-repeat: no-repeat;
        background-size: cover;
        width: 100%;
        height: 100vh;
        margin: 0;
        padding: 0;
        position: relative;

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

export const WrapCreation = styled.section`
  width: 100%;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
`;
