const autoprefixer = require('autoprefixer');
const { purgeCSSPlugin } = require('@fullhuman/postcss-purgecss');
const postcssCssVariables = require('postcss-css-variables');

module.exports = {
    plugins: [
        purgeCSSPlugin({
            content: [
                './layouts/**/*.html',
                './content/home.*.md',
                './hugo_stats.json',
            ],
            defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || [],
            safelist: [],
        }),
        autoprefixer({}),
        postcssCssVariables({}),
    ]
};
