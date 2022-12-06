module.exports = {
    "moduleFileExtensions": [
        "js",
        "json",
        // *.vue ファイルを処理するように指示する
        "vue"
    ],
    "transform": {
        // vue3-jest で *.vue ファイルを処理する
        ".*\\.(vue)$": "@vue/vue3-jest",
        '^.+\\.js$'  : '<rootDir>/node_modules/babel-jest'
    },
    "collectCoverage": true,
    "coverageReporters": ["html", "text-summary"],
    "collectCoverageFrom": [
        "**/*.{js,vue}"
    ],
    "coverageDirectory": "coverage/_jest"
}