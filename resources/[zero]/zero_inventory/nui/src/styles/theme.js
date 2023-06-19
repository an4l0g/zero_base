const theme = {
  colors: {
    primary: (opacity = 1) => `rgba(0, 153, 255, ${opacity})`,
    secondary: (opacity = 1) => `rgba(0, 0, 0, ${opacity})`,
    error: (opacity = 1) => `rgba(204, 51, 0, ${opacity})`,
    shape: (opacity = 1) => `rgba(20, 20, 20, ${opacity})`,
    text_primary: "#fff",
    text_secondary: "gray",
  },
};

export default theme;
