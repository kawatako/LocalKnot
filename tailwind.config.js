// tailwind.config.js (プロジェクトルート)
module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        'primary': '#009688',     // メインカラー (青緑)
        'primary-focus': '#00796B', // メインカラー (ホバー時など)
        'primary-content': '#FFFFFF', // メインカラー上のコンテンツ (テキストなど) の色

        'secondary': '#80CBC4',   // アクセントカラー
        'secondary-focus': '#4DB6AC',
        'secondary-content': '#FFFFFF',

        'accent': '#FFC107',      // アクセントカラー
        'accent-focus': '#FFA000',
        'accent-content': '#FFFFFF',

        'neutral': '#3D4451',    // ベースカラー (ニュートラル)
        'neutral-focus': '#2A2E37',
        'neutral-content': '#FFFFFF',

        'base-100': '#FFFFFF',   // 最も明るいベースカラー (背景など)
        'base-200': '#F5F5F5',   // 2番目に明るいベースカラー
        'base-300': '#E0E0E0',   // 3番目に明るいベースカラー
        'base-content': '#1F2937', // ベースカラー上のコンテンツ (テキストなど) の色

        'info': '#2196F3',
        'success': '#4CAF50',
        'warning': '#FFEB3B',
        'error': '#F44336',
      },
    },
  },
  plugins: [require("daisyui")],

  // daisyUI config (optional - here are the default values)
  daisyui: {
    themes: [
      {
        mytheme: {
          'primary': '#009688',
          'primary-focus': '#00796B',
          'primary-content': '#FFFFFF',

          'secondary': '#80CBC4',
          'secondary-focus': '#4DB6AC',
          'secondary-content': '#FFFFFF',

          'accent': '#FFC107',
          'accent-focus': '#FFA000',
          'accent-content': '#FFFFFF',

          'neutral': '#3D4451',
          'neutral-focus': '#2A2E37',
          'neutral-content': '#FFFFFF',

          'base-100': '#FFFFFF',
          'base-200': '#F5F5F5',
          'base-300': '#E0E0E0',
          'base-content': '#1F2937',

          'info': '#2196F3',
          'success': '#4CAF50',
          'warning': '#FFEB3B',
          'error': '#F44336',
        },
      },
    ], // false: only light + dark | true: all themes | array: specific themes like this ["light", "dark", "cupcake"]
    darkTheme: "dark", // name of one of the included themes for dark mode
    base: true, // applies background color and foreground color for root element by default
    styled: true, // include daisyUI colors and design decisions for all components
    utils: true, // adds responsive and modifier utility classes
    prefix: "", // prefix for daisyUI classnames (components, modifiers and responsive class names. Not colors)
    logs: true, // Shows info about daisyUI version and used config in the console when building your CSS
  },
}