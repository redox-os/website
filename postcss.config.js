import autoprefixer from 'autoprefixer';
import { purgeCSSPlugin } from '@fullhuman/postcss-purgecss';
import postcssCssVariables from 'postcss-css-variables';

export default {
    plugins: [
        purgeCSSPlugin({
            content: [
                './layouts/**/*.html',
                './content/home.*.md',
            ],
            defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || [],
            safelist: [],
        }),
        autoprefixer({}),
        postcssCssVariables({}),
    ]
};
