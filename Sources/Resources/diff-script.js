const fs = require('fs');
const path = require('path');
const diff = require('diff');

/**
 * Reads file content from the given path.
 * @param {string} filePath - The path to the file.
 * @returns {Promise<string>} - Promise resolving to file contents.
 */
function readFileContent(filePath) {
    return new Promise((resolve, reject) => {
        fs.readFile(path.resolve(filePath), 'utf8', (err, data) => {
            if (err) reject(`Error reading file at ${filePath}: ${err.message}`);
            else resolve(data);
        });
    });
}

/**
 * Generates a Markdown-formatted diff for file comparison.
 * @param {string} file1Content - Content of the first file.
 * @param {string} file2Content - Content of the second file.
 * @returns {string} - Full Markdown-formatted diff.
 */
function generateFullMarkdownDiff(file1Content, file2Content) {
    const diffResult = diff.diffLines(file1Content, file2Content);
    let markdownDiff = '';

    diffResult.forEach(part => {
        if (part.added) {
            markdownDiff += `+ ${part.value}`;
        } else if (part.removed) {
            markdownDiff += `- ${part.value}`;
        } else {
            markdownDiff += `  ${part.value}`; // Unchanged content
        }
    });

    return markdownDiff.trim();
}

/**
 * Logs only the additions, updates, and removals from the diff.
 * @param {string} file1Content - Content of the first file.
 * @param {string} file2Content - Content of the second file.
 */
function logChanges(file1Content, file2Content) {
    const diffResult = diff.diffLines(file1Content, file2Content);

    diffResult.forEach(part => {
        if (part.added) {
            console.log(`\x1b[32m+ ${part.value.trim()}\x1b[0m`); // Green for additions
        } else if (part.removed) {
            console.log(`\x1b[31m- ${part.value.trim()}\x1b[0m`); // Red for removals
        }
    });
}

/**
 * Computes the diff, logs changes, and writes the full diff to the output file.
 * @param {string} file1Path - Path to the first file.
 * @param {string} file2Path - Path to the second file.
 * @param {string} outputFilePath - Path to the output file.
 */
async function computeAndWriteMarkdownDiff(file1Path, file2Path, outputFilePath) {
    try {
        const [file1Content, file2Content] = await Promise.all([
            readFileContent(file1Path),
            readFileContent(file2Path),
        ]);

        const fullMarkdownDiff = generateFullMarkdownDiff(file1Content, file2Content);

        // Check if files are identical
        if (!fullMarkdownDiff.trim()) {
            console.log("No differences found.");
            return;
        }

        // Write the full diff to the output file
        fs.writeFileSync(path.resolve(outputFilePath), fullMarkdownDiff, 'utf8');

        // Log only the changes (additions/removals)
        logChanges(file1Content, file2Content);

    } catch (err) {
        console.error(err);
    }
}

/**
 * Entry point for the script.
 */
function main() {
    const [,, file1, file2, outputFile] = process.argv;

    if (!file1 || !file2 || !outputFile) {
        console.error('Usage: node diff-to-markdown.js <file1> <file2> <outputFile>');
        process.exit(1);
    }

    computeAndWriteMarkdownDiff(file1, file2, outputFile);
}

main();
