module.exports = {
  publicPath: "/",
  configureWebpack: (config) => {
    config.module.rules.push({
      test: /\.(txt|md)$/i,
      use: [
        {
          loader: "raw-loader",
        },
      ],
    });
  },
  productionSourceMap: false,
  css: {
    sourceMap: false,
  },
};
