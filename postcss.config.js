module.exports = {
  plugins: {
    autoprefixer: {
      overrideBrowserslist: [
        'Android 4.1',
        'iOS 7.1',
        'Chrome > 31',
        'ff > 31',
        'ie >= 8',
        'last 10 versions' // 所有主流浏览器最近10版本用
      ],
      grid: true
    },
    'postcss-pxtorem': {
      rootValue: 37.5, // 页面字体大小
      propList: ['*', '!border'], // 除 border 外所有px 转 rem
      selectorBlackList: ['.van'], // 过滤掉.am-开头的class，不进行rem转换
      unitPrecision: 5
    }
  }
}
