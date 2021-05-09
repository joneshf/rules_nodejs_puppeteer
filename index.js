const puppeteerCore = require("puppeteer-core");

const html = `
<html>
    <head>
        <title>Index</title>
    </head>
    <body>
        <p>Hello, World!</p>
    </body>
</html>
`;

async function main() {
    const chromiumPath = process.argv[2];
    if (chromiumPath == null) {
        return Promise.reject("Path to `chromium` must be passed as the first argument");
    }

    const outputPath = process.argv[3];
    if (outputPath == null) {
        return Promise.reject("Path to output file must be passed as the second argument");
    }

    const browser = await puppeteerCore.launch({
        args: [
            "--no-sandbox",
        ],
        executablePath: chromiumPath,
    });
    const page = await browser.newPage();
    await page.emulateMediaType("print");
    await page.setContent(html);
    await page.pdf({
        path: outputPath,
    });
    await browser.close();
}

main().catch(function (error) {
    console.error(error);
    process.exit(1);
});
