// const { environment } = require("@rails/webpacker");

const merge = require("webpack-merge");
const { join, resolve } = require("path");

const WebpackDefaults = require("@morsedigital/webpack-defaults");
// // const CopyWebpackPlugin = require("copy-webpack-plugin");
const { entry, environment } = WebpackDefaults(true);

const MomentLocalesPlugin = require("moment-locales-webpack-plugin");

// const { getIfUtils, removeEmpty } = require("webpack-config-utils");

// const { ifProduction } = getIfUtils(process.env.NODE_ENV);

// environment.config.set("resolve.alias", {
//   moment: resolve("node_modules", "moment")
// });

// // Moment optimise
environment.plugins.prepend(
  "MomentLocales",
  new MomentLocalesPlugin({
    localesToKeep: ["en", "cy"]
  })
);

// const config = environment.toWebpackConfig();
// config.entry = entry;

module.exports = environment;
