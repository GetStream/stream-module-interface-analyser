// diff-to-markdown.js

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
 * Generates a Markdown diff between two files, showing only changes.
 * @param {string} file1Content - Content of the first file.
 * @param {string} file2Content - Content of the second file.
 * @returns {string|null} - Markdown string representing the diff or null if identical.
 */
function generateMarkdownDiff(file1Content, file2Content) {
    const diffResult = diff.diffWords(file1Content, file2Content);

    // Check if files are identical
    const hasChanges = diffResult.some(part => part.added || part.removed);
    if (!hasChanges) {
        return null; // No differences found
    }

    let markdownDiff = '';

    diffResult.forEach(part => {
        if (part.added) {
            markdownDiff += `**+ ${part.value.trim()}**\n`; // Bold added text
        } else if (part.removed) {
            markdownDiff += `~~- ${part.value.trim()}~~\n`; // Strikethrough removed text
        }
        // Skip unchanged parts
    });

    return markdownDiff;
}

/**
 * Computes the diff and writes the Markdown diff to the output file.
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

        const markdownDiff = generateMarkdownDiff(file1Content, file2Content);

        // If no differences, do not write output
        if (!markdownDiff) {
            console.log("No differences found. No file generated.");
            return;
        }

        // Write the diff to the specified output file
        fs.writeFileSync(path.resolve(outputFilePath), markdownDiff, 'utf8');
        console.log(`✅ Diff written to ${outputFilePath}`);
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