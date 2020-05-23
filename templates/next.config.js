const isProd = process.env.NODE_ENV === 'production';

const deployedUrl = 'https://andrewray.me';

module.exports = {
  // For nextjs
  assetPrefix: isProd ? deployedUrl : '',
  // For programatic code
  env: {
    assetPrefix: isProd ? deployedUrl : '',
    site: deployedUrl,
  },
};
