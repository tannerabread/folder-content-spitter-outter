# Folder Content Spitter-Outer (FCSO)

## Overview

The **Folder Content Spitter-Outer (FCSO)** is a powerful shell-based tool for filtering files and folders in a directory tree. It allows you to:

- **Automatically exclude files and folders** using a `.foldercontentspitteroutterignore` file (similar to `.gitignore`).
- **Filter files/folders dynamically** by specifying them as command-line arguments.
- **Output contents of filtered files** into a single file with markdown code block formatting.
- **Highlight syntax** based on file extensions (e.g., `.js`, `.py`, `.ts`).
- **Exclude large or unnecessary files** from being processed.
- **Optionally disable `.gitignore`**: By default, the tool respects `.gitignore` in addition to the `.foldercontentspitteroutterignore` file, but you can disable this with `--no-gitignore`.
- **Print the directory tree**: You can print the full directory tree at the top of the output file with the `--print-tree` option, with or without `.gitignore` filtering.

---

## Features

- **.foldercontentspitteroutterignore**: Like `.gitignore`, this file allows you to specify files and folders that should always be excluded from processing.
- **Command-line filtering**: You can pass specific files or folders to include dynamically, after respecting both `.gitignore` and `.foldercontentspitteroutterignore` by default.
- **Automatic markdown formatting**: Outputs the contents of filtered files into a single file formatted in markdown with code blocks.
- **Dynamic syntax highlighting**: Detects and highlights code based on file extensions (e.g., JavaScript, Python, CSS).
- **Print the directory tree**: Use the `--print-tree` option to print the directory tree at the top of the output file, with or without `.gitignore` filtering.
- **Disable `.gitignore`**: You can bypass `.gitignore` by using the `--no-gitignore` flag. By default, the tool respects `.gitignore` and excludes files listed there, along with any specified in `.foldercontentspitteroutterignore`.

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

1. Run `fcso` from a folder to filter the current directory and respect both the `.gitignore` and `.foldercontentspitteroutterignore` files:
   ```bash
   fcso --output output.md
   ```

2. Use specific files or folders to filter:
   ```bash
   fcso --output output.md src/ README.md
   ```

3. Print the full directory tree at the top of the output file:
   ```bash
   fcso --output output.md --print-tree
   ```

4. Use filter-only mode to include only specific files/folders:
   ```bash
   fcso --output output.md --filter-only src/ README.md
   ```

5. Ignore `.gitignore` and process all files:
   ```bash
   fcso --output output.md --no-gitignore
   ```

### Advanced Usage:

- Create a `.foldercontentspitteroutterignore` file in your project folder. Example `.foldercontentspitteroutterignore`:
   ```text
   package-lock.json
   fonts/
   ```

- This will exclude `package-lock.json` and any folder named `fonts` from processing.
- You can still dynamically specify additional filters via the command line:
   ```bash
   fcso --output output.md src/ README.md
   ```

- You can also disable `.gitignore` filtering while still respecting `.foldercontentspitteroutterignore`:
   ```bash
   fcso --output output.md --no-gitignore
   ```

- Print the full directory tree:
   ```bash
   fcso --output output.md --print-tree
   ```

### Command-Line Options:
- `-o|--output <output_file>`: Specify the output file where the filtered content will be written.
- `-t|--print-tree`: Print the directory tree at the top of the output file.
- `-f|--filter-only`: Include only the specified files/folders for filtering.
- `--no-gitignore`: Disable `.gitignore` filtering.
- `[files/folders]`: Additional arguments that specify which files or folders to include.

---

## Example Workflow

```bash
# Add .foldercontentspitteroutterignore to your project
echo "package-lock.json" > .foldercontentspitteroutterignore
echo "node_modules/" >> .foldercontentspitteroutterignore

# Run fcso to output filtered content
fcso --output combined_output.md src/ README.md
```

This will exclude `package-lock.json` and `node_modules/` from the output and include only the contents from the `src` folder and `README.md`.

---

## License

MIT License
