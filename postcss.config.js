module.exports = {
  plugins: [
    require('autoprefixer')(),
    require('postcss-nested')(),
    require('postcss-simple-vars')({
      variables: {
        $blue: '#0098DB',
      },
    }),
  ],
};
