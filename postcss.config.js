module.exports = {
  plugins: [
    require('autoprefixer')(),
    require('postcss-nested')(),
    require('postcss-simple-vars')({
      variables: {
        $white: '#fff',
        $body: '#34495e',

        $primaryActive: '#1abc9c',
        $primaryHighlight: '#1dd5b1',
        $secondaryActive: '#f1c40f',

        $radiusRound: '50%',
        $radiusCurved: '6px',

        $trackTitleWidth: '70px',

        $step: '#9aafc4',
        $stepAlt: '#677c91',
        $stepShadow: 'rgba(0, 0, 0, .3)',

        $cursor: '#2980b9',

        $playbackControlsBackground: '#000B1D',

        $mobile: 'max-width: 699px',
        $desktop: 'min-width: 700px',
      },
    }),
  ],
};
