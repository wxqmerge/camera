# OpenSCAD + Qwen3.6 Vision Workflow

## Setup

### OpenSCAD MCP Server
- Installed `uv` package manager (`C:\Users\wxqme\.local\bin`)
- Configured local MCP server with stdio transport
- `OPENSCAD_EXECUTABLE`: `C:\Program Files\OpenSCAD (Nightly)\openscad.exe`

### Llama.cpp Vision Server
- Model: `D:\models\Qwen3.6-27B-UD-Q5_K_XL.gguf`
- Vision projector: `D:\models\mmproj-BF16-27B.gguf`
- Batch file: `D:\llama.cpp.b9254\runq36MTP27B.bat`
- Required flags: `--alias "Qwen3.6-35B-A3B"`, `--image-min-tokens 1024`
- API key: `sk-123`

### Vision MCP Server
- Location: `D:\openscad\mcp-vision\src\index.js`
- Calls llama.cpp at `http://localhost:8080/v1/chat/completions`
- Tool: `vision_analyze_image` - analyzes PNG files and returns text description

## Workflow

1. Create `.scad` file
2. Render to PNG: `openscad.exe --imgsize 800,600 --viewall --render -o output.png file.scad`
3. Call `vision_analyze_image(path, prompt)` to get description
4. Iterate based on description

## Config Files

- `C:\Users\wxqme\.config\opencode\opencode.json` - Global OpenCode config
- `C:\Users\wxqme\.config\opencode\opencode.json.old` - Previous backup
- `D:\openscad\opencode.json` - Local MCP config (OpenSCAD server only)

## GSD Plugin Disabled

Renamed directories to disable:
- `command/` → `command_gsd_DISABLED/`
- `commands/gsd/` → `commands/gsd_DISABLED/`
- `get-shit-done/` → `get-shit-done_DISABLED/`
- `agents/gsd-*` → `agents_gsd_DISABLED/`
- `gsd-file-manifest.json` → `gsd-file-manifest_DISABLED.json`

## Notes

- `mmproj-BF16-27B.gguf` is the vision projector, not an MTP drafter
- `Qwen3.6-27B-UD-Q5_K_XL.gguf` contains baked-in MTP drafter
- `--ctx-size 103840` and `--spec-type draft-mtp` are active in batch file
- OpenCode platform blocks direct image input (bug), workaround is the vision MCP server
