# Folder Content Spitter-Outer (FCSO)

## Overview

The **Folder Content Spitter-Outer (FCSO)** is a powerful shell-based tool for filtering files and folders in a directory tree. It allows you to:

- **Automatically exclude files and folders** using a `.foldercontentspitteroutterignore` file (similar to `.gitignore`).
- **Filter files/folders dynamically** by specifying them as command-line arguments.
- **Output contents of filtered files** into a single file with markdown code block formatting.
- **Highlight syntax** based on file extensions (e.g., `.js`, `.py`, `.ts`).
- **Exclude large or unnecessary files** from being processed.

### Why Use FCSO?

If you've ever needed to combine files into a single document for processing or sharing while avoiding unnecessary files, FCSO is perfect for you. It automates the process of file filtering and content extraction, so you can focus on your work without manually traversing folders and excluding irrelevant files.

---

## Features

- **.foldercontentspitteroutterignore**: Like `.gitignore`, this file allows you to specify files and folders that should always be excluded from processing.
- **Command-line filtering**: You can pass specific files or folders to include dynamically, after respecting the `.foldercontentspitteroutterignore` file.
- **Automatic markdown formatting**: Outputs the contents of filtered files into a single file formatted in markdown with code blocks.
- **Dynamic syntax highlighting**: Detects and highlights code based on file extensions (e.g., JavaScript, Python, CSS).
- **Alias for ease of use**: You can automatically alias this tool to `fcso` on installation for quick access.

---

## Installation

### Via Homebrew

1. Add the custom tap:
   ```bash
   brew tap tannerabread/folder-content-spitter-outter
   ```

2. Install the tool:
   ```bash
   brew install fcso
   ```

3. The tool will automatically be aliased to `fcso`, so you can run it from any directory.

---

## Usage

### Basic Usage:

1. Run `fcso` from a folder to filter the current directory and respect the `.filterignore` file:
   ```bash
   fcso -o output.md
   ```

2. Use specific files or folders to filter:
   ```bash
   fcso -o output.md src/ README.md
   ```

### Advanced Usage:

- Create a `.filterignore` file in your project folder. Example `.filterignore`:
   ```text
   package-lock.json
   fonts/
   ```

- This will exclude `package-lock.json` and any folder named `fonts` from processing.
- You can still dynamically specify additional filters via the command line:
   ```bash
   fcso -o output.md src/ README.md
   ```

### Command-Line Options:
- `-o <output_file>`: Specify the output file where the filtered content will be written.
- `[files/folders]`: Additional arguments that specify which files or folders to include.

---

## Example Workflow

```bash
# Add .filterignore to your project
echo "package-lock.json" > .filterignore
echo "node_modules/" >> .filterignore

# Run fcso to output filtered content
fcso -o combined_output.md src/ README.md
```

This will exclude `package-lock.json` and `node_modules/` from the output and include only the contents from the `src` folder and `README.md`.

---

## License

MIT License
