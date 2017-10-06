module.exports = {
  plugins: [
    require('autoprefixer')(),
    require('postcss-nested')(),
    require('postcss-simple-vars')({
      variables: {
        $white: '#fff',

        $track: '#34495e',
        $trackEven: '#41566B',

        $step: '#677c91',
        $stepAlt: '#9aafc4',
        $stepActive: '#1abc9c',
        $stepShadow: 'rgba(0, 0, 0, .3)',

        $cursor: '#2980b9',
        $cursorActive: '#f1c40f',

        $playbackControlsBackground: '#000B1D',
      },
    }),
  ],
};
